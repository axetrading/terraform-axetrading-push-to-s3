locals {
  existing_s3_bucket = var.existing_s3_bucket != null && var.existing_s3_bucket != ""
  files              = var.push_files_to_s3 ? toset(flatten([for relative_path in var.config_paths : fileset(path.root, "${relative_path}/*.yaml")])) : []
  objects            = var.push_objects_to_s3 ? { for k, v in var.objects_to_push : k => v if var.objects_to_push != null && var.objects_to_push != {} } : {}
}

resource "aws_s3_bucket" "main" {
  count  = local.existing_s3_bucket ? 0 : 1
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "main" {
  count                   = local.existing_s3_bucket ? 0 : 1
  bucket                  = aws_s3_bucket.main[0].id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "main" {
  count  = local.existing_s3_bucket ? 0 : 1
  bucket = aws_s3_bucket.main[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "main" {
  count  = local.existing_s3_bucket ? 0 : 1
  bucket = aws_s3_bucket.main[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count  = local.existing_s3_bucket ? 0 : 1
  bucket = aws_s3_bucket.main[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "files" {
  for_each = local.files

  bucket       = local.existing_s3_bucket ? var.existing_s3_bucket : aws_s3_bucket.main[0].id
  key          = each.value
  source       = each.value
  content_type = "text/yaml"
  etag         = filemd5(each.value)
}

resource "aws_s3_object" "outputs" {
  for_each = local.objects

  bucket       = local.existing_s3_bucket ? var.existing_s3_bucket : aws_s3_bucket.main[0].id
  key          = format("%s%s", each.key, ".yaml")
  content      = replace(templatefile("${path.module}/templates/metadata.tftpl", { key = each.key, value = each.value }), "\"", "")
  content_type = "text/yaml"
}