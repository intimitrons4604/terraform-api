resource "aws_iam_user" "deploy_user" {
  name = join("-", compact(["svc_api-deploy", var.subdomain]))

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}

data "aws_iam_policy_document" "deploy_policy_document" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]
    resources = [aws_s3_bucket.serverless_deploy_bucket.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    resources = ["${aws_s3_bucket.serverless_deploy_bucket.arn}/*"]
  }
}

resource "aws_iam_policy" "deploy_policy" {
  name   = join("-", compact(["svc_api-deploy", var.subdomain]))
  policy = data.aws_iam_policy_document.deploy_policy_document.json
}

resource "aws_iam_user_policy_attachment" "deploy_user_policy" {
  user       = aws_iam_user.deploy_user.name
  policy_arn = aws_iam_policy.deploy_policy.arn
}

