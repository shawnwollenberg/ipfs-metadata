output "ipfs_lb_dns_name" {
  value = aws_alb.ipfs_alb.dns_name
}

output "ipfs_lb_arn" {
  value = aws_alb.ipfs_alb.arn
}

output "ipfs_lb_id" {
  value = aws_alb.ipfs_alb.id
}

output "ipfs_tg_arn" {
  value = aws_alb_target_group.ipfs_tg.arn
}

output "ipfs_tg_id" {
  value = aws_alb_target_group.ipfs_tg.id
}

output "ipfs_listener_arn" {
  value = aws_alb_listener.ipfs_listener.arn
}

output "ipfs_listener_id" {
  value = aws_alb_listener.ipfs_listener.id
}
