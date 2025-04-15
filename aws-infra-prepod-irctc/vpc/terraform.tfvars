#aws_configuration
region                      = "ap-south-1"
project_name                = "IRCTC"

#vpc
vpc_cidr                    = "10xxxxxxxxxxx/23"
public_subnet_1a_cidr       = "10xxxxxxxxxxx/26"
public_subnet_1b_cidr       = "10xxxxxxxxxxx/26"
private_subnet_1a_cidr      = "10xxxxxxxxxxx/25"
private_subnet_1b_cidr      = "10xxxxxxxxxxx/25"
db_subnet_1a_cidr           = "10xxxxxxxxxxx/26"
db_subnet_1b_cidr           = "10xxxxxxxxxxx/26"

tags_vpc = {

    Name        = "irctcrail-preprod-vpc"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}
    
tags_igw = {

    Name        = "irctcrail-preprod-igw"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_public_subnet_1a = {
    
    Name        = "irctcrail-preprod-public-subnet-1a"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_public_subnet_1b = {

    Name        = "irctcrail-preprod-public-subnet-1b"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_private_subnet_1a = {

    Name        = "irctcrail-preprod-private-subnet-1a"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_private_subnet_1b = {

    Name        = "irctcrail-preprod-private-subnet-1b"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}


tags_public_route_table = {

    Name        = "irctcrail-preprod-public-route-table"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_private_route_table = {

    Name        = "irctcrail-preprod-private-route-table"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_db_subnet_1a = {

    Name        = "irctcrail-preprod-db-subnet-1a"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_db_subnet_1b = {

    Name        = "irctcrail-preprod-db-subnet-1b"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

 tags_rds_pvt_route_table = {

    Name        = "irctcrail-preprod-rds-pvt-route-table"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}
