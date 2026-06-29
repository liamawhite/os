#!/bin/bash
# onInitAsync.sh — runs in the background after onInit.sh completes.
# The workstreams command returns immediately; this script outlives it.
# stdout/stderr are written to .async-init.log inside the workstream directory.
# Environment variables: WORKSTREAM_DIR, WORKSTREAM_NAME, WORKSTREAM_TYPE

set -e

repos=(
    blog
    homelab
    licenser
    navigator
    train
    workstreams
    finance
    melodical
)

pids=()
for repo in "${repos[@]}"; do
    git clone "git@github.com:liamawhite/${repo}.git" "$WORKSTREAM_DIR/$repo" &
    pids+=($!)
done

failed=0
for pid in "${pids[@]}"; do
    if ! wait "$pid"; then
        failed=1
    fi
done

exit $failed
