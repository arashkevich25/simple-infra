resource "aws_service_discovery_private_dns_namespace" "api" {
  name        = "fam-dns"
  description = "api"
  vpc         = aws_vpc.this.id
}

resource "aws_service_discovery_service" "this" {
  name = "api"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.api.id
    dns_records {
      ttl  = 0
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  force_destroy = true
}