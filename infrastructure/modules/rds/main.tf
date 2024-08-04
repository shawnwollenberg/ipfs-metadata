resource "aws_db_parameter_group" "custom_pg" {
  name   = var.parameter_group_name
  family = var.parameter_group_family

  parameter {
    name         = "max_connections"
    value        = "200"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "db" {
  identifier             = var.db_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  username               = var.username
  password               = var.password
  db_name                = var.db_name
  vpc_security_group_ids = var.ipfs_rds_sg_id
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = aws_db_parameter_group.custom_pg.name
  skip_final_snapshot    = true
  tags = {
    Name = var.tags_name
  }
}
