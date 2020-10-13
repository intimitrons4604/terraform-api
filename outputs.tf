output "api_gateway_arn" {
  value       = aws_apigatewayv2_api.gateway.arn
  description = "The ARN of the API Gateway"
}

output "deploy_policy_arn" {
  value       = aws_iam_policy.deploy_policy.arn
  description = "The ARN of the IAM policy permitting deployment of the API"
}

output "serverless_deploy_bucket_arn" {
  value       = aws_s3_bucket.serverless_deploy_bucket.arn
  description = "The ARN of the S3 bucket where the Serverles Framework stores artifacts"
}
