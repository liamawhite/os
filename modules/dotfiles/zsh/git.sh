#! /bin/bash

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
# eval "$(ssh-agent -s)" > /dev/null

worktree() {
    local cmd="$1"
    
    # Commands that should change directory
    if [[ "$cmd" == "add" || "$cmd" == "switch" || "$cmd" == "sw" || "$cmd" == "setup" ]]; then
        # Capture stderr to look for WT_CHDIR while preserving stdout and interactive TUI
        local temp_file
        temp_file=$(mktemp)
        
        # Run command with stderr redirected to temp file
        command worktree "$@" 2> >(tee "$temp_file" >&2)
        local exit_code=$?
        
        # Look for directory change indicator in stderr
        local target_dir
        target_dir=$(grep "^WT_CHDIR:" "$temp_file" 2>/dev/null | sed 's/^WT_CHDIR://')
        
        # Clean up temp file
        rm -f "$temp_file"
        
        # Change directory if target was specified
        if [[ -n "$target_dir" && -d "$target_dir" ]]; then
            cd "$target_dir" || echo "Warning: Failed to change to directory: $target_dir"
        fi
        
        return $exit_code
    else
        # For all other commands, just run normally
        command worktree "$@"
    fi
}

workstreams() {
    local cmd="$1"

    # Commands that may change the working directory
    if [[ "$cmd" == "add" || "$cmd" == "switch" || "$cmd" == "sw" || "$cmd" == "remove" || "$cmd" == "rm" ]]; then
        local temp_file
        temp_file=$(mktemp)

        # Run command with stderr redirected to temp file while still displaying it
        command workstreams "$@" 2> >(tee "$temp_file" >&2)
        local exit_code=$?

        # Look for directory change indicator in stderr
        local target_dir
        target_dir=$(grep "^WS_CHDIR:" "$temp_file" 2>/dev/null | sed 's/^WS_CHDIR://')

        rm -f "$temp_file"

        if [[ -n "$target_dir" && -d "$target_dir" ]]; then
            cd "$target_dir" || echo "Warning: Failed to change to directory: $target_dir"
        fi

        return $exit_code
    else
        command workstreams "$@"
    fi
}

# Completion support (if the binary supports it)
if command -v workstreams >/dev/null 2>&1; then
    complete -F _workstreams workstreams 2>/dev/null || true
fi
