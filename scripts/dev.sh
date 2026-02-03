#!/bin/bash

set -e

RESOURCE_GROUP_NAME="terraform-state-rg"
STAGE_SA_ACCOUNT="tfstagebackend2026kr"
DEV_SA_ACCOUNT="tfdevbackend2026kr"
CONTAINER_NAME="tfstatekr"
LOCATION="francecentral"
SUBSCRIPTION_ID="7653a001-c28d-4ce2-9ec3-c6cdd6a7f98f"

az account set --subscription "$SUBSCRIPTION_ID"

# Create resource group
az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"

# Create storage account for staging environment
az storage account create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --name "$STAGE_SA_ACCOUNT" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --encryption-services blob \
  --allow-blob-public-access false

# Create storage account for dev environment
az storage account create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --name "$DEV_SA_ACCOUNT" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --encryption-services blob \
  --allow-blob-public-access false

# Create blob container for staging environment (use Entra ID auth)
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STAGE_SA_ACCOUNT" \
  --auth-mode login \
  --public-access off

# Create blob container for dev environment (use Entra ID auth)
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$DEV_SA_ACCOUNT" \
  --auth-mode login \
  --public-access off