<#
.SYNOPSIS
    Bootstraps the Azure Storage Account and Container for Terraform Remote State.

.DESCRIPTION
    Creates a dedicated Resource Group, Storage Account (LRS, TLS 1.2, Blob encryption),
    and a private container for storing Terraform remote state files.

.EXAMPLE
    .\bootstrap-backend.ps1 -SubscriptionId "8d88fca9-a389-4366-9e4e-d6aba02b4d33" -Location "eastus2"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId = "8d88fca9-a389-4366-9e4e-d6aba02b4d33",

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName = "rg-terraform-state-eastus2",

    [Parameter(Mandatory = $false)]
    [string]$StorageAccountPrefix = "sttfstate",

    [Parameter(Mandatory = $false)]
    [string]$ContainerName = "tfstate",

    [Parameter(Mandatory = $false)]
    [string]$Location = "eastus2"
)

$ErrorActionPreference = "Stop"

Write-Host "Setting subscription context to: $SubscriptionId" -ForegroundColor Cyan
az account set --subscription $SubscriptionId

Write-Host "Creating Resource Group: $ResourceGroupName in $Location..." -ForegroundColor Cyan
az group create --name $ResourceGroupName --location $Location --tags ManagedBy=TerraformBootstrap Project=CloudPlatform

# Generate unique storage account name (lowercase alphanumeric max 24 chars)
$UniqueSuffix = (Get-Random -Minimum 1000 -Maximum 9999).ToString()
$StorageAccountName = "$StorageAccountPrefix$UniqueSuffix"

Write-Host "Creating Secure Storage Account: $StorageAccountName..." -ForegroundColor Cyan
az storage account create `
    --name $StorageAccountName `
    --resource-group $ResourceGroupName `
    --location $Location `
    --sku Standard_LRS `
    --encryption-services blob `
    --min-tls-version TLS1_2 `
    --allow-blob-public-access false `
    --https-only true `
    --tags ManagedBy=TerraformBootstrap

Write-Host "Creating Blob Container: $ContainerName..." -ForegroundColor Cyan
az storage container create `
    --name $ContainerName `
    --account-name $StorageAccountName `
    --auth-mode login

Write-Host "`n=== Backend Bootstrap Complete ===" -ForegroundColor Green
Write-Host "Resource Group:       $ResourceGroupName"
Write-Host "Storage Account:      $StorageAccountName"
Write-Host "Container Name:       $ContainerName"
Write-Host "Location:             $Location"
Write-Host "`nInitialize Terraform with:" -ForegroundColor Yellow
Write-Host "terraform init -backend-config=`"resource_group_name=$ResourceGroupName`" -backend-config=`"storage_account_name=$StorageAccountName`" -backend-config=`"container_name=$ContainerName`" -backend-config=`"key=gd-parent-infra/dev.tfstate`""
