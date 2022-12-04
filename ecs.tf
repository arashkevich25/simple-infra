resource "aws_kms_key" "kms_fam_key" {
  description             = "${var.project_short_name}kmskey"
  deletion_window_in_days = 7
}

resource "aws_ecs_cluster" "fam_ecs" {
  name = var.project_name

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.kms_fam_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.this.name
      }
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_fam_cap_provider" {
  cluster_name = aws_ecs_cluster.fam_ecs.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "fam_api" {
  family = "${var.project_short_name}-app"
  requires_compatibilities = ["FARGATE"]
  container_definitions = file("task-definitions/api_service.json")
  network_mode = "awsvpc"
  cpu = 512
  memory = 1024
  execution_role_arn = aws_iam_role.task_execution.arn
}

resource "aws_ecs_service" "fam_api" {
  name = "${var.project_short_name}-api"
  cluster = aws_ecs_cluster.fam_ecs.id
  task_definition = aws_ecs_task_definition.fam_api.arn
  desired_count = 1

  depends_on = [aws_lb_target_group.fam_api]

  load_balancer {
    target_group_arn = aws_lb_target_group.fam_api.arn
    container_name   = "${var.project_short_name}_api"
    container_port   = 1337
  }

  network_configuration {
    security_groups = [aws_security_group.fam_api.id]
    subnets = [aws_subnet.private_ecs.id]
  }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }
}
