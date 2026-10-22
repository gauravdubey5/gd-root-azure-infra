#!/usr/bin/env bash
# Bootstraps the Azure Storage Account and Container for Terraform Remote State.

set -euo pipefail

SUBSCRIPTION_ID="${1:-8d88fca9-a389-4366-9e4e-d6aba02b4d33}"
RESOURCE_GROUP_NAME="${2:-rg-terraform-state-eastus2}"
STORAGE_PREFIX="${3:-sttfstate}"
CONTAINER_NAME="${4:-tfstate}"
LOCATION="${5:-eastus2}"

echo "Setting subscription context: ${SUBSCRIPTION_ID}"
az account set --subscription "${SUBSCRIPTION_ID}"

echo "Creating Resource Group: ${RESOURCE_GROUP_NAME} in ${LOCATION}"
az group create \
  --name "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" \
  --tags ManagedBy=TerraformBootstrap Project=CloudPlatform

RANDOM_SUFFIX=$(od -vAn -N2 -tu2 < /dev/urandom | tr -d ' ' | cut -c1-4)
STORAGE_ACCOUNT_NAME="${STORAGE_PREFIX}${RANDOM_SUFFIX}"

echo "Creating Secure Storage Account: ${STORAGE_ACCOUNT_NAME}"
az storage account create \
  --name "${STORAGE_ACCOUNT_NAME}" \
  --resource-group "${RESOURCE_GROUP_NAME}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --encryption-services blob \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --https-only true \
  --tags ManagedBy=TerraformBootstrap

echo "Creating Blob Container: ${CONTAINER_NAME}"
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT_NAME}" \
  --auth-mode login

echo ""
echo "=== Backend Bootstrap Complete ==="
echo "Resource Group:       ${RESOURCE_GROUP_NAME}"
echo "Storage Account:      ${STORAGE_ACCOUNT_NAME}"
echo "Container:            ${CONTAINER_NAME}"
echo "Run: terraform init -backend-config=\"resource_group_name=${RESOURCE_GROUP_NAME}\" -backend-config=\"storage_account_name=${STORAGE_ACCOUNT_NAME}\" -backend-config=\"container_name=${CONTAINER_NAME}\" -backend-config=\"key=gd-parent-infra/dev.tfstate\""
