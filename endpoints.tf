
resource "aws_vpc_endpoint" "ecr" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ecr.api"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]
  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecr_api_endpoint"
  } 
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecr_dkr_endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ssm_endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ssm_messages_endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ec2_endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ec2_messages_endpoint"
  }
}

resource "aws_vpc_endpoint" "ecs_agent" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ecs-agent"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecs_agent_endpoint"
  }
}

resource "aws_vpc_endpoint" "ecs_telemetry" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ecs-telemetry"
  vpc_endpoint_type = "Interface"

  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecs_telemetry_endpoint"
  }
}

resource "aws_vpc_endpoint" "ecs" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.ecs"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet.id]
  security_group_ids = [aws_security_group.fam_api.id]

  private_dns_enabled = true
  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecs_endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.eu-north-1.s3"

  route_table_ids = aws_route_table.private.*.id

  policy = <<-EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "*"
      }
    ]
  }
  EOF

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_s3_endpoint"
  }
}