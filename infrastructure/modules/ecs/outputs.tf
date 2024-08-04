output "cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "service_arn" {
  value = aws_ecs_service.service.id
}
