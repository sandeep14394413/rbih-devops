#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="rbih-devops"

cat <<CFG | kind create cluster --name "$CLUSTER_NAME" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
CFG

echo "Cluster created: $CLUSTER_NAME"
echo "Install ingress controller if desired, then apply manifests with: kubectl apply -k k8s/overlays/dev"
