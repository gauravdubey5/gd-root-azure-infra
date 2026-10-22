# Terraform State Management & Remote Backend Architecture

## 1. State Storage Architecture

Terraform state stores the mapping between your declarative configuration and real Azure resource IDs. Because state files may contain metadata, IPs, and computed attributes, remote state must be protected by multiple layers of security:

1. **Storage Account Security**:
   - `min_tls_version = "TLS1_2"`
   - `allow_blob_public_access = false`
   - `enable_https_traffic_only = true`
   - Blob encryption using Microsoft-managed keys (or customer-managed keys)
2. **Authentication & Authorization**:
   - Prefer Microsoft Entra ID (Azure AD) authentication (`use_azuread_auth = true`) rather than shared access keys.
   - Assign the **Storage Blob Data Contributor** role exclusively to the Azure DevOps Service Connection (Managed Identity / OIDC) and lead architects.
3. **State Locking**:
   - Azure Blob Storage backend automatically uses blob leases to implement mutual exclusion locking during `terraform plan` and `terraform apply`, preventing concurrent pipeline runs from corrupting state.

## 2. Bootstrapping the Remote Backend

Before initializing the remote backend, run the bootstrap script:

```powershell
.\scripts\bootstrap-backend.ps1 -SubscriptionId "8d88fca9-a389-4366-9e4e-d6aba02b4d33" -Location "eastus2"
```

Or using bash:

```bash
chmod +x ./scripts/bootstrap-backend.sh
./scripts/bootstrap-backend.sh
```

## 3. State Partitioning Strategy

State keys are logically partitioned per environment and stack to minimize blast radius:

```text
gd-parent-infra/dev.tfstate
gd-parent-infra/staging.tfstate
gd-parent-infra/prod.tfstate
```

## 4. State Backup & Disaster Recovery

- Enable **Blob versioning** and **Soft Delete** (minimum 30 days retention) on the storage account.
- In the event of state corruption, previous versions can be restored directly via Azure Portal or Azure CLI without data loss.
