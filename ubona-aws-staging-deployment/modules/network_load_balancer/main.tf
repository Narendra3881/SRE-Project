# create network load balancer 

resource "aws_lb" "network_load_balancer" {
  name                             = "${var.project_name}-nlb"
  internal                         = true
  load_balancer_type               = "network"
  subnets                          = [var.private_subnet_2a_id,var.private_subnet_2b_id]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  tags                             = var.tags
}

resource "aws_lb_target_group" "nlb_internal_tg" {
  name        = "${var.project_name}-nlb-tg"
  port        = 3128
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    port     = "traffic-port"
    protocol = "TCP"
    interval = 300
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = 3128
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_internal_tg.arn
  }
}

