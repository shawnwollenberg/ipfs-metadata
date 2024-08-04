resource "aws_vpc" "ipfs_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "ipfs_subnet" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.ipfs_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "ipfs_db_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = aws_subnet.ipfs_subnet[*].id

  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}

resource "aws_internet_gateway" "ipfs_ig" {
  vpc_id = aws_vpc.ipfs_vpc.id
}

resource "aws_route_table" "ipfs_rt" {
  vpc_id = aws_vpc.ipfs_vpc.id

  route {
    cidr_block = var.ipfs_rt_cidr_block
    gateway_id = aws_internet_gateway.ipfs_ig.id
  }
}

resource "aws_route_table_association" "ipfs_rta" {
  count          = length(aws_subnet.ipfs_subnet[*].id)
  subnet_id      = element(aws_subnet.ipfs_subnet[*].id, count.index)
  route_table_id = aws_route_table.ipfs_rt.id
}

resource "aws_security_group" "ipfs_app_sg" {
  vpc_id = aws_vpc.ipfs_vpc.id
  ingress {
    from_port   = var.ipfs_app_sg_ingress_from_port
    to_port     = var.ipfs_app_sg_ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "ipfs_rds_sg" {
  vpc_id = aws_vpc.ipfs_vpc.id

  ingress {
    from_port       = var.ipfs_rds_sg_ingress_from_port
    to_port         = var.ipfs_rds_sg_ingress_to_port
    protocol        = var.ingress_protocol
    security_groups = [aws_security_group.ipfs_app_sg.id]
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
}

data "aws_availability_zones" "available" {}
