output "ipfs_db_instance_id" {
  value = aws_db_instance.ipfs_db.id
}

output "ipfs_db_instance_address" {
  value = aws_db_instance.ipfs_db.address
}

output "ipfs_db_instance_username" {
  value     = aws_db_instance.ipfs_db.username
  sensitive = true
}

output "ipfs_db_instance_password" {
  value     = aws_db_instance.ipfs_db.password
  sensitive = true
}

output "ipfs_db_instance_db_name" {
  value = aws_db_instance.ipfs_db.db_name
}

output "ipfs_db_instance_endpoint" {
  value = aws_db_instance.ipfs_db.endpoint

}

output "ipfs_db_instance_port" {
  value = aws_db_instance.ipfs_db.port
}