# terraform-axetrading-resource-configurations
A simple Terraform module that uploads yaml files from multiple paths into a s3 bucket.
The YAML file should contain list, maps or any kind of object that can be used on a later date, in other terraform modules.
This files can be referenced by using the following terraform data sources: 

[aws_s3_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_object) 
```
data "aws_s3_object" "object" {
  bucket = "s3_bucket_name"
  key    = "s3_object_key"
}
```

[aws_s3_objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_objects)
```
data "aws_s3_objects" "my_objects" {
  bucket = "s3_bucket_name"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.25.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.resource_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.resource_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.resource_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.resource_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.resource_configs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.config_files](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | AWS S3 Bucket name | `string` | n/a | yes |
| <a name="input_config_paths"></a> [config\_paths](#input\_config\_paths) | Path or paths for the configuration files. | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_bucket_name"></a> [config\_bucket\_name](#output\_config\_bucket\_name) | AWS S3 Bucket name where the yaml files will be stored |
| <a name="output_config_files"></a> [config\_files](#output\_config\_files) | Configuration files keys and their URLs |
<!-- END_TF_DOCS -->