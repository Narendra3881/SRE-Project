#aws_configuration
region                      = "ap-south-2"
project_name                = "ubona-staging-hyd"

#vpc
vpc_cidr                    = "10.6.200.0/23"
public_subnet_2a_cidr       = "10.6.200.0/26"
public_subnet_2b_cidr       = "10.6.200.64/26"
private_subnet_2a_cidr      = "10.6.200.128/25"
private_subnet_2b_cidr      = "10.6.201.0/25"
db_subnet_2a_cidr           = "10.6.201.128/26"
db_subnet_2b_cidr           = "10.6.201.192/26"

tags_vpc = {

    Name        = "ubona-hyd-stg-vpc"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_igw = {

    Name        = "ubona-hyd-stg-igw"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_public_subnet_2a = {

    Name        = "ubona-hyd-stg-public-subnet-2a"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_public_subnet_2b = {

    Name        = "ubona-hyd-stg-public-subnet-2b"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_private_subnet_2a = {

    Name        = "ubona-hyd-stg-private-subnet-2a"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_private_subnet_2b = {

    Name        = "ubona-hyd-stg-private-subnet-2b"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}


tags_public_route_table = {

    Name        = "ubona-hyd-stg-public-route-table"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_private_route_table = {

    Name        = "ubona-hyd-stg-private-route-table"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_db_subnet_2a = {

    Name        = "ubona-hyd-stg-db-subnet-2a"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_db_subnet_2b = {

    Name        = "ubona-hyd-stg-db-subnet-2b"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

 tags_rds_pvt_route_table = {

    Name        = "ubona-hyd-stg-rds-pvt-route-table"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#bastionhost
bastionhost_instance_profile  = "bastionhost-instance-profile"
instance_type_bastionhost     = "t3.medium"
bastionhost_ami               = "ami-092ae0e1b56c270b4"
bastionhost_key_name          = "ubona-hyd-stg-bastionhost-ssh-key"
tags_bastionhost              = {
    Name        = "ubona-hyd-stg-bastionhost"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_bastionhost_eip           = {
    Name        = "ubona-hyd-stg-bastionhost-eip"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_bastionhost_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-bastionhost-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"

}

#bastionhost-sg
bastion_host_sg_name                    = "ubona-hyd-stg-bastionhost-sg"
bastion_host_sg_description             = "allow SSH inbound traffic"
bastionhosst_ssh_access_cidr_act        = "106.51.38.129/32"
bastionhosst_ssh_access_cidr_airtel     = "122.166.214.222/32"
bastionhosst_ssh_access_cidr_ubona_gate = "124.7.139.85/32"
tags_bastionhost_sg           = {

    Name        = "ubona-hyd-stg-bastionhost-sg"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#webserver
instance_type_webserver = "t3.medium"
webserver_ami           = "ami-092ae0e1b56c270b4"
webserver_key_name      = "ubona-hyd-stg-webserver-ssh-key"

tags_webserver01 = {

    Name        = "ubona-hyd-stg-webserver01"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_webserver01_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-webserver01-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_webserver02 = {

    Name        = "ubona-hyd-stg-webserver02"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_webserver02_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-webserver02-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}
#common-sg
common_sg_name        = "ubona-hyd-stg-common-sg"
common_sg_description = "common sg group for outbound access to nlb subnets "

tags_common_sg        = {

    Name        = "ubona-hyd-stg-common-sg"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#webserver-sg
webserver_sg_name        = "ubona-hyd-stg-webserver-sg"
webserver_sg_description = "allow SSH from bastionhost and inbound traffic from ALB"
tags_webserver_sg        = {

    Name        = "ubona-hyd-stg-webserver-sg"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#appserver
appserver_instance_profile  = "ec2-instance-profile"
instance_type_appserver     = "t3.medium"
appserver_ami               = "ami-0e5b177a01f872f3b"
appserver_key_name          = "ubona-hyd-stg-appserver-ssh-key"

tags_appserver01 = {

    Name        = "ubona-hyd-stg-appserver01"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_appserver01_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-appserver01-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_appserver02 = {

    Name        = "ubona-hyd-stg-appserver02"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_appserver02_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-appserver02-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"

}

#appserver-sg
appserver_sg_name        = "ubona-hyd-stg-appserver-sg"
appserver_sg_description = "allow SSH from bastionhost and inbound traffic from webserver"
tags_appserver_sg        = {

    Name        = "ubona-hyd-stg-appserver-sg"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#EBS Volume for appserver

ebs_size_appserver01_vol = "50"
ebs_type_appserver01_vol = "gp3"
ebs_size_appserver02_vol = "50"
ebs_type_appserver02_vol = "gp3"
appserver_ebs_attachment_device_name = "/dev/xvdb"

tags_ebs_appserver01_vol = {

    Name = "ubona-hyd-stg-appserver01-Volume"
    Environment = "ubona-hyd-staging"
    Project = "halo-cloud"
    Created-By  = "terraform"
}

tags_ebs_appserver02_vol = {

    Name = "ubona-hyd-stg-appserver02-Volume"
    Environment = "ubona-hyd-staging"
    Project = "halo-cloud"
    Created-By  = "terraform"

}


#proxyserver
instance_type_proxy = "t3.medium"
proxy_ami           = "ami-092ae0e1b56c270b4"
proxy_key_name      = "ubona-hyd-stg-proxy-ssh-key"

tags_proxy01 = {

    Name        = "ubona-hyd-stg-proxy01"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_proxy01_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-proxy01-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_proxy02 = {

    Name        = "ubona-hyd-stg-proxy02"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_proxy02_ebs_root_vol   = {
    Name        = "ubona-hyd-stg-proxy02-root-ebs"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"

}

#Eip for proxy servers

tags_proxy01_eip = {

    Name        = "ubona-hyd-stg-proxy01-eip"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

tags_proxy02_eip = {

    Name        = "ubona-hyd-stg-proxy02-eip"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#proxy-sg
proxy_sg_name        = "ubona-hyd-stg-proxy-sg"
proxy_sg_description = "allow SSH from bastionhost and inbound traffic from webserver and appserver"
tags_proxy_sg        = {
    Name        = "ubona-hyd-stg-proxy-sg"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

# ALB Variables
https_certificate_arn = "arn:aws:acm:ap-south-2:799401455572:certificate/70c65f63-bf52-4c3d-8e38-638831032f0a"
tags_alb              = {
    Name        = "ubona-hyd-stg-alb"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

# NLB variables
tags_nlb_internal   = {
    Name        = "ubona-hyd-stg-nlb-internal"
    Environment = "staging"
    Project     = "halo-cloud"
    Created-By  = "terraform"
}

#Route53 hosted zone id
route53_zone_id = "Z03774703HO2YNVYBNOCU"

# The subdomain for the CNAME record to route traffic between nlb and proxy
cname_record_name = "hydproxy.ubona-internal.com"

