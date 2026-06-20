# Hybrid Workload Platform Simulator (OCP Engineer Portfolio)

This repository demonstrates a complete, enterprise-grade hybrid workload platform running on a lightweight local Kubernetes cluster (`k3d`). It is designed to showcase the diverse skills required for an **OpenShift (OCP) Engineer**, combining Infrastructure as Code, Container Orchestration, Virtual Machine Lifecycle Management, GitOps, and Security.

---

## 🚀 Key Features & Enterprise Capabilities

1. **Infrastructure as Code (IaC)**
   - **Terraform**: Foundational AWS architecture (VPC, Subnets) ready for Red Hat OpenShift Service on AWS (ROSA).
   - **Bash & Ansible**: Automated local cluster provisioning, Role-Based Access Control (RBAC), and Namespace isolation.
2. **Hybrid Virtualization (KubeVirt)**
   - Deploys **OpenShift Virtualization (KubeVirt)** to host Linux Virtual Machines natively alongside Containers.
   - Includes VM Lifecycle Management (Snapshots & Restore).
   - *See `MIGRATION_STRATEGY.md` for VMware to OpenShift migration architecture.*
3. **App Deployment Paradigms**
   - **Raw Manifests**: Standard Kubernetes API deployments.
   - **Helm Charts**: Templated application packaging for dynamic environment scaling.
   - **Kustomize**: Base and Overlay patching for configuration management.
4. **CI/CD & GitOps**
   - **Continuous Integration**: GitHub Actions workflow for automated testing and container image building.
   - **Continuous Deployment (GitOps)**: **ArgoCD** orchestrates deployments by pulling manifests directly from this Git repository.
5. **Zero-Trust Security & Networking**
   - **Sealed Secrets**: Asymmetric encryption for secure GitOps credential management (Bitnami Sealed Secrets).
   - **Network Policies**: Restricts pod-to-pod communication.
   - **Ingress**: Exposes the microservice to the host network securely.

---

## 📂 Repository Structure

| Directory | Purpose |
| --- | --- |
| `00-terraform/` | Terraform modules for AWS VPC provisioning. |
| `01-automation/` | Bash scripts for `k3d` cluster creation and Ansible Playbooks for RBAC. |
| `02-kubevirt/` | KubeVirt Operator installation, VM manifests, Snapshots, and Restore templates. |
| `03-gitops/` | ArgoCD installation scripts, Sealed Secrets controller, and GitOps `Application` manifests. |
| `04-microservices/` | Node.js REST API source code, Dockerfile, Kustomize configurations, NetworkPolicies, and encrypted Secrets. |
| `05-helm-chart/` | Helm Chart templates and `values.yaml` for standardized application deployments. |
| `.github/workflows/` | CI Pipeline automation (GitHub Actions). |
| `demo.sh` | Interactive automation script to build the entire platform locally from scratch. |
| `MIGRATION_STRATEGY.md` | Architectural blueprint for VMware vSphere to KubeVirt migration using Red Hat MTV. |

---

## 🛠️ Prerequisites

To run this simulation locally, ensure you have the following installed on your machine:
- [Docker](https://www.docker.com/)
- [k3d](https://k3d.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- *(Optional)* [kubeseal](https://github.com/bitnami-labs/sealed-secrets) for creating new encrypted secrets.
- *(Optional)* [Terraform](https://developer.hashicorp.com/terraform/downloads) for testing IaC.

---

## 🏃‍♂️ How to Run (Local Demo)

You can build the entire foundational architecture by running the interactive demo script:

```bash
# Make the script executable
chmod +x demo.sh

# Run the interactive wrapper
./demo.sh
```

**What the demo script does:**
1. Creates a lightweight `k3d` cluster.
2. Applies Ansible RBAC policies.
3. Installs the KubeVirt Operator.
4. Installs ArgoCD (Core).

**Post-Demo (GitOps Activation):**
Once the infrastructure is up, you must configure ArgoCD to point to your fork/clone of this repository. Apply the applications inside `03-gitops/apps/` to trigger the GitOps sync for the Helm, Kustomize, and Raw Microservice deployments.
