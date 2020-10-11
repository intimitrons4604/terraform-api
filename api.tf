resource "aws_apigatewayv2_api" "gateway" {
  name          = join("-", compact(["trons-api", var.subdomain]))
  protocol_type = "HTTP"

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}
