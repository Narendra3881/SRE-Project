
output "alb_sg_id" {
  description = "ALB security group ID "
  value = aws_security_group.alb_sg.id
}

