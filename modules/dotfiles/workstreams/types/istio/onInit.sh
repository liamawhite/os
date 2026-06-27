#!/bin/bash
# onInit.sh — runs synchronously when a workstream is created; output is streamed
# to the terminal. The workstreams command does not return until this completes.
# Environment variables: WORKSTREAM_DIR, WORKSTREAM_NAME, WORKSTREAM_TYPE

touch "$WORKSTREAM_DIR/AGENTS.md"
printf '@AGENTS.md\n' > "$WORKSTREAM_DIR/CLAUDE.md"
