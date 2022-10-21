locals {
  create_bucket_policy = var.create_bucket && var.create_bucket_policy
}
data "aws_iam_policy_document" "deny_insecure_transport" {
  count = local.create_bucket_policy ? 1 : 0

  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.main[0].arn,
      "${aws_s3_bucket.main[0].arn}/*",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

data "aws_iam_policy_document" "cross_account_access" {
  count = local.create_bucket_policy && var.allow_external_principals ? 1 : 0
  statement {
    principals {
      type        = "AWS"
      identifiers = var.external_principals
    }

    actions = [
      "s3:Get*",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.main[0].arn
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = var.external_principals
    }

    actions = [
      "s3:Get*",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.main[0].arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "all" {
  count = var.create_bucket_policy ? 1 : 0

  source_policy_documents = compact([
    local.create_bucket_policy ? data.aws_iam_policy_document.deny_insecure_transport[0].json : "",
    local.create_bucket_policy && var.allow_external_principals ? data.aws_iam_policy_document.cross_account_access[0].json : ""
  ])
}