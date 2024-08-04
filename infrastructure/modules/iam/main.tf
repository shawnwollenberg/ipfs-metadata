resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.task_family}-execution-role"
  assume_role_policy = var.ecs_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = var.ecs_role_policy_arn
}
