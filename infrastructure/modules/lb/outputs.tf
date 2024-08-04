output "lb_dns_name" {
  value = aws_alb.ipfs_alb.dns_name
}

output "lb_arn" {
  value = aws_alb.ipfs_alb.arn
}

output "lb_id" {
  value = aws_alb.ipfs_alb.id
}

output "tg_arn" {
  value = aws_alb_target_group.ipfs_tg.arn
}

output "tg_id" {
  value = aws_alb_target_group.ipfs_tg.id
}

output "listener_arn" {
  value = aws_alb_listener.ipfs_listener.arn
}

output "listener_id" {
  value = aws_alb_listener.ipfs_listener.id
}
