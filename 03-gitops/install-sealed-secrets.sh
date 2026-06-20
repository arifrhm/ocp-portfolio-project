#!/bin/bash
set -e

echo "=========================================="
echo " Installing Bitnami Sealed Secrets"
echo "=========================================="

echo "-> Deploying Sealed Secrets Controller..."
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.5/controller.yaml

echo "-> Waiting for Controller to be ready..."
kubectl wait --for=condition=available deployment -l name=sealed-secrets-controller -n kube-system --timeout=5m

echo "-> Sealed Secrets Controller installed successfully!"
echo "-> You can now safely store encrypted passwords in Git using 'kubeseal'."
