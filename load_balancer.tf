resource "aws_lb_listener" "ssl" {
  load_balancer_arn = aws_lb.fam_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.api_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fam_api.arn
  }
}

resource "aws_lb_listener" "toSsl" {
  load_balancer_arn = aws_lb.fam_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb" "fam_lb" {
  name               = "${var.project_short_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [
    aws_subnet.public_subnet.id, 
    aws_subnet.private_subnet.id,
    aws_subnet.private_ecs.id,
  ]

  enable_deletion_protection = false

  tags = {
    terraform: "infra"
    stage: var.stage
    Name: "${var.project_short_name}_ecr"
  } 
}

resource "aws_lb_target_group" "fam_api" {
  name     = "${var.project_short_name}-api-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.this.id

  depends_on = [
    aws_lb.fam_lb
  ]

   health_check {
    healthy_threshold   = "5"
    interval            = "30"
    path                = "/_health"
    protocol            = "HTTP"
    matcher             = "200,201,202,204"
    unhealthy_threshold = "5"
  }

}

resource "aws_lb_listener_rule" "this_listener_rule" {
  count = 1

  listener_arn = aws_lb_listener.ssl.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fam_api.arn
  }

  condition {
    host_header {
      values = [aws_route53_record.api.name]
    }
  }
}
