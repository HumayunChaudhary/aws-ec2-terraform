# Terraform EC2 Setup

## Prerequisites

- Terraform installed
- AWS credentials configured
- SSH private key available locally

---

## Step 1: Generate Public Key
If you only have a private key, generate the public key:

`ssh-keygen -y -f /path/to/private_key > public_key.pub`

## Step 2: Initialize Terraform
Download the required plugins:

terraform init

## Step 3: Plan Infrastructure
Preview changes before applying:

terraform plan -var-file=prod.tfvars

## Step 4: Apply Infrastructure
Provision resources:

terraform apply -var-file=prod.tfvars
