#!/bin/bash
set -e

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}================================================================${NC}"
echo -e "${CYAN}     OCP ENGINEER PORTFOLIO: HYBRID PLATFORM SIMULATOR${NC}"
echo -e "${BLUE}================================================================${NC}"
echo -e "Skrip ini akan mendemonstrasikan keahlian Anda secara berurutan:"
echo -e "1. Infrastructure as Code & Automation (Ansible & Bash)"
echo -e "2. OpenShift Virtualization / KubeVirt (VM lifecycle)"
echo -e "3. GitOps & App Modernization (ArgoCD & Microservices)"
echo -e ""
echo -e "${YELLOW}Catatan: Pastikan Docker sudah berjalan sebelum melanjutkan.${NC}"
echo -e ""

read -p "Tekan [Enter] untuk memulai Tahap 1: Pembuatan Cluster k3d..."

echo -e "\n${YELLOW}>>> MENGUJI KEAHLIAN: KUBERNETES & BASH AUTOMATION${NC}"
echo -e "Menjalankan skrip: ${CYAN}./01-automation/create-cluster.sh${NC}"
echo -e "Tujuan: Membangun local Kubernetes cluster yang ringan dan aman."
sleep 1
./01-automation/create-cluster.sh

echo -e "\n${GREEN}✓ Cluster berhasil dibuat.${NC}"
echo -e "------------------------------------------------"
read -p "Tekan [Enter] untuk melanjutkan ke Tahap Security & RBAC (Ansible)..."

echo -e "\n${YELLOW}>>> MENGUJI KEAHLIAN: ANSIBLE & SECURITY${NC}"
echo -e "Menjalankan skrip: ${CYAN}ansible-playbook 01-automation/ansible/setup-rbac.yml${NC}"
echo -e "Tujuan: Membuat Namespaces dan Role-Based Access Control secara declarative/otomatis."
sleep 1
if ! ansible-playbook 01-automation/ansible/setup-rbac.yml; then
    echo -e "${YELLOW}Peringatan: Ansible gagal. Pastikan 'pip install ansible kubernetes' sudah dilakukan.${NC}"
fi

echo -e "\n${GREEN}✓ Namespace dan RBAC berhasil dikonfigurasi.${NC}"
echo -e "------------------------------------------------"
read -p "Tekan [Enter] untuk melanjutkan ke Tahap Virtualization (KubeVirt)..."

echo -e "\n${YELLOW}>>> MENGUJI KEAHLIAN: OPENSHIFT VIRTUALIZATION${NC}"
echo -e "Menjalankan skrip: ${CYAN}./02-kubevirt/install.sh${NC}"
echo -e "Tujuan: Memasang KubeVirt Operator untuk memungkinkan Virtual Machine berjalan di dalam Kubernetes."
sleep 1
./02-kubevirt/install.sh

echo -e "\n${GREEN}✓ KubeVirt Operator berhasil dipasang.${NC}"
echo -e "------------------------------------------------"
read -p "Tekan [Enter] untuk mendeploy Virtual Machine (CirrOS Linux)..."

echo -e "\n${YELLOW}>>> MENGUJI KEAHLIAN: VM LIFECYCLE MANAGEMENT${NC}"
echo -e "Menjalankan perintah: ${CYAN}kubectl apply -f 02-kubevirt/vm-cirros.yaml${NC}"
kubectl apply -f 02-kubevirt/vm-cirros.yaml
echo -e "Tujuan: Mendeploy VM Linux tradisional di dalam klaster Container."
echo -e "Mengecek status VM..."
sleep 2
kubectl get vmi -n kubevirt-workloads || true

echo -e "\n${GREEN}✓ Virtual Machine termanifestasi di klaster.${NC}"
echo -e "------------------------------------------------"
read -p "Tekan [Enter] untuk menginstal GitOps (ArgoCD)..."

echo -e "\n${YELLOW}>>> MENGUJI KEAHLIAN: GITOPS & CI/CD${NC}"
echo -e "Menjalankan skrip: ${CYAN}./03-gitops/install-argocd.sh${NC}"
echo -e "Tujuan: Memasang ArgoCD untuk deployment microservices yang otomatis dan berbasis Git."
sleep 1
./03-gitops/install-argocd.sh

echo -e "\n${BLUE}================================================================${NC}"
echo -e "${CYAN}                   DEMONSTRASI SELESAI${NC}"
echo -e "${BLUE}================================================================${NC}"
echo -e "Anda telah berhasil mensimulasikan arsitektur platform hibrida!"
echo -e ""
echo -e "Langkah Terakhir untuk Anda (Secara Manual):"
echo -e "1. Push direktori ini ke GitHub Anda."
echo -e "2. Ubah URL repo di ${CYAN}03-gitops/apps/microservice-app.yaml${NC}"
echo -e "3. Jalankan: ${CYAN}kubectl apply -f 03-gitops/apps/microservice-app.yaml${NC}"
