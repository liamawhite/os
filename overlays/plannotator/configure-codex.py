"""Merge the Nix-managed Plannotator hook into Codex's mutable configuration."""

import json
import os
from pathlib import Path
import shlex
import sys
import tempfile

import tomlkit


def write_if_changed(path, content):
    if path.exists() and path.read_text() == content:
        return
    # Follow existing symlinks so an externally managed config is not replaced.
    target = path.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(mode="w", dir=target.parent, delete=False) as stream:
        temporary = Path(stream.name)
        stream.write(content)
    try:
        if target.exists():
            temporary.chmod(target.stat().st_mode & 0o777)
        os.replace(temporary, target)
    finally:
        temporary.unlink(missing_ok=True)


def configure(home, command):
    codex = Path(os.environ.get("CODEX_HOME") or Path(home) / ".codex")
    config_path = codex / "config.toml"
    hooks_path = codex / "hooks.json"
    config = tomlkit.parse(config_path.read_text()) if config_path.exists() else tomlkit.document()
    hooks = json.loads(hooks_path.read_text()) if hooks_path.exists() else {}

    config.setdefault("features", {})["hooks"] = True
    stop = hooks.setdefault("hooks", {}).setdefault("Stop", [])
    found = False
    for group in stop:
        for hook in group.get("hooks", []):
            argv = shlex.split(hook.get("command", ""))
            if hook.get("type") == "command" and len(argv) == 1 and Path(argv[0]).name == "plannotator":
                hook.update(command=command, timeout=345600)
                found = True
    if not found:
        stop.append({"hooks": [{"type": "command", "command": command, "timeout": 345600}]})

    # Parse both files before writing either one.
    write_if_changed(hooks_path, json.dumps(hooks, indent=2) + "\n")
    write_if_changed(config_path, tomlkit.dumps(config))


if __name__ == "__main__":
    configure(*sys.argv[1:])
