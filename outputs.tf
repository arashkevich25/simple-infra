output "db_endpoint" {
  value = aws_db_instance.pgs.endpoint
}

output "egress_eip_public_ips" {
  value = aws_eip.egress.*.public_ip
}