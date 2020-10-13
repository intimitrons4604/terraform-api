resource "aws_iam_user" "deploy_user" {
  name = join("-", compact(["svc_api-deploy", var.subdomain]))

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}
