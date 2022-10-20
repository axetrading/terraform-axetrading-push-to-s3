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
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.files](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.metadata](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_iam_policy_document.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cross_account_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deny_insecure_transport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_principals"></a> [allow\_external\_principals](#input\_allow\_external\_principals) | Enable this to allow external principals to write to the newly created s3 bucket | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | AWS S3 Bucket name | `string` | n/a | yes |
| <a name="input_config_paths"></a> [config\_paths](#input\_config\_paths) | Path or paths for the configuration files. | `set(string)` | `[]` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Set to true to create the s3 bucket that will store the yaml files. | `bool` | `false` | no |
| <a name="input_create_bucket_policy"></a> [create\_bucket\_policy](#input\_create\_bucket\_policy) | Wheter to create a bucket policy | `bool` | `false` | no |
| <a name="input_external_principals"></a> [external\_principals](#input\_external\_principals) | A list of external AWS principals that should have RW access to the newly created S3 bucket | `list(string)` | `[]` | no |
| <a name="input_objects_to_push"></a> [objects\_to\_push](#input\_objects\_to\_push) | A list of terraform objects that will be encoded to yaml and pushed to S3 | `map(any)` | `{}` | no |
| <a name="input_push_files_to_s3"></a> [push\_files\_to\_s3](#input\_push\_files\_to\_s3) | Push files to S3 bucket | `bool` | `false` | no |
| <a name="input_push_objects_to_s3"></a> [push\_objects\_to\_s3](#input\_push\_objects\_to\_s3) | Push terraform output to S3 | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | AWS S3 Bucket name where the yaml files will be stored |
| <a name="output_config_files"></a> [config\_files](#output\_config\_files) | Configuration files keys and their URLs |
| <a name="output_metadata_objects"></a> [metadata\_objects](#output\_metadata\_objects) | Objects pushed to S3 and their URLs |
<!-- END_TF_DOCS -->