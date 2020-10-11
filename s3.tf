resource "aws_s3_bucket" "serverless_deploy_bucket" {
  // The HTTPS certificate will not match bucket names with periods when using the virtual-hosted–style URI
  // (e.g. bucket.s3.amazonaws.com) so replace them
  bucket = join("-", compact(["trons-api-serveless-deploy", replace(var.subdomain, ".", "-")]))

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    // This is a workaround and NOP
    // See https://github.com/intimitrons4604/terraform-website/issues/40
    expiration {
      expired_object_delete_marker = false
      days                         = 0
    }
  }

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}
