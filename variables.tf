variable "config_paths" {
  description = "Path or paths for the configuration files. "
  type        = set(string)
  default     = []
}

variable "bucket_name" {
  type        = string
  description = "AWS S3 Bucket name"
  default     = null
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

variable "existing_s3_bucket" {
  type        = string
  description = "Existing S3 Bucket"
  default     = null
}

variable "objects_to_push" {
  type        = map(map(any))
  default     = {}
  description = "A list of terraform objects that will be encoded to yaml and pushed to S3"
}