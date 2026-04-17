#!/usr/bin/env bash
set -euo pipefail

NS="rbih-payments"

echo "Checking deployments..."
kubectl -n "$NS" rollout status deploy/payment-gateway --timeout=120s
kubectl -n "$NS" rollout status deploy/payment-processor --timeout=120s

echo "Checking services..."
kubectl -n "$NS" get svc payment-gateway payment-processor

echo "Checking endpoints..."
kubectl -n "$NS" get endpoints payment-gateway payment-processor

echo "Smoke test completed successfully."
