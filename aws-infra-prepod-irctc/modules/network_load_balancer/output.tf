output "network_load_balancer_arn" {
  description = "The ARN of the Network Load Balancer."
  value       = aws_lb.network_load_balancer.arn
}

output "network_load_balancer_dns_name" {
  description = "The DNS Name of the Network Load Balancer."
  value = aws_lb.network_load_balancer.dns_name
}

output "network_load_balancer_name" {
  description = "The Name of the Network Load Balancer."
  value       = aws_lb.network_load_balancer.name
}

output "target_group_arn" {
  description = "The ARN of the Target Group."
  value       = aws_lb_target_group.nlb_internal_tg.arn
}

output "listener_arn" {
  description = "The ARN of the Listener."
  value       = aws_lb_listener.listener.arn
}