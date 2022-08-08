locals {
  files = toset(flatten([for relative_path in var.config_paths : fileset(path.root, "${relative_path}/*.yaml")]))
}

resource "aws_s3_bucket" "resource_configs" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "resource_configs" {
  bucket                  = aws_s3_bucket.resource_configs.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "resource_configs" {
  bucket = aws_s3_bucket.resource_configs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "resource_configs" {
  bucket = aws_s3_bucket.resource_configs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "resource_configs" {
  bucket = aws_s3_bucket.resource_configs.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "config_files" {
  for_each = local.files

  bucket = aws_s3_bucket.resource_configs.id
  key    = each.value
  source = each.value
  etag   = filemd5(each.value)
}


