resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/ecs/${var.project_short_name}"
}