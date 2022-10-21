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

variable "create_bucket_policy" {
  type        = bool
  description = "Wheter to create a bucket policy"
  default     = false
}

variable "allow_external_principals" {
  type        = bool
  description = "Enable this to allow external principals to write to the newly created s3 bucket"
  default     = false
}

variable "external_principals" {
  type        = list(string)
  description = "A list of external AWS principals that should have RW access to the newly created S3 bucket"
  default     = []
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "canned_acl" {
  type = string
  description = "Canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, and bucket-owner-full-control"
  default = "bucket-owner-full-control"
}