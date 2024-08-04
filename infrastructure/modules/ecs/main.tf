resource "aws_ecs_cluster" "ipfs_cluster" {
  name = var.cluster_name
}

resource "aws_kms_key" "ipfs_ecs_secret_key" {
  deletion_window_in_days = 7
}

resource "aws_secretsmanager_secret" "ipfs_github_credentials" {
  name       = "ipfs_github_ecr_credentials"
  kms_key_id = aws_kms_key.ipfs_ecs_secret_key.id
}

resource "aws_secretsmanager_secret_version" "ipfs_github_credentials" {
  secret_id = aws_secretsmanager_secret.ipfs_github_credentials.id
  secret_string = jsonencode({
    username = var.github_username
    token    = var.github_token
  })
}

resource "aws_cloudwatch_log_group" "ipfs_service_logs" {
  name              = var.log_group_name
  retention_in_days = 14
}

resource "aws_cloudwatch_log_stream" "ipfs_service_log_stream" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.ipfs_service_logs.name
}


resource "aws_ecs_task_definition" "ipfs_task" {
  family = var.task_family
  container_definitions = jsonencode([{
    name      = var.container_definition_name
    image     = var.container_definition_image
    cpu       = var.container_definition_cpu
    memory    = var.container_definition_memory
    essential = true
    portMappings = [
      {
        containerPort = var.container_definition_port
        hostPort      = var.container_definition_host_port
        protocol      = var.container_definition_protocol
      }
    ]

    secrets = [{
      name      = "GITHUB_CREDENTIALS"
      valueFrom = "${aws_secretsmanager_secret.ipfs_github_credentials.arn}"
    }]

    environment = [{
      name  = "POSTGRES_USER"
      value = var.ipfs_db_postgres_user
      },
      {
        name  = "POSTGRES_PASSWORD"
        value = var.ipfs_db_postgres_password
      },
      {
        name  = "POSTGRES_DB"
        value = var.ipfs_db_postgres_db_name
      },
      {
        name  = "POSTGRES_HOST"
        value = var.ipfs_db_postgres_host
      },
      {
        name  = "POSTGRES_PORT"
        value = var.ipfs_db_postgres_port
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "${aws_cloudwatch_log_group.ipfs_service_logs.name}"
        awslogs-region        = var.region
        awslogs-stream-prefix = var.logstream_prefix
      }
    }
  }])
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = var.execution_role_arn
  cpu                      = var.ipfs_task_cpu
  memory                   = var.ipfs_task_memory
}

resource "aws_ecs_service" "ipfs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ipfs_cluster.id
  task_definition = aws_ecs_task_definition.ipfs_task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
