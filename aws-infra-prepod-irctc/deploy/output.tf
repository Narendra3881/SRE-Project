
# Output for VPC ID
output "vpc_id" {
  value       = data.aws_vpc.existing_vpc.id
  description = "The ID of the VPC."
}

#output "vpc_cidir_block" {
#  value       = data.aws_vpc.existing_vpc.cidr_block
#  description = "The Cidir block of VPC"
#}

# Output for Subnet IDs
output "public_subnet_2a_id" {
  value       = data.aws_subnet.public_subnets_1.id
  description = "The ID of the Public Subnet 1a."
}

output "public_subnet_2b_id" {
  value       = data.aws_subnet.public_subnets_2.id
  description = "The ID of the Public Subnet 1b."
}

output "private_subnet_2a_id" {
  value       = data.aws_subnet.private_subnets_1.id
  description = "The ID of the Private Subnet 1a."
}

output "private_subnet_2b_id" {
  value       = data.aws_subnet.private_subnets_2.id
  description = "The ID of the Private Subnet 1b."
}

output "db_subnet_2a_id" {
  value       = data.aws_subnet.db_subnets_1.id
  description = "The ID of the DB Subnet 1a."
}

output "db_subnet_2b_id" {
  value       = data.aws_subnet.db_subnets_2.id
  description = "The ID of the DB Subnet 1b."
}

# Output for Instance IDs
output "bastion_host_id" {
  value       = aws_instance.bastion_host.id
  description = "The ID of the Bastion Host instance."
}

output "webserver01_id" {
  value       = aws_instance.webserver01.id
  description = "The ID of the Webserver 01 instance."
}

#output "webserver02_id" {
#  value       = aws_instance.webserver02.id
#  description = "The ID of the Webserver 02 instance."
#}

output "appserver01_id" {
  value       = aws_instance.appserver01.id
  description = "The ID of the Appserver 01 instance."
}

output "appserver02_id" {
  value       = aws_instance.appserver02.id
  description = "The ID of the Appserver 02 instance."
}

output "proxy01_id" {
  value       = aws_instance.proxy01.id
  description = "The ID of the Proxy 01 instance."
}

#output "proxy02_id" {
#  value       = aws_instance.proxy02.id
#  description = "The ID of the Proxy 02 instance."
#}

# Output for Security Group IDs
output "bastion_host_sg_id" {
  value       = aws_security_group.bastion_host_sg.id
  description = "The ID of the Bastion Host Security Group."
}

output "webserver_sg_id" {
  value       = aws_security_group.webserver_sg.id
  description = "The ID of the Webserver Security Group."
}

output "appserver_sg_id" {
  value       = aws_security_group.appserver_sg.id
  description = "The ID of the Appserver Security Group."
}

output "proxy_sg_id" {
  value       = aws_security_group.proxy_sg.id
  description = "The ID of the Proxy Security Group."
}

# Output for Elastic IP address of Bastion Host
output "eip_bastion_host" {
  value       = aws_eip.eip_bastion_host.public_ip
  description = "The Elastic IP of the Bastion Host."
}

# Output for the Elastic IP address of Proxy 01
output "eip_proxy01" {
  value       = aws_eip.eip_proxy01.public_ip
  description = "The Elastic IP of the Proxy 01 instance."
}

## Output for the Elastic IP address of Proxy 02
#output "eip_proxy02" {
#  value       = aws_eip.eip_proxy02.public_ip
#  description = "The Elastic IP of the Proxy 02 instance."
#}

# Output for webserver01 Private IP address
output "webserver01_private_ip" {
  value = aws_instance.webserver01.private_ip
  description = "The private IP address of the webserver 01 instance."
}

## Output for webserver02 Private IP address
#output "webserver02_private_ip" {
#  value = aws_instance.webserver02.private_ip
#  description = "The private IP address of the webserver 02 instance."
#}

# Output for appserver01 Private IP address
output "appserver01_private_ip" {
  value = aws_instance.appserver01.private_ip
  description = "The private IP address of the appserver 01 instance."
}

# Output for appserver02 Private IP address
output "appserver02_private_ip" {
  value = aws_instance.appserver02.private_ip
  description = "The private IP address of the appserver 02 instance."
}


# Output the ARN of the existing instance profile
output "bastion_host_profile_arn" {
  value = data.aws_iam_instance_profile.bastionhost_instance_profile.arn
}

output "appserver_profile_arn" {
  value = data.aws_iam_instance_profile.appserver_instance_profile.arn
}

# Output the existing instance profile name
output "bastion_host_profile_name" {
  value = data.aws_iam_instance_profile.bastionhost_instance_profile.name
}

output "appserver_profile_name" {
  value = data.aws_iam_instance_profile.appserver_instance_profile.name
}

# Output for Application Load Balancer (ALB) details
output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The DNS name of the Application Load Balancer."
}

output "alb_zone_id" {
  value       = module.alb.alb_zone_id
  description = "The zone ID of the Application Load Balancer."
}

# Output for Security Group ID associated with the ALB
output "security_group_alb_id" {
  value       = module.security_group_alb.alb_sg_id
  description = "The ID of the Security Group associated with the ALB."
}

# Output for the ALB target group ARN
output "alb_target_group_arn" {
  value       = module.alb.alb_target_group_arn
  description = "The ARN of the Target Group associated with the ALB."
}
