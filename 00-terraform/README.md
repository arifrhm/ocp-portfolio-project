# Infrastructure as Code: Terraform Foundation

This directory contains foundational Terraform modules to provision the underlying AWS infrastructure (VPC, Subnets, Routing) required to install **Red Hat OpenShift Service on AWS (ROSA)** or a custom Kubernetes/OpenShift cluster.

> **Note:** These files are for demonstration purposes and are not applied automatically via the demo script to prevent unexpected AWS cloud charges.

## Usage
1. Configure AWS CLI credentials.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan the infrastructure:
   ```bash
   terraform plan
   ```
4. Apply the configuration:
   ```bash
   terraform apply
   ```
