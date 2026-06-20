#!/bin/bash
set -e

echo "=========================================="
echo " Installing OpenShift Virtualization (KubeVirt)"
echo "=========================================="

# Define KubeVirt Version (using a stable recent version)
export VERSION=$(curl -s https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)
if [ -z "$VERSION" ]; then
    VERSION="v1.1.1" # Fallback version
fi

echo "-> Installing KubeVirt Operator (version $VERSION)..."
kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/kubevirt-operator.yaml

echo "-> Installing KubeVirt Custom Resources..."
kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/kubevirt-cr.yaml

echo "-> Enabling software emulation for KubeVirt (Safe default for nested virtualization on Mac)..."
kubectl -n kubevirt patch kubevirt kubevirt --type=merge --patch '{"spec":{"configuration":{"developerConfiguration":{"useEmulation":true}}}}'

echo "-> Waiting for KubeVirt components to be ready. This may take a few minutes..."
kubectl -n kubevirt wait kv kubevirt --for condition=Available --timeout=5m

echo "-> KubeVirt installed successfully!"
