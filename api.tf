resource "aws_apigatewayv2_api" "gateway" {
  name          = join("-", compact(["trons-api", var.subdomain]))
  protocol_type = "HTTP"

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}

resource "aws_apigatewayv2_stage" "gateway_default_stage" {
  api_id      = aws_apigatewayv2_api.gateway.id
  name        = "$default"
  auto_deploy = true

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}
