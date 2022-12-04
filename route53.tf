resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.fam.zone_id
  name    = var.api_domain
  type    = "A"
  allow_overwrite = true
  
  alias {
    name                   = aws_lb.fam_lb.dns_name
    zone_id                = aws_lb.fam_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "records_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.fam.zone_id
}