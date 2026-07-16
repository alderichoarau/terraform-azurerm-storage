# terraform-azurerm-storage

Terraform module that provisions an Azure Storage Account with one private and one public blob container.

## Usage

```hcl
module "storage" {
  source = "github.com/alderichoarau/terraform-azurerm-storage"

  name                 = "stmyproject"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location

  tags = {
    owner = "my-team"
  }
}
```

See [examples/basic](examples/basic) for a complete, runnable example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.9 |
| azurerm | ~> 4.0 |

## Providers

| Name | Version |
| ---- | ------- |
| azurerm | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| location | Azure region for the storage account | `string` | n/a | yes |
| name | Name of the Storage Account (lowercase letters and digits only, 3-24 chars) | `string` | n/a | yes |
| private\_container\_name | Name of the private blob container | `string` | `"api-logs"` | no |
| public\_container\_name | Name of the public blob container (blob-level anonymous access) | `string` | `"api-config"` | no |
| resource\_group\_name | Name of the Resource Group to deploy into | `string` | n/a | yes |
| tags | Tags applied to all resources in this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| private\_container\_url | URL of the private container |
| public\_container\_url | Public URL of the public container |
| storage\_account\_id | ID of the Storage Account |
| storage\_account\_name | Name of the Storage Account |
<!-- END_TF_DOCS -->

## Notes

- `shared_access_key_enabled = false` — callers must authenticate via Azure AD (`storage_use_azuread = true`
  on the `azurerm` provider), not account keys.
- The public container allows blob-level anonymous access; the private container does not.

## Local Git hooks

A [`.pre-commit-config.yaml`](.pre-commit-config.yaml) runs `terraform fmt`, `terraform validate`,
`tflint` and `terraform-docs` before each commit. One-time setup:

```bash
pip install pre-commit   # or: brew install pre-commit
pre-commit install
```

## Contributing

This repository does not accept external contributions. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

All rights reserved. See [LICENSE](LICENSE).
