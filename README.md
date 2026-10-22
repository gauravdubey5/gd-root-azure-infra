# gd-parent-azure-infra: Azure Infrastructure Orchestrator

Enterprise Azure Infrastructure as Code (IaC) parent orchestrator repository built with Terraform and modular child GitHub repositories under account **`gauravdubey5`**.

---

## 1. Architecture Overview

This project implements the **Parent–Child Repository Architecture**, separating infrastructure into single-responsibility, independently versioned child modules, orchestrated by this central parent repository.

```text
GitHub Account: gauravdubey5
│
├── gd-parent-azure-infra (Orchestrator)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── versions.tf
│   ├── backend.tf.example
│   ├── environments/ (dev.tfvars, staging.tfvars, prod.tfvars)
│   ├── pipelines/    (Azure DevOps CI/CD)
│   ├── scripts/      (Backend bootstrapping)
│   └── docs/         (Architecture, security, state, cost)
│
├── gd-child-rg        (Azure Resource Group module)
├── gd-child-vnet      (Azure Virtual Network module)
├── gd-child-nsg       (Azure Network Security Group module)
└── gd-child-subnet    (Azure Subnet module)
```

---

## 2. Child Module Repositories & Release Links

| Module | Source Repository | Pinned Version | Purpose |
|---|---|:---:|---|
| Resource Group | [`gd-child-rg`](https://github.com/gauravdubey5/gd-child-rg) | `v1.0.0` | Resource Group with deletion locks and tagging |
| Virtual Network | [`gd-child-vnet`](https://github.com/gauravdubey5/gd-child-vnet) | `v1.0.0` | Multi-CIDR virtual network with DNS options |
| Network Security Group | [`gd-child-nsg`](https://github.com/gauravdubey5/gd-child-nsg) | `v1.0.0` | NSG with typed, validated security rules |
| Subnet | [`gd-child-subnet`](https://github.com/gauravdubey5/gd-child-subnet) | `v1.0.0` | Subnets with automated NSG and route associations |

---

## 3. Prerequisites

- **Terraform CLI**: `>= 1.5.0` (Tested on `1.14.6` and `1.9.0`)
- **Azure CLI**: `az` CLI installed and authenticated
- **Git**: Installed and configured

---

## 4. Quick Start: Local Deployment Workflow

### 4.1 Authenticate to Azure

```bash
az login
az account set --subscription "8d88fca9-a389-4366-9e4e-d6aba02b4d33"
```

### 4.2 Initialize Backend & Modules

To test locally without remote state:

```bash
cd gd-parent-azure-infra
terraform init -backend=false
```

To initialize with remote Azure Blob Storage backend:

```bash
terraform init \
  -backend-config="resource_group_name=rg-terraform-state-eastus2" \
  -backend-config="storage_account_name=sttfstategd001" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=gd-parent-infra/dev.tfstate"
```

### 4.3 Validate Code & Synthesize Plan

```bash
# Format and validate
terraform fmt -check
terraform validate

# Plan against Development environment
terraform plan -var-file="environments/dev.tfvars" -out="dev.tfplan"
```

### 4.4 Apply Infrastructure (Requires Authorization)

```bash
terraform apply "dev.tfplan"
```

---

## 5. Environment Configurations

| Environment | Config File | Features |
|---|---|---|
| **Dev** | [`environments/dev.tfvars`](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/environments/dev.tfvars) | Minimal footprint, zero-cost network foundation |
| **Staging** | [`environments/staging.tfvars`](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/environments/staging.tfvars) | Mirror topology for pre-production validation |
| **Prod** | [`environments/prod.tfvars`](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/environments/prod.tfvars) | Deletion locks enabled (`CanNotDelete`), high compliance |

---

## 6. Remote State Bootstrapping & Recovery

1. Run the bootstrap script located in `scripts/`:
   ```powershell
   .\scripts\bootstrap-backend.ps1 -SubscriptionId "8d88fca9-a389-4366-9e4e-d6aba02b4d33" -Location "eastus2"
   ```
2. Blob soft delete (30 days) and blob versioning protect state files against accidental overwrites.
3. Review [State Management Documentation](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/docs/state-management.md) for details.

---

## 7. Azure DevOps CI/CD Pipelines

- **`pipelines/terraform-validate.yml`**: Triggers on pull requests; executes `terraform fmt`, `terraform init`, and `terraform validate`.
- **`pipelines/terraform-plan.yml`**: Manual or trigger-based plan generation using Azure Workload Identity Federation (OIDC); outputs plan summary artifacts.
- **`pipelines/terraform-apply.yml`**: Environment-gated release pipeline requiring manual approval before production deployment.

---

## 8. Security & Cost Controls

- **Zero-Trust Networking**: No public SSH or RDP access is exposed by default.
- **Phase 1 Baseline Cost**: **$0.00 / month** (Resource Groups, VNets, Subnets, and NSGs are free in Azure).
- **Safe Guarding**: Chargeable compute, public IPs, and databases are strictly gated and disabled in the base development scope.
- Review [Security Baseline](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/docs/security.md) and [Cost Management](file:///c:/Users/GAURAV/Desktop/infra/gd-parent-azure-infra/docs/cost-management.md) for full policies.

---

## 9. Module Version Upgrade Procedure

To upgrade a child module:
1. Update and test the child repository, then tag a new semantic release (e.g. `v1.1.0`).
2. In `gd-parent-azure-infra/main.tf`, update the pinned Git tag reference:
   ```hcl
   module "vnet" {
     source = "git::https://github.com/gauravdubey5/gd-child-vnet.git?ref=v1.1.0"
     ...
   }
   ```
3. Run `terraform init -upgrade` to download the new version.
4. Run `terraform plan` to verify intended diffs before applying.
