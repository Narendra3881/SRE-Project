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

output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}
output "public_subnet_1b_id" {
  value = aws_subnet.public_subnet_1b.id
}
output "private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private_subnet_1b.id
}

output "db_subnet_1a_id" {
  value = aws_subnet.db_subnet_1a.id
}

output "db_subnet_1b_id" {
    value = aws_subnet.db_subnet_1b.id
}

output "igw_id" {
    value = aws_internet_gateway.internet_gateway
}

output "public_subnet_1a_cidr" {
  value = aws_subnet.public_subnet_1a.cidr_block
}

output "public_subnet_1b_cidr" {
  value = aws_subnet.public_subnet_1b.cidr_block
}

output "private_subnet_1a_cidr" {
  value = aws_subnet.private_subnet_1a.cidr_block
}

output "private_subnet_1b_cidr" {
  value = aws_subnet.private_subnet_1b.cidr_block
}