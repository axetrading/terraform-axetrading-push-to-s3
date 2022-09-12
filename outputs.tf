output "bucket_name" {
  value       = try(aws_s3_bucket.main[0].id, null)
  description = "AWS S3 Bucket name where the yaml files will be stored"
}

output "config_files" {
  value       = try([for k, v in aws_s3_object.files : format("%s/%s/%s", "s3://", v.bucket, v.key)], null)
  description = "Configuration files keys and their URLs"
}

output "metadata_objects" {
  value = try([for k, v in aws_s3_object.metadata : format("%s/%s/%s", "s3://", v.bucket, v.key)], null)
  description = "Objects pushed to S3 and their URLs"
}
