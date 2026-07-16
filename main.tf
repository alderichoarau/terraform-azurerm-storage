resource "azurerm_storage_account" "sa" {
  # checkov:skip=CKV_AZURE_59: public_container_name is intentionally public (static config blobs)
  # checkov:skip=CKV_AZURE_190: public blob access intentional for the public container
  # checkov:skip=CKV2_AZURE_47: anonymous access intentional for the public container
  # checkov:skip=CKV2_AZURE_1: CMK requires Azure Key Vault, out of scope for this module
  # checkov:skip=CKV_AZURE_33: queue logging not required by callers of this module
  # checkov:skip=CKV_AZURE_206: GRS replication left to the caller; LRS is the module default
  # checkov:skip=CKV2_AZURE_33: private endpoint requires VNet integration, out of scope for this module
  # checkov:skip=CKV2_AZURE_41: SAS expiration policy left to the caller
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  allow_nested_items_to_be_public = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

# Private container
resource "azurerm_storage_container" "private" {
  # checkov:skip=CKV2_AZURE_21: blob read logging not required by callers of this module
  name                  = var.private_container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

# Public container (blob-level anonymous access)
resource "azurerm_storage_container" "public" {
  # checkov:skip=CKV_AZURE_34: public container intentional — static config blobs
  # checkov:skip=CKV2_AZURE_21: blob read logging not required by callers of this module
  name                  = var.public_container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "blob"
}
