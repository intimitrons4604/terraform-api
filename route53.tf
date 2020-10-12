resource "aws_route53_record" "api" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = join(".", compact(["api", var.subdomain]))
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.gateway_domain_name.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.gateway_domain_name.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}
