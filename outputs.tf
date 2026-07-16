output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.sa.id
}

output "private_container_url" {
  description = "URL of the private container"
  value       = "${azurerm_storage_account.sa.primary_blob_endpoint}${azurerm_storage_container.private.name}"
}

output "public_container_url" {
  description = "Public URL of the public container"
  value       = "${azurerm_storage_account.sa.primary_blob_endpoint}${azurerm_storage_container.public.name}"
}
