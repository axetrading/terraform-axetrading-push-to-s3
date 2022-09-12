variable "config_paths" {
  description = "Path or paths for the configuration files. "
  type        = set(string)
  default     = []
}

variable "bucket_name" {
  type        = string
  description = "AWS S3 Bucket name"
}

variable "push_files_to_s3" {
  type        = bool
  description = "Push files to S3 bucket"
  default     = false
}

variable "push_objects_to_s3" {
  type        = bool
  description = "Push terraform output to S3"
  default     = true
}

variable "create_bucket" {
  type        = bool
  description = "Set to true to create the s3 bucket that will store the yaml files."
  default     = false
}
### https://github.com/hashicorp/terraform/issues/26265
variable "objects_to_push" {

  type        = map(any)
  default     = {}
  description = "A list of terraform objects that will be encoded to yaml and pushed to S3"
}