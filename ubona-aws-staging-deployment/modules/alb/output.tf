output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
   description = "Application Load Balancer Target Group ARN."
}

output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
  description = "Application Load Balancer DNS Name."
}

output "alb_zone_id" {
  value       = aws_lb.application_load_balancer.zone_id
  description = "The zone ID of the Application Load Balancer."
}