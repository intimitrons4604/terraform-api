output "api_endpoint" {
  value       = aws_apigatewayv2_api.gateway.api_endpoint
  description = "The URI of the API"
}
