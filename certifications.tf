resource "aws_acm_certificate" "api_cert" {
    domain_name       = var.api_domain
    validation_method = "DNS"

    tags = {
        terraform: "infra"
        stage: var.stage
        Name: "${var.project_short_name}_api_cert"
    } 
  
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "api_cert_validation" {
  certificate_arn           = aws_acm_certificate.api_cert.arn
  validation_record_fqdns   = [for record in aws_route53_record.records_validation : record.fqdn]
}