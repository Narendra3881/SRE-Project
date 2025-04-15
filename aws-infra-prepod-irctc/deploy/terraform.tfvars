#aws_configuration
region                      = "ap-south-1"
project_name                = "IRCTC"
environment                 = "irctcrail-preprod"

#vpc
vpc_id                     = "vpc-xxxxxxxxxxxxxxxxx"
public_subnet_1_id         = "subnet-xxxxxxxxxxxxx4a"
public_subnet_2_id         = "subnet-xxxxxxxxxxxxx47"
private_subnet_1_id        = "subnet-xxxxxxxxxxxxxda"
private_subnet_2_id        = "subnet-xxxxxxxxxxxxx39"
db_subnet_1_id             = "subnet-xxxxxxxxxxxxxfb"
db_subnet_2_id             = "subnet-xxxxxxxxxxxxd6c"

#bastionhost
bastionhost_instance_profile  = "bastionhost-instance-profile"
instance_type_bastionhost     = "t3a.medium"
bastionhost_ami               = "ami-xxxxxxxxxxxxxx7cc"
bastionhost_key_name          = "irctc-preprod-bastionhost"


tags_bastionhost              = {
    Name        = "irctcrail-preprod-bastionhost"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_bastionhost_eip           = {
    Name        = "irctcrail-preprod-bastion-host-eip"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_bastionhost_ebs_root_vol   = {
    Name        = "irctcrail-preprod-bastionhost-root-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"

}

#bastionhost-sg
bastion_host_sg_name                   = "irctcrail-preprod-bastionhost-sg"
bastion_host_sg_description            = "allow SSH inbound traffic"
bastionhost_ssh_access_cidr_act        = "xxxxxxxxxxxxx/32"
bastionhost_ssh_access_cidr_airtel     = "xxxxxxxxxxxxx/32"
bastionhost_ssh_access_cidr_ubona_gate = "xxxxxxxxxxxxx/32"
tags_bastionhost_sg           = {

    Name        = "irctcrail-preprod-bastionhost-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#webserver
webserver_instance_profile  = "ec2_api_role"
instance_type_webserver     = "c5.large"
webserver_ami_01            = "ami-xxxxxxxxxxxxxcc"
webserver_key_name          = "irctc-preprod-webserver"

tags_webserver01 = {

    Name        = "irctcrail-preprod-webserver"
    Environment = "irctcrail-preprod"
    Created-By  = "terraform"
}

tags_webserver01_ebs_root_vol   = {
    Name        = "irctcrail-preprod-webserver-root-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#EBS Volume for webserver

ebs_size_webserver01_vol = "50"
ebs_type_webserver01_vol = "gp3"
webserver_ebs_attachment_device_name = "/dev/sdb"

tags_ebs_webserver01_vol = {

    Name        = "irctcrail-preprod-webserver01-data-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#webserver-sg
webserver_sg_name        = "irctcrail-preprod-webserver-sg"
webserver_sg_description = "allow SSH from bastionhost and inbound traffic from ALB"
tags_webserver_sg        = {

    Name        = "irctcrail-preprod-webserver-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#appserver
appserver_instance_profile  = "ec2_api_role"
instance_type_appserver     = "m6i.large"
appserver_ami_01            = "ami-0xxxxxxxxxx7cc"
appserver_ami_02            = "ami-0xxxxxxxxxx97cc"
appserver_key_name          = "irctc-preprod-appserver"

tags_appserver01 = {

    Name        = "irctcrail-preprod-appserver01"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_appserver01_ebs_root_vol   = {
    Name        = "irctcrail-preprod-appserver01-ebs-root-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_appserver02 = {

    Name        = "irctcrail-preprod-appserver02"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_appserver02_ebs_root_vol   = {
    Name        = "irctcrail-preprod-appserver02-ebs-root-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"

}

#EBS Volume for appserver

ebs_size_appserver01_vol = "50"
ebs_type_appserver01_vol = "gp3"
ebs_size_appserver02_vol = "50"
ebs_type_appserver02_vol = "gp3"
appserver_ebs_attachment_device_name = "/dev/sdb"

tags_ebs_appserver01_vol = {

    Name        = "irctcrail-preprod-appserver01-data-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_ebs_appserver02_vol = {

    Name        = "irctcrail-preprod-appserver02-data-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"

}


#appserver-sg
appserver_sg_name        = "irctcrail-preprod-appserver-sg"
appserver_sg_description = "allow SSH from bastionhost and inbound traffic from webserver"
tags_appserver_sg        = {
    Name        = "irctcrail-preprod-appserver-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"

}

#proxyserver
instance_type_proxy   = "t3a.medium"
proxy_ami_01          = "ami-xxxxxxxxxxxxxxxxx7cc"
proxy_key_name        = "irctc-preprod-proxyserver"

tags_proxy01 = {

    Name        = "irctcrail-preprod-proxy"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_proxy01_ebs_root_vol   = {
    Name        = "irctcrail-preprod-proxy-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#Eip for proxy servers

tags_proxy01_eip = {

    Name        = "irctcrail-preprod-proxy-eip"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}



#proxy-sg
proxy_sg_name        = "irctcrail-preprod-proxy-sg"
proxy_sg_description = "allow SSH from bastionhost and inbound traffic from webserver and appserver"
tags_proxy_sg        = {
    Name        = "irctcrail-preprod-proxy-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}



#Reporting-server variables
reporting_server_instance_profile  = "ec2_api_role"
instance_type_reporting_server     = "m6i.large"
reporting_server_ami               = "ami-0xxxxxxxxxxxx7cc"
reporting_server_key_name          = "irctc-preprod-reporting-server"
existing_reporting_server_sg       = "sg-0xxxxxxxxxxxxxxx5f"

tags_reporting_server            = {
    Name        = "irctcrail-preprod-reporting-server"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

tags_reporting_server_ebs_root_vol   = {
    Name        = "irctcrail-preprod-reporting-server-root-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"

}


#EBS Volume for reporting_server

ebs_size_reporting_server_vol = "50"
ebs_type_reporting_server_vol = "gp3"
reporting_server_ebs_attachment_device_name = "/dev/sdb"

tags_ebs_reporting_server_vol = {

    Name        = "irctcrail-preprod-reporting_server-data-vol"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#Reporting_server-sg
reporting_server_sg_name        = "irctcrail-preprod-reporting_server-sg"
reporting_server_sg_description = "allow SSH from bastionhost and inbound traffic from webserver and appserver"
tags_reporting_server_sg        = {
    Name        = "irctcrail-preprod-reporting_server-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

# ALB Variables
alb_name              ="irctcrail-preprod-alb"
https_certificate_arn = "arn:aws:acm:ap-south-1:xxxxxxxxx:certificate/xxxxxxxxxxxxx62"
tags_alb              = {
    Name        = "irctcrail-preprod-alb"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

# RDS sg Variables
rds_sg_name        = "irctcrail-preprod-rds-sg"
rds_sg_description =  "Allow inbound for appserver and reporting server"
tags_rds_sg        = {
    Name        = "irctcrail-preprod-rds-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

#Monitoring service variables
centralized_monitoring_cidr_range ="10xxxxxx/16"

# MSK sg Variables
msk_sg_name        = "irctcrail-preprod-msk-sg"
msk_sg_description =  "Allow inbound from appserver "
tags_msk_sg        = {
    Name        = "irctcrail-preprod-msk-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}

# redis_server sg Variables
redis_server_sg_name        = "irctcrail-preprod-redis-server-sg"
redis_server_sg_description =  "Allow inbound from appserver and webserver"
tags_redis_server_sg        = {
    Name        = "irctcrail-preprod-redis-server-sg"
    Environment = "irctcrail-preprod"
    Project     = "IRCTC"
    Created-By  = "terraform"
}
