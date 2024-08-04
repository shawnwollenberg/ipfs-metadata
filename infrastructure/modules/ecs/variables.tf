variable "cluster_name" {}

variable "github_username" {}

variable "github_token" {
  sensitive = true
}

variable "log_group_name" {}

variable "log_stream_name" {}

variable "task_family" {}

variable "container_definition_name" {}

variable "container_definition_image" {}

variable "container_definition_cpu" {}

variable "container_definition_memory" {}

variable "container_definition_port" {}

variable "container_definition_host_port" {}

variable "container_definition_protocol" {}

variable "ipfs_db_postgres_user" {}

variable "ipfs_db_postgres_password" {}

variable "ipfs_db_postgres_db_name" {}

variable "ipfs_db_postgres_host" {}

variable "ipfs_db_postgres_port" {}

variable "region" {}

variable "logstream_prefix" {}

variable "requires_compatibilities" {}

variable "network_mode" {}

variable "execution_role_arn" {}

variable "ipfs_task_cpu" {}

variable "ipfs_task_memory" {}

variable "service_name" {}

variable "desired_count" {}

variable "launch_type" {}

variable "subnet_ids" {}

variable "security_group_ids" {}

variable "alb_target_group_arn" {}

variable "container_name" {}

variable "container_port" {}
