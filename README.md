# Hybrid Workload Platform Simulator

This project demonstrates a hybrid workload platform (Container + Virtual Machines) running on a lightweight local Kubernetes cluster (k3d), provisioned using GitOps (ArgoCD) and Ansible.

**Built for**: OCP Engineer Portfolio Showcase.

## 🚀 Architecture
- **Infrastructure**: k3d (Kubernetes in Docker) for a lightweight footprint.
- **Automation**: Ansible & Bash scripts to provision the cluster and RBAC.
- **Virtualization**: OpenShift Virtualization / KubeVirt running a lightweight CirrOS VM.
- **GitOps**: ArgoCD managing application deployments from this repository.
- **Microservices**: A sample Node.js API demonstrating application modernization.

## 🛠️ Prerequisites
- [Docker](https://www.docker.com/) (Ensure Docker Desktop is running)
- [k3d](https://k3d.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 📖 Setup Guide

### 1. Provision the Cluster
Run the automation script to create the k3d cluster:
```bash
./01-automation/create-cluster.sh
```

Apply the Ansible Playbook to setup Namespaces and RBAC:
```bash
ansible-playbook 01-automation/ansible/setup-rbac.yml
```

### 2. Install KubeVirt & Deploy VM
Run the script to install the KubeVirt Operator:
```bash
./02-kubevirt/install.sh
```

Deploy the lightweight Virtual Machine:
```bash
kubectl apply -f 02-kubevirt/vm-cirros.yaml
```
Verify the VM is running:
```bash
kubectl get vmi -n kubevirt-workloads
```

### 3. Build & Load the Microservice
Build the Docker image locally:
```bash
cd 04-microservices
docker build -t demo-microservice:latest .
```
Load the image into the k3d cluster:
```bash
k3d image import demo-microservice:latest -c hybrid-platform
cd ..
```

### 4. Setup GitOps (ArgoCD)
Install ArgoCD (Core version):
```bash
./03-gitops/install-argocd.sh
```

**IMPORTANT**: Before applying the ArgoCD application, push this entire project to your own GitHub repository. Then, update the `repoURL` in `03-gitops/apps/microservice-app.yaml` to point to your repository.

Deploy the GitOps application:
```bash
kubectl apply -f 03-gitops/apps/microservice-app.yaml
```

ArgoCD will now automatically deploy and sync the `04-microservices/k8s.yaml` manifests!
