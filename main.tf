locals {
  files       = var.push_files_to_s3 ? toset(flatten([for relative_path in var.config_paths : fileset(path.root, "${relative_path}/*.yaml")])) : []
  objects     = var.push_objects_to_s3 ? { for k, v in var.objects_to_push : k => v if var.objects_to_push != null && var.objects_to_push != {} } : {}
  json_files  = var.push_json_files_to_s3 ? toset(flatten([for relative_path in var.json_config_paths : fileset(path.root, "${relative_path}/*.json")])) : []
}

resource "aws_s3_bucket" "main" {
  count  = var.create_bucket ? 1 : 0
  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "main" {
  count = var.create_bucket_policy ? 1 : 0

  bucket = aws_s3_bucket.main[0].id
  policy = data.aws_iam_policy_document.all[0].json
}

resource "aws_s3_bucket_public_access_block" "main" {
  count                   = var.create_bucket ? 1 : 0
  bucket                  = aws_s3_bucket.main[0].id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.main[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "main" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.main[0].id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count  = var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.main[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "files" {
  for_each = local.files

  bucket       = var.create_bucket ? aws_s3_bucket.main[0].id : var.bucket_name
  key          = each.value
  source       = each.value
  content_type = "text/yaml"
  etag         = filemd5(each.value)
}

resource "aws_s3_object" "metadata" {
  for_each = local.objects

  bucket       = var.create_bucket ? aws_s3_bucket.main[0].id : var.bucket_name
  key          = format("%s%s", each.key, ".yaml")
  acl          = var.canned_acl
  content      = replace(templatefile("${path.module}/templates/metadata.tftpl", { key = each.key, value = each.value }), "\"", "")
  content_type = "text/yaml"
  etag         = filemd5(each.value)
}

resource "aws_s3_object" "json_files" {
  for_each = local.json_files

  bucket       = var.create_bucket ? aws_s3_bucket.main[0].id : var.bucket_name
  key          = each.value
  source       = each.value
  content_type = "application/json"
  etag         = filemd5(each.value)
}
