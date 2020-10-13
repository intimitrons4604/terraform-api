resource "aws_apigatewayv2_api" "gateway" {
  name          = join("-", compact(["trons-api", var.subdomain]))
  protocol_type = "HTTP"

  disable_execute_api_endpoint = true

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

resource "aws_apigatewayv2_domain_name" "gateway_domain_name" {
  depends_on = [aws_acm_certificate_validation.certificate_validation]

  domain_name = join(".", compact(["api", var.subdomain, trimsuffix(data.terraform_remote_state.dns.outputs.fqdn, ".")]))
  domain_name_configuration {
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
    certificate_arn = aws_acm_certificate.certificate.arn
  }

  tags = {
    "trons:environment" = var.environment
    "trons:service"     = "api"
    "trons:terraform"   = "true"
  }
}

resource "aws_apigatewayv2_api_mapping" "gateway_domain_mapping" {
  api_id      = aws_apigatewayv2_api.gateway.id
  domain_name = aws_apigatewayv2_domain_name.gateway_domain_name.id
  stage       = aws_apigatewayv2_stage.gateway_default_stage.id
}
