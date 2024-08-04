output "ipfs_vpc_id" {
  value = aws_vpc.ipfs_vpc.id
}

output "ipfs_subnet_ids" {
  value = aws_subnet.ipfs_subnet[*].id
}

output "ipfs_subnet_group_name" {
  value = aws_db_subnet_group.ipfs_db_subnet_group.name

}

output "ipfs_app_sg_id" {
  value = aws_security_group.ipfs_app_sg.id
}

output "ipfs_rds_sg_id" {
  value = aws_security_group.ipfs_rds_sg.id
}