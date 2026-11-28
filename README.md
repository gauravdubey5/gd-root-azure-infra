# gd-root-azure-infra: Azure Infrastructure Orchestrator

Enterprise Azure Infrastructure as Code (IaC) root orchestrator repository built with Terraform (`>= 1.5.0, < 2.0.0`) and modular private child GitHub repositories under account **`gauravdubey5`**.

---

## 1. Architecture Overview

This project implements the **Root–Child Repository Architecture**, separating infrastructure into single-responsibility, independently versioned child modules consumed by this central root orchestrator via pinned Git release tags (`?ref=v...`).

```text
GitHub Account: gauravdubey5
│
├── gd-root-azure-infra (Public Root Orchestrator)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── versions.tf
│   ├── terraform.tfvars
│   ├── .github/workflows/
│   │   ├── ci.yaml
│   │   └── cd.yaml
│   └── README.md
│
├── Foundation & Security (Private Child Repos)
│   ├── gd-child-rg
│   └── gd-child-keyvault
│
├── Networking (Private Child Repos)
│   ├── gd-child-vnet
│   ├── gd-child-subnet
│   ├── gd-child-nsg
│   ├── gd-child-route-table
│   ├── gd-child-public-ip
│   ├── gd-child-nat-gateway
│   ├── gd-child-nic
│   ├── gd-child-lb
│   ├── gd-child-app-gateway
│   ├── gd-child-vnet-peering
│   └── gd-child-private-endpoint
│
├── Compute & Web Platform (Private Child Repos)
│   ├── gd-child-os-disk
│   ├── gd-child-vm
│   ├── gd-child-app-services
│   └── gd-child-web-app
│
└── Storage & Databases (Private Child Repos)
    ├── gd-child-storage-account
    └── gd-child-postgresql-database
```

---

## 2. Child Module Catalog (19 Modules)

All child modules are hosted in **private** repositories under `gauravdubey5` and referenced in [`main.tf`](./main.tf) using pinned semantic version tags:

| # | Module Block | Source Repository | Pinned Tag | Input Variable | Purpose |
|---:|---|---|---:|---|---|
| 1 | `module.rg` | [`gd-child-rg`](https://github.com/gauravdubey5/gd-child-rg) | `v1.0.4` | `var.rg` | Azure Resource Groups |
| 2 | `module.vnet` | [`gd-child-vnet`](https://github.com/gauravdubey5/gd-child-vnet) | `v1.0.4` | `var.vnet` | Azure Virtual Networks |
| 3 | `module.subnet` | [`gd-child-subnet`](https://github.com/gauravdubey5/gd-child-subnet) | `v1.0.4` | `var.subnets` | Subnets within Virtual Networks |
| 4 | `module.nsg` | [`gd-child-nsg`](https://github.com/gauravdubey5/gd-child-nsg) | `v1.0.4` | `var.nsg` | Network Security Groups |
| 5 | `module.route_table` | [`gd-child-route-table`](https://github.com/gauravdubey5/gd-child-route-table) | `v1.0.4` | `var.route_tables` | Route Tables, custom routes, and BGP propagation |
| 6 | `module.pip` | [`gd-child-public-ip`](https://github.com/gauravdubey5/gd-child-public-ip) | `v1.0.4` | `var.pip` | Public IP addresses |
| 7 | `module.nat_gateway` | [`gd-child-nat-gateway`](https://github.com/gauravdubey5/gd-child-nat-gateway) | `v1.0.4` | `var.nat_gateways` | NAT Gateways with Public IP and Subnet associations |
| 8 | `module.nic` | [`gd-child-nic`](https://github.com/gauravdubey5/gd-child-nic) | `v1.0.4` | `var.nic` | Network Interfaces with subnet and Public IP lookups |
| 9 | `module.lb` | [`gd-child-lb`](https://github.com/gauravdubey5/gd-child-lb) | `v1.0.0` | `var.load_balancers` | Azure Load Balancers, backend pools, and health probes |
| 10 | `module.app_gateway` | [`gd-child-app-gateway`](https://github.com/gauravdubey5/gd-child-app-gateway) | `v1.0.0` | `var.application_gateways` | Application Gateways (v2) with HTTP listeners and routing rules |
| 11 | `module.os_disk` | [`gd-child-os-disk`](https://github.com/gauravdubey5/gd-child-os-disk) | `v1.0.0` | `var.managed_disks` | Managed Disks and optional VM data disk attachments |
| 12 | `module.vm` | [`gd-child-vm`](https://github.com/gauravdubey5/gd-child-vm) | `v1.0.0` | `var.virtual_machines` | Linux Virtual Machines with NIC lookups and SSH/password auth |
| 13 | `module.vnet_peering` | [`gd-child-vnet-peering`](https://github.com/gauravdubey5/gd-child-vnet-peering) | `v1.0.0` | `var.vnet_peerings` | Virtual Network Peerings with ID or remote VNet name lookup |
| 14 | `module.storage_account` | [`gd-child-storage-account`](https://github.com/gauravdubey5/gd-child-storage-account) | `v1.0.0` | `var.storage_accounts` | Storage Accounts (TLS 1.2, HTTPS-only, network rules) and containers |
| 15 | `module.app_service_plan` | [`gd-child-app-services`](https://github.com/gauravdubey5/gd-child-app-services) | `v1.0.0` | `var.app_service_plans` | App Service Plans (`azurerm_service_plan`) for Linux/Windows apps |
| 16 | `module.web_app` | [`gd-child-web-app`](https://github.com/gauravdubey5/gd-child-web-app) | `v1.0.0` | `var.web_apps` | Linux and Windows Web Apps with Managed Identity and HTTPS-only |
| 17 | `module.postgresql_database` | [`gd-child-postgresql-database`](https://github.com/gauravdubey5/gd-child-postgresql-database) | `v1.0.0` | `var.postgresql_servers` | PostgreSQL Flexible Servers and logical databases |
| 18 | `module.key_vault` | [`gd-child-keyvault`](https://github.com/gauravdubey5/gd-child-keyvault) | `v1.0.0` | `var.key_vaults` | Azure Key Vaults with RBAC authorization and network ACLs |
| 19 | `module.private_endpoint` | [`gd-child-private-endpoint`](https://github.com/gauravdubey5/gd-child-private-endpoint) | `v1.0.0` | `var.private_endpoints` | Private Endpoints and Private DNS Zone Group associations |

> **Note:** Every child variable in [`variables.tf`](./variables.tf) (except `rg` and `vnet`) defaults to `{}`, allowing modules to be enabled selectively via `terraform.tfvars` without forcing unwanted resource provisioning.

---

## 3. Prerequisites & Private Module Access

- **Terraform CLI**: `>= 1.5.0, < 2.0.0`
- **AzureRM Provider**: `>= 3.75.0, < 5.0.0` (locked at `4.81.0` in `.terraform.lock.hcl`)
- **Azure CLI**: `az` installed and authenticated to the target subscription
- **Authenticated Git Access**: Because all `gd-child-*` repositories are **private**, `terraform init` requires GitHub authentication:
  - **Local development**: Sign in via `gh auth login` or Git Credential Manager so `git::https://github.com/gauravdubey5/gd-child-*.git` can clone during `terraform init`.
  - **CI/CD runners**: Configure a GitHub Personal Access Token (PAT) or SSH key with read access to the `gd-child-*` repositories.

---

## 4. Quick Start: Local Workflow

### 4.1 Authenticate to Azure

```bash
az login
az account set --subscription "<your-subscription-id>"
```

### 4.2 Initialize Modules & Providers

```bash
cd gd-root-azure-infra
terraform init -upgrade
```

### 4.3 Format, Validate, and Plan

```bash
terraform fmt -check
terraform validate
terraform plan -out="dev.tfplan"
```

### 4.4 Apply Infrastructure (Requires Explicit Authorization)

```bash
terraform apply "dev.tfplan"
```

---

## 5. Outputs & Sensitive Data Handling

Outputs in [`outputs.tf`](./outputs.tf) expose created resources across all 19 modules:

- **Sensitive outputs** (`sensitive = true`): `virtual_machines`, `storage_accounts`, `postgresql_servers` (contain credentials or access keys).
- **Non-sensitive helper outputs**: `storage_account_ids`, `web_app_ids`, `web_app_default_hostnames`, and `postgresql_server_fqdns` are exported separately for safe downstream consumption and inspection.

---

## 6. CI/CD Pipelines (GitHub Actions)

- **[`.github/workflows/ci.yaml`](./.github/workflows/ci.yaml)**: Runs `terraform fmt -check`, `terraform init -backend=false`, and `terraform validate` on pushes/PRs, plus automated PR plans with summary comments when Azure OIDC secrets are configured.
- **[`.github/workflows/cd.yaml`](./.github/workflows/cd.yaml)**: Runs validation, generates a plan artifact, and applies changes against target GitHub Environments (`dev`, `staging`, `prod`) on merges to `main` or manual `workflow_dispatch`.

### Required GitHub Secrets

- `GH_PAT`: GitHub PAT with read access to the private `gd-child-*` repositories.
- `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`: Azure Workload Identity (OIDC) credentials for `azure/login@v2`.

---

## 7. Branch Protection & Module Upgrade Workflow

The `main` branch of `gd-root-azure-infra` is protected by a repository ruleset that blocks direct pushes, force pushes, and branch deletions, requiring a **Pull Request** for all changes.

### Making Changes to Root Infrastructure

```bash
git checkout -b feat/<short-description>
# Edit configuration and verify with terraform fmt -check && terraform validate
git add <files>
git commit -m "feat: <description>"
git push -u origin feat/<short-description>
gh pr create --base main --fill
```

### Upgrading a Child Module Version

1. Release and tag the updated child module repository (e.g., `v1.1.0`).
2. Create a feature branch in `gd-root-azure-infra` and update the pinned tag in [`main.tf`](./main.tf):
   ```hcl
   module "vnet" {
     source = "git::https://github.com/gauravdubey5/gd-child-vnet.git?ref=v1.1.0"
     ...
   }
   ```
3. Run `terraform init -upgrade`, `terraform validate`, and `terraform plan` to verify the diff.
4. Push the branch and open a Pull Request into `main`.
