#!/bin/bash
set -e

echo "=========================================="
echo " Installing ArgoCD (GitOps)"
echo "=========================================="

kubectl create namespace argocd || true

# Install ArgoCD Core (Lightweight version without UI to save RAM)
echo "-> Deploying ArgoCD Core..."
kubectl apply --server-side --force-conflicts -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml

echo "-> Waiting for ArgoCD components to be ready..."
kubectl wait --for=condition=available deployment -l app.kubernetes.io/name=argocd-repo-server -n argocd --timeout=5m
kubectl wait --for=condition=available deployment -l app.kubernetes.io/name=argocd-application-controller -n argocd --timeout=5m

echo "-> ArgoCD installed successfully!"
echo "-> Note: We are using ArgoCD Core which uses the CLI instead of the Web UI to conserve RAM."
