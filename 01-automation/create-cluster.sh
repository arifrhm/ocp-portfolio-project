#!/bin/bash
set -e

CLUSTER_NAME="hybrid-platform"

echo "=========================================="
echo " Starting Hybrid Workload Platform Setup"
echo "=========================================="

# Check for required tools
for cmd in docker k3d kubectl ansible; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it first."
        exit 1
    fi
done

echo "-> All required tools are installed."

# Check if cluster already exists
if k3d cluster list | grep -q "^$CLUSTER_NAME "; then
    echo "-> Cluster '$CLUSTER_NAME' already exists. Skipping creation."
else
    echo "-> Creating k3d cluster: $CLUSTER_NAME"
    # Create cluster with 1 agent node and expose ports 80 and 443 to localhost
    k3d cluster create "$CLUSTER_NAME" \
        -p "80:80@loadbalancer" \
        -p "443:443@loadbalancer" \
        --agents 1
    echo "-> Cluster created successfully!"
fi

echo "-> Verifying cluster access..."
kubectl get nodes

echo "=========================================="
echo " Setup Complete. You can now run Ansible."
echo "=========================================="
