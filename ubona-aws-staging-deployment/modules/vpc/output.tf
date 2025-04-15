output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidir" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet_2a_id" {
  value = aws_subnet.public_subnet_2a.id
}
output "public_subnet_2b_id" {
  value = aws_subnet.public_subnet_2b.id
}
output "private_subnet_2a_id" {
  value = aws_subnet.private_subnet_2a.id
}

output "private_subnet_2b_id" {
  value = aws_subnet.private_subnet_2b.id
}

output "db_subnet_2a_id" {
  value = aws_subnet.db_subnet_2a.id
}

output "db_subnet_2b_id" {
    value = aws_subnet.db_subnet_2b.id 
}

output "igw_id" {
    value = aws_internet_gateway.internet_gateway
}

output "public_subnet_2a_cidr" {
  value = aws_subnet.public_subnet_2a.cidr_block
}

output "public_subnet_2b_cidr" {
  value = aws_subnet.public_subnet_2b.cidr_block
}

output "private_subnet_2a_cidr" {
  value = aws_subnet.private_subnet_2a.cidr_block
}

output "private_subnet_2b_cidr" {
  value = aws_subnet.private_subnet_2b.cidr_block
}