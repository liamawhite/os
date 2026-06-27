#!/bin/bash
# onInitAsync.sh — runs in the background after onInit.sh completes.
# The workstreams command returns immediately; this script outlives it.
# stdout/stderr are written to .async-init.log inside the workstream directory.
# Environment variables: WORKSTREAM_DIR, WORKSTREAM_NAME, WORKSTREAM_TYPE
