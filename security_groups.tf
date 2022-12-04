resource "aws_security_group" "lb_sg" {
  name        = "${var.project_short_name}-lb-sg"
  vpc_id      = aws_vpc.this.id

  depends_on = [aws_subnet.public_subnet]

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_lb_sg"
  } 
}

resource "aws_security_group" "db_sg" {
  name        = "${var.project_short_name}-db-sg"
  vpc_id      = aws_vpc.this.id

  depends_on = [aws_security_group.lb_sg]

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_db_sg"
  } 
}

resource "aws_security_group" "fam_api" {
  name        = "${var.project_short_name}-api-sg"
  vpc_id      = aws_vpc.this.id

  depends_on = [aws_security_group.db_sg]

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_api_sg"
  } 
}
