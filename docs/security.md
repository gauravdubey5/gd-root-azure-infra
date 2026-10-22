# Enterprise Security Baseline

## 1. Network Security & Zero Trust

- **No Public Administrative Access**: Never open SSH (port 22) or RDP (port 3389) to the public internet (`0.0.0.0/0`). Use Azure Bastion, private endpoints, or VPN gateways for secure administrative jump access.
- **Micro-segmentation**: Isolate workloads into dedicated subnets with restrictive NSG rules applied at the subnet boundary.
- **Service Endpoints & Private Endpoints**: Route traffic to Azure PaaS services (Key Vault, Storage, SQL) over the Azure private backbone instead of traversing the public internet.

## 2. Identity & Access Management

- **Managed Identities**: Workloads running in Azure (VMs, Container Apps, App Service) should use User-Assigned Managed Identities instead of credentials or access keys.
- **Workload Identity Federation**: Azure DevOps pipelines authenticate to Azure using OpenID Connect (OIDC) federation, eliminating the need for long-lived service principal client secrets.
- **Least Privilege RBAC**: Assign granular built-in Azure RBAC roles scoped to the specific resource group or resource rather than subscription-wide Owner or Contributor.

## 3. Secrets Management

- Zero plain-text credentials in Git or Terraform code.
- Store sensitive values in Azure Key Vault. Reference them via data sources or Key Vault Secret IDs.

## 4. Deletion Protection

- Apply `CanNotDelete` Azure management locks to production Resource Groups and critical stateful databases to prevent accidental deletion during automated cleanups or manual portal actions.
