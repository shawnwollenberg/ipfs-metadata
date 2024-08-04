# Module Configuration
variable "region" {}

#VPC Configuration
variable "cidr_block" {}

variable "vpc_name" {}

variable "subnet_count" {}

variable "ipfs_rt_cidr_block" {}

variable "sg_ingress_from_port" {}

variable "sg_ingress_to_port" {}

variable "ingress_protocol" {}

variable "ingress_cidr_blocks" {}

variable "egress_from_port" {}

variable "egress_to_port" {}

variable "egress_protocol" {}

variable "egress_cidr_blocks" {}

variable "ipfs_rds_sg_ingress_from_port" {}

variable "ipfs_rds_sg_ingress_to_port" {}

# ALB Configuration
variable "ipfs_alb_name" {}

variable "ipfs_alb_type" {}

variable "ipfs_tg_name" {}

variable "ipfs_tg_port" {}

variable "target_type" {}

variable "ipfs_tg_protocol" {}

variable "ipfs_listener_port" {}

variable "ipfs_listener_protocol" {}

# IAM Configuration
variable "ecs_assume_role_policy" {}

variable "ecs_role_policy_arn" {}


# ECS Configuration
variable "cluster_name" {}

variable "ipfs_secret_name" {}

variable "github_username" {}

variable "github_token" {}

variable "log_group_name" {}

variable "log_stream_name" {}

variable "task_family" {}

variable "container_definition_image" {}

variable "container_definition_cpu" {}

variable "container_definition_memory" {}

variable "logstream_prefix" {}

variable "requires_compatibilities" {}

variable "network_mode" {}

variable "ipfs_task_cpu" {}

variable "ipfs_task_memory" {}

variable "service_name" {}

variable "desired_count" {}

variable "launch_type" {}

variable "container_name" {}

variable "container_port" {}

# RDS Configuration
variable "db_identifier" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "allocated_storage" {}

variable "username" {}

variable "password" {}

variable "db_name" {}

variable "parameter_group_name" {}

variable "parameter_group_family" {}

variable "tags_name" {}
