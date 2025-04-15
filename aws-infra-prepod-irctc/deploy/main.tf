
#######################################################################################################
# Data sources to reference existing VPC and subnets
######################################################################################################


data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnets_1" {
  vpc_id = var.vpc_id
  id = var.public_subnet_1_id
}

data "aws_subnet" "public_subnets_2" {
  vpc_id = var.vpc_id
  id = var.public_subnet_2_id
}

data "aws_subnet" "private_subnets_1" {
  vpc_id = var.vpc_id
  id = var.private_subnet_1_id
}

data "aws_subnet" "private_subnets_2" {
  vpc_id = var.vpc_id
  id = var.private_subnet_2_id
}

data "aws_subnet" "db_subnets_1" {
  vpc_id = var.vpc_id
  id = var.db_subnet_1_id
}

data "aws_subnet" "db_subnets_2" {
  vpc_id = var.vpc_id
  id = var.db_subnet_2_id
}


data "aws_availability_zones" "available_zones" {}


#######################################################################################################
# Bastionhost configuration 
#######################################################################################################

data "aws_iam_instance_profile" "bastionhost_instance_profile" {
  name = var.bastionhost_instance_profile 
}

resource "aws_instance" "bastion_host" {

    ami                     = var.bastionhost_ami
    instance_type           = var.instance_type_bastionhost
    key_name                = var.bastionhost_key_name

    subnet_id               = data.aws_subnet.public_subnets_1.id
    vpc_security_group_ids  = [aws_security_group.bastion_host_sg.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]
    iam_instance_profile    = data.aws_iam_instance_profile.bastionhost_instance_profile.name
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    
    }


    root_block_device {
      tags = var.tags_bastionhost_ebs_root_vol 
    }

    tags            = var.tags_bastionhost
}



############################################################################################################
# EIP for Bastion-Host
#########################################################################################################

resource "aws_eip" "eip_bastion_host" {
    domain   = "vpc"
    instance = aws_instance.bastion_host.id
    tags     = var.tags_bastionhost_eip
}
#######################################################################################################
# security groups for bastion host 
#######################################################################################################

resource "aws_security_group" "bastion_host_sg" {
  name        = var.bastion_host_sg_name
  description = var.bastion_host_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "ACT Ubona N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhost_ssh_access_cidr_act]
  }

  ingress {
    description      = "Airtel Ubona N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhost_ssh_access_cidr_airtel]
  }
 
  ingress {
    description      = "Ubona Gate N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhost_ssh_access_cidr_ubona_gate]
  }

  ingress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  tags = var.tags_bastionhost_sg
}

#######################################################################################################
# webserver configuration 
#######################################################################################################
data "aws_iam_instance_profile" "webserver_instance_profile" {
  name = var.webserver_instance_profile
}


resource "aws_instance" "webserver01" {
    ami                     = var.webserver_ami_01
    instance_type           = var.instance_type_webserver
    key_name                = var.webserver_key_name
    subnet_id               = data.aws_subnet.private_subnets_1.id
    vpc_security_group_ids  = [aws_security_group.webserver_sg.id ]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]
    iam_instance_profile    = data.aws_iam_instance_profile.webserver_instance_profile.name
    tags                    = var.tags_webserver01
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    
    }

    root_block_device {
      tags = var.tags_webserver01_ebs_root_vol 
    }

}

#resource "aws_instance" "webserver02" {
#    ami              = var.webserver_ami_02
#    instance_type    = var.instance_type_webserver
#    key_name         = var.webserver_key_name
#    subnet_id        = data.aws_subnet.private_subnets_2b.id
#    vpc_security_group_ids  = [aws_security_group.webserver_sg.id , aws_security_group.common_sg_nlb_subnets.id]
#    availability_zone       = data.aws_availability_zones.available_zones.names[1]
#
#    tags                    = var.tags_webserver02
#    #disable_api_termination = true # Enable termination protection
#
#    metadata_options {
#      http_tokens                   = "optional" # Makes IMDSv2 optional
#      http_endpoint                 = "enabled"  # Enables the instance metadata service
#      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
#      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
#
#    }
#
#    root_block_device {
#      tags = var.tags_webserver02_ebs_root_vol
#    }
#
#}
######################################################################################################
#EBS Volume for webserver
######################################################################################################
resource "aws_ebs_volume" "webserver01_volume" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  size              = var.ebs_size_webserver01_vol
  type              = var.ebs_type_webserver01_vol
  tags              = var.tags_ebs_webserver01_vol
}

resource "aws_volume_attachment" "webserver01_attachment" {
  device_name   = var.webserver_ebs_attachment_device_name
  volume_id     = aws_ebs_volume.webserver01_volume.id
  instance_id   = aws_instance.webserver01.id

  depends_on    = [aws_instance.webserver01, aws_ebs_volume.webserver01_volume]
}

######################################################################################################
# security group for webserver 
######################################################################################################

resource "aws_security_group" "webserver_sg" {
  name        = var.webserver_sg_name
  description = var.webserver_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "ssh from Bastionhost "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  
  ingress {
    description      = "http from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [module.security_group_alb.alb_sg_id]
  }

  ingress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  tags = var.tags_webserver_sg
}

resource "aws_security_group_rule" "web_to_app" {
  type              = "egress"
  from_port         = 8000
  to_port           = 8100
  protocol          = "tcp" 
  security_group_id = aws_security_group.webserver_sg.id
  source_security_group_id = aws_security_group.appserver_sg.id
}

resource "aws_security_group_rule" "web_to_proxy" {
  type              = "egress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  security_group_id = aws_security_group.webserver_sg.id
  source_security_group_id = aws_security_group.proxy_sg.id
}

resource "aws_security_group_rule" "web_to_reporting_server" {
  type              = "egress"
  from_port         = 3000
  to_port           = 3100
  protocol          = "tcp"
  security_group_id = aws_security_group.webserver_sg.id
  source_security_group_id = aws_security_group.reporting_server_sg.id
}
resource "aws_security_group_rule" "web_to_node_exporter" {
  type              = "egress"
  from_port         = 9100
  to_port           = 9100
  protocol          = "tcp"
  security_group_id = aws_security_group.webserver_sg.id
  cidr_blocks      = [var.centralized_monitoring_cidr_range]
}

resource "aws_security_group_rule" "webserver_to_redis_server" {
  type              = "egress"
  description       = "outbound to redis_server"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = aws_security_group.webserver_sg.id
  source_security_group_id = aws_security_group.redis_server_sg.id
}


#######################################################################################################
# appserver configuration 
#######################################################################################################

data "aws_iam_instance_profile" "appserver_instance_profile" {
  name = var.appserver_instance_profile 
}

resource "aws_instance" "appserver01" {
    ami                     = var.appserver_ami_01
    iam_instance_profile    = data.aws_iam_instance_profile.appserver_instance_profile.name
    instance_type           = var.instance_type_appserver
    key_name                = var.appserver_key_name
    subnet_id               = data.aws_subnet.private_subnets_1.id
    vpc_security_group_ids  = [aws_security_group.appserver_sg.id ]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]

    tags                    = var.tags_appserver01
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    }

    root_block_device {
      tags = var.tags_appserver01_ebs_root_vol 
    }
}
resource "aws_instance" "appserver02" {
    ami                     = var.appserver_ami_02
    iam_instance_profile    = data.aws_iam_instance_profile.appserver_instance_profile.name
    instance_type           = var.instance_type_appserver
    key_name                = var.appserver_key_name
    subnet_id               = data.aws_subnet.private_subnets_2.id
    vpc_security_group_ids  = [aws_security_group.appserver_sg.id ]
    availability_zone       = data.aws_availability_zones.available_zones.names[1]

    tags                    = var.tags_appserver02
    disable_api_termination = true # Enable termination protection

    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata

    }

    root_block_device {
      tags = var.tags_appserver02_ebs_root_vol
    }
}
######################################################################################################
#EBS Volume for appserver
######################################################################################################
resource "aws_ebs_volume" "appserver01_volume" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  size              = var.ebs_size_appserver01_vol
  type              = var.ebs_type_appserver01_vol
  tags              = var.tags_ebs_appserver01_vol
}

resource "aws_volume_attachment" "appserver01_attachment" {
  device_name   = var.appserver_ebs_attachment_device_name
  volume_id     = aws_ebs_volume.appserver01_volume.id
  instance_id   = aws_instance.appserver01.id

  depends_on    = [aws_instance.appserver01, aws_ebs_volume.appserver01_volume]
}

resource "aws_ebs_volume" "appserver02_volume" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  size              = var.ebs_size_appserver02_vol
  type              = var.ebs_type_appserver01_vol
  tags              = var.tags_ebs_appserver02_vol
}

resource "aws_volume_attachment" "appserver02_attachment" {
  device_name   = var.appserver_ebs_attachment_device_name
  volume_id     = aws_ebs_volume.appserver02_volume.id
  instance_id   = aws_instance.appserver02.id

  depends_on    = [aws_instance.appserver02, aws_ebs_volume.appserver02_volume]
}


#######################################################################################################
# Security group for appserver 
#######################################################################################################

resource "aws_security_group" "appserver_sg" {
  name        = var.appserver_sg_name
  description = var.appserver_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description       = "Allow SSH from Bastionhost "
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    security_groups   = [aws_security_group.bastion_host_sg.id]
  }

  
  ingress {
    description      = "Inbound from webserver"
    from_port        = 8000
    to_port          = 8100
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }

  ingress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  tags = var.tags_appserver_sg
}

resource "aws_security_group_rule" "appserver_to_proxy" {
  type              = "egress"
  description       = "appserver_to_proxy"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  source_security_group_id = aws_security_group.proxy_sg.id
  security_group_id = aws_security_group.appserver_sg.id
}

resource "aws_security_group_rule" "appserver_to_rds" {
  type              = "egress"
  description       = "outbound to rds"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id = aws_security_group.appserver_sg.id
}

resource "aws_security_group_rule" "appserver_to_node_exporter" {
  type              = "egress"
  description       = "outbound to node exporter"
  from_port         = 9100
  to_port           = 9100
  protocol          = "tcp"
  security_group_id = aws_security_group.appserver_sg.id
  cidr_blocks      = [var.centralized_monitoring_cidr_range]
}

resource "aws_security_group_rule" "appserver_to_redis_server" {
  type              = "egress"
  description       = "outbound to redis_server"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = aws_security_group.appserver_sg.id
  source_security_group_id = aws_security_group.redis_server_sg.id
}

resource "aws_security_group_rule" "appserver_to_msk" {
  type              = "egress"
  description       = "outbound to msk"
  from_port         = 9094
  to_port           = 9094
  protocol          = "tcp"
  security_group_id = aws_security_group.appserver_sg.id
  source_security_group_id = aws_security_group.msk_sg.id
}





#######################################################################################################
# Proxy server configiuration 
#######################################################################################################

resource "aws_instance" "proxy01" {
    ami              = var.proxy_ami_01
    instance_type    = var.instance_type_proxy
    key_name         = var.proxy_key_name

    subnet_id               = data.aws_subnet.public_subnets_1.id
    vpc_security_group_ids  = [aws_security_group.proxy_sg.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]

    tags                    = var.tags_proxy01
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    
    }

    root_block_device {
      tags = var.tags_proxy01_ebs_root_vol 
    }
}

#resource "aws_instance" "proxy02" {
#    ami              = var.proxy_ami_02
#    instance_type    = var.instance_type_proxy
#    key_name         = var.proxy_key_name
#
#    subnet_id        = data.aws_subnet.public_subnets_2.id
#    vpc_security_group_ids  = [aws_security_group.proxy_sg.id]
#    availability_zone       = data.aws_availability_zones.available_zones.names[1]
#
#    tags                    = var.tags_proxy02
#    #disable_api_termination = true # Enable termination protection
#
#    metadata_options {
#      http_tokens                   = "optional" # Makes IMDSv2 optional
#      http_endpoint                 = "enabled"  # Enables the instance metadata service
#      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
#      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
#
#    }
#
#    root_block_device {
#      tags = var.tags_proxy02_ebs_root_vol
#    }
#}

############################################################################################################
# EIP for Proxy1 and Proxy2
#########################################################################################################

resource "aws_eip" "eip_proxy01" {
    domain = "vpc"
    instance = aws_instance.proxy01.id
    tags = var.tags_proxy01_eip
}

#resource "aws_eip" "eip_proxy02" {
#    domain = "vpc"
#    instance = aws_instance.proxy02.id
#    tags = var.tags_proxy02_eip
#}

#######################################################################################################
# security groups for Proxyserver
#######################################################################################################


resource "aws_security_group" "proxy_sg" {
  name        = var.proxy_sg_name
  description = var.proxy_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "Allow ssh from bastionhost"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_host_sg.id]
  }

  ingress {
    description      = "Inbound from webserver "
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }

  ingress {
    description      = "Inbound from appserver "
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    security_groups  = [aws_security_group.appserver_sg.id]
  }

  ingress {
    description      = "Allow reporting-server "
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    security_groups  = [aws_security_group.reporting_server_sg.id]
  }

  ingress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  egress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags_proxy_sg
}


#######################################################################################################################
# Reporting server configuration
########################################################################################################################
data "aws_iam_instance_profile" "reporting_server_instance_profile" {
  name = var.reporting_server_instance_profile
}

resource "aws_instance" "reporting_server" {

    ami                     = var.reporting_server_ami
    iam_instance_profile    = data.aws_iam_instance_profile.reporting_server_instance_profile.name
    instance_type           = var.instance_type_reporting_server
    key_name                = var.reporting_server_key_name
    subnet_id               = data.aws_subnet.private_subnets_1.id
    vpc_security_group_ids = [aws_security_group.reporting_server_sg.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]
    disable_api_termination = true # Enable termination protection

    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata

    }


    root_block_device {
      tags = var.tags_reporting_server_ebs_root_vol
    }

    tags            = var.tags_reporting_server
}

######################################################################################################
#EBS Volume for Reporting server
######################################################################################################
resource "aws_ebs_volume" "reporting_server_volume" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  size              = var.ebs_size_reporting_server_vol
  type              = var.ebs_type_reporting_server_vol
  tags              = var.tags_ebs_reporting_server_vol
}

resource "aws_volume_attachment" "reporting_server_attachment" {
  device_name   = var.reporting_server_ebs_attachment_device_name
  volume_id     = aws_ebs_volume.reporting_server_volume.id
  instance_id   = aws_instance.reporting_server.id

  depends_on    = [aws_instance.reporting_server, aws_ebs_volume.reporting_server_volume]
}


#######################################################################################################
# Security group for Reporting server
#######################################################################################################

resource "aws_security_group" "reporting_server_sg" {
  name        = var.reporting_server_sg_name
  description = var.reporting_server_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description       = "Allow SSH from Bastionhost "
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    security_groups   = [aws_security_group.bastion_host_sg.id]
  }


  ingress {
    description      = "Inbound from appserver"
    from_port        = 8000
    to_port          = 8100
    protocol         = "tcp"
    security_groups  = [aws_security_group.appserver_sg.id]
  }

  ingress {
    description      = "Allow Metabase Access from Webserver"
    from_port        = 3000
    to_port          = 3010
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }

  ingress {
    description      = "Node exporter "
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = [var.centralized_monitoring_cidr_range]
  }

  tags = var.tags_reporting_server_sg
}

resource "aws_security_group_rule" "reporting_server_to_proxy" {
  type              = "egress"
  description       = "allow internet through squid"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  source_security_group_id = aws_security_group.proxy_sg.id
  security_group_id = aws_security_group.reporting_server_sg.id
}

resource "aws_security_group_rule" "reporting_server_to_rds" {
  type              = "egress"
  description       = "allow access to rds "
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id = aws_security_group.reporting_server_sg.id
}

resource "aws_security_group_rule" "reporting_server_to_node_exporter" {
  type              = "egress"
  description       = "outbound for node exporter "
  from_port         = 9100
  to_port           = 9100
  protocol          = "tcp"
  security_group_id = aws_security_group.reporting_server_sg.id
  cidr_blocks      = [var.centralized_monitoring_cidr_range]
}

########################################################################################################
# security group for ALB
########################################################################################################

module "security_group_alb" {
  source = "../modules/security_group_alb"
  vpc_id = data.aws_vpc.existing_vpc.id
}
#######################################################################################################
# Adding egress/outbound rule to the exiting ALB-security_group
#########################################################################################################

resource "aws_security_group_rule" "alb_to_webserver" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.security_group_alb.alb_sg_id
  source_security_group_id = aws_security_group.webserver_sg.id
}


#######################################################################################################
#Creating Application Load balancer and attaching Target group
#######################################################################################################

module "alb" {
  source                = "../modules/alb"
  alb_name              = var.alb_name
  alb_sg_id             = module.security_group_alb.alb_sg_id
  public_subnet_2a_id   = data.aws_subnet.public_subnets_1.id
  public_subnet_2b_id   = data.aws_subnet.public_subnets_2.id
  vpc_id                = data.aws_vpc.existing_vpc.id
  https_certificate_arn = var.https_certificate_arn
  tags                  = var.tags_alb
}


resource "aws_lb_target_group_attachment" "attach_webserver_2a" {
  target_group_arn = module.alb.alb_target_group_arn
  target_id        = aws_instance.webserver01.id
  port             = 80
}

#resource "aws_lb_target_group_attachment" "attach_webserver_2b" {
#  target_group_arn = module.alb.alb_target_group_arn
#  target_id        = aws_instance.webserver02.id
#  port             = 80
#}

######################################################################################################
# Security group for RDS
#######################################################################################################

resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = var.rds_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "Inbound from appserver"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.appserver_sg.id]
  }

  ingress {
    description      = "Inbound from reporting_server"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.reporting_server_sg.id]
  }

  tags = var.tags_rds_sg
}


######################################################################################################
# Security group for MSK
#######################################################################################################

resource "aws_security_group" "msk_sg" {
  name        = var.msk_sg_name
  description = var.msk_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "Inbound from appserver"
    from_port        = 9094
    to_port          = 9094
    protocol         = "tcp"
    security_groups  = [aws_security_group.appserver_sg.id]
  }

  tags = var.tags_rds_sg
}

######################################################################################################
# Security group for redis_server
#######################################################################################################

resource "aws_security_group" "redis_server_sg" {
  name        = var.redis_server_sg_name
  description = var.redis_server_sg_description
  vpc_id      = data.aws_vpc.existing_vpc.id

  ingress {
    description      = "Inbound from appserver"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    security_groups  = [aws_security_group.appserver_sg.id]
  }

  ingress {
    description      = "Inbound from webserver"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }

  tags = var.tags_redis_server_sg
}