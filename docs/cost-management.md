# Cost Management & Safe Deployment Policies

## 1. Cost Management Principles

1. **Minimal Dev Baseline**: The initial baseline scope contains zero-cost infrastructure primitives:
   - Resource Group: **$0.00**
   - Virtual Network: **$0.00**
   - Subnets: **$0.00**
   - Network Security Group: **$0.00**
   - Total Ongoing Cost: **$0.00 / month**

2. **Chargeable Resources Require Explicit Approval**:
   Any resource that carries ongoing or compute charges must remain disabled or optional until explicitly requested by engineering leads:
   - Virtual Machines & Managed OS Disks
   - Public IPs & NAT Gateways
   - Application Gateways & Load Balancers
   - Azure Container Apps & Environments
   - App Service Plans & Apps
   - Relational Databases (PostgreSQL, MySQL, SQL Server/DB)
   - Azure Firewall & Front Door

3. **Mandatory Plan Review**:
   Never run `terraform apply` blindly. Always execute `terraform plan` to review resource additions, replacements, and destroyed resources before taking action.

4. **Resource Tagging for Cost Attribution**:
   Every resource inherits standardized cost tags (`Environment`, `Project`, `CostCenter`, `Owner`) for Azure Cost Management & Billing breakdowns.
