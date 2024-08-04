resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.task_family
  container_definitions    = jsonencode(var.container_definitions)
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = var.execution_role_arn
  cpu                      = "512"
  memory                   = "1024"
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    # assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
