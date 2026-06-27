#!/bin/bash
# onInitAsync.sh — runs in the background after onInit.sh completes.
# The workstreams command returns immediately; this script outlives it.
# stdout/stderr are written to .async-init.log inside the workstream directory.
# Environment variables: WORKSTREAM_DIR, WORKSTREAM_NAME, WORKSTREAM_TYPE

set -e

repos=(
  "git@github.com:istio/istio.git"
  "git@github.com:istio/istio.io.git"
  "git@github.com:istio/api.git"
)

pids=()
for repo in "${repos[@]}"; do
  git clone "$repo" "$WORKSTREAM_DIR/$(basename "$repo" .git)" &
  pids+=($!)
done

failed=0
for pid in "${pids[@]}"; do
  if ! wait "$pid"; then
    failed=1
  fi
done

exit $failed
