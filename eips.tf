resource "aws_eip" "egress" {
  count = 3
  vpc   = true

  lifecycle {
    # prevent_destroy = true
  }

  tags = {
    Name: "${var.project_short_name}_eip_egress"
    terraform: "infra"
    stage: var.stage
  }
}