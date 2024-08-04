# Module Configuration
region = "us-east-1"

# VPC Configuration
cidr_block                    = "10.0.0.0/16"
vpc_name                      = "ipfs-vpc"
subnet_count                  = 2
ipfs_rt_cidr_block            = "0.0.0.0/0"
sg_ingress_from_port          = 80
sg_ingress_to_port            = 80
ingress_protocol              = "tcp"
ingress_cidr_blocks           = ["0.0.0.0/0"]
egress_from_port              = 0
egress_to_port                = 0
egress_protocol               = "-1"
egress_cidr_blocks            = ["0.0.0.0/0"]
ipfs_rds_sg_ingress_from_port = 5432
ipfs_rds_sg_ingress_to_port   = 5432

# ALB Configuration
ipfs_alb_name          = "ipfs-alb"
ipfs_alb_type          = "application"
ipfs_tg_name           = "ipfs-tg"
ipfs_tg_port           = 80
target_type            = "ip"
ipfs_tg_protocol       = "HTTP"
ipfs_listener_port     = 80
ipfs_listener_protocol = "HTTP"

# IAM Configuration
ecs_assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs-tasks.amazonaws.com", "secretsmanager.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
ecs_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

# ECS Configuration
cluster_name                = "ipfs-cluster"
ipfs_secret_name            = "ipfs-github"
github_username             = "adedokunmu01"
log_group_name              = "/ecs/ipfs_service"
log_stream_name             = "ipfs-log-stream"
task_family                 = "ipfs-task"
container_definition_image  = "ghcr.io/adedokunmu01/ipfs-metadata:latest"
container_definition_cpu    = 512
container_definition_memory = 1024
logstream_prefix            = "ipfs"
requires_compatibilities    = ["FARGATE"]
network_mode                = "awsvpc"
ipfs_task_cpu               = "512"
ipfs_task_memory            = "1024"
service_name                = "ipfs-service"
desired_count               = 1
launch_type                 = "FARGATE"
container_name              = "ipfs-app"
container_port              = 8080

# RDS Configuration
db_identifier          = "ipfs-dbinstance"
engine                 = "postgres"
engine_version         = "16.3"
instance_class         = "db.t3.micro"
allocated_storage      = 20
username               = "test"
db_name                = "testdb"
parameter_group_name   = "ipfs-custom-parameter-group"
parameter_group_family = "postgres16"
tags_name              = "ipfs"
