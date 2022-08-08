output "config_bucket_name" {
  value = aws_s3_bucket.resource_configs.id
  description = "AWS S3 Bucket name where the yaml files will be stored"
}

output "config_files" {
  value = { for k, v in aws_s3_object.config_files : k => format("%s/%s/%s", "s3://", v.bucket, v.key) }
  description = "Configuration files keys and their URLs"
}
