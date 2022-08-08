variable "config_paths" {
  description = "Path or paths for the configuration files. "
  type        = set(string)
}

variable "bucket_name" {
  type        = string
  description = "AWS S3 Bucket name"
}
