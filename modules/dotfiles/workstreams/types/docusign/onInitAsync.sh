#!/bin/bash
# onInitAsync.sh — runs in the background after onInit.sh completes.
# The workstreams command returns immediately; this script outlives it.
# stdout/stderr are written to .async-init.log inside the workstream directory.
# Environment variables: WORKSTREAM_DIR, WORKSTREAM_NAME, WORKSTREAM_TYPE

set -e

repos=(
  "git@github.docusignhq.com:Microservices/network-edge-knowledgebase.git"
  "git@github.docusignhq.com:Microservices/ds-istio-wasm.git"
  "git@github.docusignhq.com:Microservices/ds-microservice-shared-chart.git"
  "git@github.docusignhq.com:Microservices/ds-microservice-simple-chart.git"
  "git@github.docusignhq.com:Microservices/msf-tools.git"
  "git@github.docusignhq.com:traffic-mgmt/network-edge-msf-alerting.git"
  "git@github.docusignhq.com:Microservices/terraform-platform-provisioning.git"
  "git@github.docusignhq.com:Microservices/terraform-system-compute-provisioning.git"
  "git@github.docusignhq.com:Microservices/topology.git"
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
