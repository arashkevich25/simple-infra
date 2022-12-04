resource "aws_iam_role" "task_execution" {
  name               = "${var.project_short_name}-ecs-execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_execution.name
}

resource "aws_iam_role" "task" {
  name               = "${var.project_short_name}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "task_policy" {
  name   = "${var.project_short_name}-ecs-task-policy"
  policy = data.aws_iam_policy_document.task_role_policy.json
  role   = aws_iam_role.task.name
}