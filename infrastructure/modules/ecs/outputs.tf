output "ipfs_cluster_id" {
  value = aws_ecs_cluster.ipfs_cluster.id
}

output "ipfs_service_arn" {
  value = aws_ecs_service.ipfs_service.id
}

output "ipfs_secret_manager_secret_arn" {
  value = aws_secretsmanager_secret.ipfs_github_credentials.arn
}

output "ipfs_kms_key_arn" {
  value = aws_kms_key.ipfs_ecs_secret_key.arn

}