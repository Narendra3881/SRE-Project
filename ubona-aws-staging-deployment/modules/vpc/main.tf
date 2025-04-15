# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support      = true
  tags                    = var.tags_vpc
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id
  tags      = var.tags_igw
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet in Az -ap-south-2a
resource "aws_subnet" "public_subnet_2a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2a_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true
  tags                    = var.tags_public_subnet_2a
}

# create public subnet in Az -2b
resource "aws_subnet" "public_subnet_2b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2b_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true
  tags                    = var.tags_public_subnet_2b
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = var.tags_public_route_table
}

# associate public subnet 2a to public route table
resource "aws_route_table_association" "public-subnet-2a_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_2a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet 2b to "public route table"
resource "aws_route_table_association" "public-subnet-2b_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_2b.id
  route_table_id      = aws_route_table.public_route_table.id
}

# create private app subnet private-subnet-2a
resource "aws_subnet" "private_subnet_2a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_2a_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = var.tags_private_subnet_2a
}

# create private app private-subnet-2b
resource "aws_subnet" "private_subnet_2b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_2b_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false
  tags                     = var.tags_private_subnet_2b
}

# create route table and add private route
resource "aws_route_table" "private_route_table" {
  vpc_id       = aws_vpc.vpc.id
  tags       = var.tags_private_route_table
}


# associate private subnet 2a to private route table
resource "aws_route_table_association" "private-subnet-2a_route_table_association" {
  subnet_id           = aws_subnet.private_subnet_2a.id
  route_table_id      = aws_route_table.private_route_table.id
}

# associate private subnet 2b to "private route table"
resource "aws_route_table_association" "private-subnet-2b_route_table_association" {
  subnet_id           = aws_subnet.private_subnet_2b.id
  route_table_id      = aws_route_table.private_route_table.id
}


# create private data subnet in Az 2a
resource "aws_subnet" "db_subnet_2a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.db_subnet_2a_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false
  tags                     = var.tags_db_subnet_2a
}

# create private data subnet in Az 2b
resource "aws_subnet" "db_subnet_2b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.db_subnet_2b_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false
  tags                     = var.tags_db_subnet_2b
}

# create route table and add "rds private route table"
resource "aws_route_table" "rds_pvt_route_table" {
  vpc_id     = aws_vpc.vpc.id
  tags       = var.tags_rds_pvt_route_table
}


# associate rds private subnet 2a to "rds private route table"
resource "aws_route_table_association" "rds_pvt-subnet-2a_route_table_association" {
  subnet_id           = aws_subnet.db_subnet_2a.id
  route_table_id      = aws_route_table.rds_pvt_route_table.id
}

# associate  rds private subnet 2b to "rds private route table"
resource "aws_route_table_association" "rds_pvt-subnet-2b_route_table_association" {
  subnet_id           = aws_subnet.db_subnet_2b.id
  route_table_id      = aws_route_table.rds_pvt_route_table.id
}