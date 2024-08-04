resource "aws_alb" "ipfs_alb" {
  name               = var.ipfs_alb_name
  load_balancer_type = var.ipfs_alb_type
  security_groups    = var.ipfs_alb_security_groups
  subnets            = var.ipfs_alb_subnets
}

resource "aws_alb_target_group" "ipfs_tg" {
  name        = var.ipfs_tg_name
  port        = var.ipfs_tg_port
  target_type = var.target_type
  protocol    = var.ipfs_tg_protocol
  vpc_id      = var.vpc_id
}

resource "aws_alb_listener" "ipfs_listener" {
  load_balancer_arn = aws_alb.ipfs_alb.arn
  port              = var.ipfs_listener_port
  protocol          = var.ipfs_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ipfs_tg.arn
  }
}