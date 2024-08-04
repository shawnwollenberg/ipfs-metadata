module "vpc" {
  source                        = "./modules/vpc"
  cidr_block                    = var.cidr_block
  name                          = var.vpc_name
  subnet_count                  = var.subnet_count
  ipfs_rt_cidr_block            = var.ipfs_rt_cidr_block
  ipfs_app_sg_ingress_from_port = var.sg_ingress_from_port
  ipfs_app_sg_ingress_to_port   = var.sg_ingress_to_port
  ingress_protocol              = var.ingress_protocol
  ingress_cidr_blocks           = var.ingress_cidr_blocks
  egress_from_port              = var.egress_from_port
  egress_to_port                = var.egress_to_port
  egress_protocol               = var.egress_protocol
  egress_cidr_blocks            = var.egress_cidr_blocks
  ipfs_rds_sg_ingress_from_port = var.ipfs_rds_sg_ingress_from_port
  ipfs_rds_sg_ingress_to_port   = var.ipfs_rds_sg_ingress_to_port
}

module "lb" {
  source                   = "./modules/lb"
  ipfs_alb_name            = var.ipfs_alb_name
  ipfs_alb_type            = var.ipfs_alb_type
  ipfs_alb_security_groups = [module.vpc.ipfs_app_sg_id]
  ipfs_alb_subnets         = module.vpc.subnet_ids
  ipfs_tg_name             = var.ipfs_tg_name
  ipfs_tg_port             = var.ipfs_tg_port
  target_type              = var.target_type
  ipfs_tg_protocol         = var.ipfs_tg_protocol
  vpc_id                   = module.vpc.vpc_id
  ipfs_listener_port       = var.ipfs_listener_port
  ipfs_listener_protocol   = var.ipfs_listener_protocol
}

module "iam" {
  source                 = "./modules/iam"
  task_family            = var.task_family
  ecs_assume_role_policy = var.ecs_assume_role_policy
  ecs_role_policy_arn    = var.ecs_role_policy_arn
}

module "ecs" {
  source                   = "./modules/ecs"
  cluster_name             = var.cluster_name
  task_family              = var.task_family
  container_definitions    = var.container_definitions
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = module.iam.role_arn
  service_name             = var.service_name
  desired_count            = var.desired_count
  launch_type              = var.launch_type
  subnet_ids               = module.vpc.subnet_ids
  security_group_ids       = [module.vpc.ipfs_app_sg_id]
  alb_target_group_arn     = module.lb.tg_arn
  container_name           = var.container_name
  container_port           = var.container_port
}

module "rds" {
  source                 = "./modules/rds"
  db_identifier          = var.db_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  username               = var.username
  password               = var.password
  db_name                = var.db_name
  ipfs_rds_sg_id         = [module.vpc.ipfs_rds_sg_id]
  db_subnet_group_name   = module.vpc.subnet_group_name
  parameter_group_name   = var.parameter_group_name
  parameter_group_family = var.parameter_group_family
  tags_name              = var.tags_name
}

