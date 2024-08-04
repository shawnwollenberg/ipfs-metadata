output "ipfs_role_arn" {
  value = aws_iam_role.ipfs_ecs_task_execution_role.arn
}

output "ipfs_role_name" {
  value = aws_iam_role.ipfs_ecs_task_execution_role.name
}
