resource "aws_s3_bucket" "frontend_s3_bucket" {
  bucket = "${var.product}-${var.env}-ui"
  tags = {
    Name = "${var.product}-${var.env}-ui"
  }
}

resource "aws_s3_bucket_acl" "frontend_s3_bucket_acl" {
  bucket = aws_s3_bucket.frontend_s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "frontend_s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.frontend_s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "frontend_s3_bucket_ownership_controls" {
  bucket = aws_s3_bucket.frontend_s3_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# resource "aws_s3_bucket_server_side_encryption_configuration" "frontend_s3_bucket_sse" {
#   bucket = aws_s3_bucket.frontend_s3_bucket.bucket

#   rule {
#     bucket_key_enabled = false
#   }
# }

locals {
  s3_origin_id = "${var.product}-${var.env}-ui"
}

resource "aws_cloudfront_origin_access_control" "ui_s3_origin_access_control" {
  name                              = "${var.product}-${var.env}-ui-origin-access-control"
  description                       = "${var.product}-${var.env}-ui-origin-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "ui_cf_distribution" {
  origin {
    domain_name              = aws_s3_bucket.frontend_s3_bucket.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.ui_s3_origin_access_control.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.product}-${var.env}-ui"
  http_version        = "http2and3"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "https-only"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
    response_code         = 200
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 10
    response_page_path    = "/index.html"
    response_code         = 200
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  tags = {
    Name = "${var.product}-${var.env}"
  }
}

data "aws_iam_policy_document" "ui_s3_iam_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend_s3_bucket.arn}/*"]
    sid       = "AllowCloudFrontServicePrincipal"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.ui_cf_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "ui_s3_bucket_policy" {
  bucket = aws_s3_bucket.frontend_s3_bucket.id
  policy = data.aws_iam_policy_document.ui_s3_iam_policy.json
}

