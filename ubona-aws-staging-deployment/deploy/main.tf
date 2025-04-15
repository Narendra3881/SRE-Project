
#######################################################################################################
# VPC Configuration 
######################################################################################################
module "vpc" {
    source = "../modules/vpc"
    region                   = var.region
    project_name             = var.project_name
    vpc_cidr                 = var.vpc_cidr
    public_subnet_2a_cidr    = var.public_subnet_2a_cidr
    public_subnet_2b_cidr    = var.public_subnet_2b_cidr 
    private_subnet_2a_cidr   = var.private_subnet_2a_cidr
    private_subnet_2b_cidr   = var.private_subnet_2b_cidr
    db_subnet_2a_cidr        = var.db_subnet_2a_cidr
    db_subnet_2b_cidr        = var.db_subnet_2b_cidr
    tags_vpc                 = var.tags_vpc
    tags_igw                 = var.tags_igw
    tags_public_subnet_2a    = var.tags_public_subnet_2a
    tags_public_subnet_2b    = var.tags_public_subnet_2b
    tags_public_route_table  = var.tags_public_route_table
    tags_private_subnet_2a   = var.tags_private_subnet_2a
    tags_private_subnet_2b   = var.tags_private_subnet_2b
    tags_private_route_table = var.tags_private_route_table
    tags_db_subnet_2a        = var.tags_db_subnet_2a
    tags_db_subnet_2b        = var.tags_db_subnet_2b
    tags_rds_pvt_route_table = var.tags_rds_pvt_route_table
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

    subnet_id               = module.vpc.public_subnet_2a_id
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
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "ACT Ubona N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhosst_ssh_access_cidr_act]
  }

  ingress {
    description      = "Airtel Ubona N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhosst_ssh_access_cidr_airtel]
  }
 
  ingress {
    description      = "Ubona Gate N/W "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.bastionhosst_ssh_access_cidr_ubona_gate]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags_bastionhost_sg
}

#######################################################################################################
# webserver configuration 
#######################################################################################################

resource "aws_instance" "webserver01" {
    ami              = var.webserver_ami
    instance_type    = var.instance_type_webserver
    key_name         = var.webserver_key_name
    subnet_id        = module.vpc.private_subnet_2a_id
    vpc_security_group_ids  = [aws_security_group.webserver_sg.id , aws_security_group.common_sg_nlb_subnets.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[0]

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

resource "aws_instance" "webserver02" {
    ami              = var.webserver_ami
    instance_type    = var.instance_type_webserver
    key_name         = var.webserver_key_name
    subnet_id        = module.vpc.private_subnet_2b_id
    vpc_security_group_ids  = [aws_security_group.webserver_sg.id , aws_security_group.common_sg_nlb_subnets.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[1]

    tags                    = var.tags_webserver02
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    
    }

    root_block_device {
      tags = var.tags_webserver02_ebs_root_vol 
    }

}
######################################################################################################
# security group for webserver 
######################################################################################################

resource "aws_security_group" "webserver_sg" {
  name        = var.webserver_sg_name
  description = var.webserver_sg_description
  vpc_id      = module.vpc.vpc_id

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

  tags = var.tags_webserver_sg
}

resource "aws_security_group_rule" "web_to_app" {
  type              = "egress"
  from_port         = 8000
  to_port           = 9000
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

#######################################################################################################
# appserver configuration 
#######################################################################################################

data "aws_iam_instance_profile" "appserver_instance_profile" {
  name = var.appserver_instance_profile 
}

resource "aws_instance" "appserver01" {
    ami                     = var.appserver_ami
    iam_instance_profile    = data.aws_iam_instance_profile.appserver_instance_profile.name
    instance_type           = var.instance_type_appserver
    key_name                = var.appserver_key_name
    subnet_id               = module.vpc.private_subnet_2a_id
    vpc_security_group_ids  = [aws_security_group.appserver_sg.id , aws_security_group.common_sg_nlb_subnets.id]
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
    ami                     = var.appserver_ami
    iam_instance_profile    = data.aws_iam_instance_profile.appserver_instance_profile.name
    instance_type           = var.instance_type_appserver
    key_name                = var.appserver_key_name
    subnet_id               = module.vpc.private_subnet_2b_id
    vpc_security_group_ids  = [aws_security_group.appserver_sg.id , aws_security_group.common_sg_nlb_subnets.id]
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

#######################################################################################################
# Security group for appserver 
#######################################################################################################

resource "aws_security_group" "appserver_sg" {
  name        = var.appserver_sg_name
  description = var.appserver_sg_description
  vpc_id      = module.vpc.vpc_id

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
    to_port          = 9000
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id]
  }
  
  tags = var.tags_appserver_sg
}

resource "aws_security_group_rule" "appserver_to_proxy" {
  type              = "egress"
  from_port         = 3128
  to_port           = 3128
  protocol          = "tcp"
  source_security_group_id = aws_security_group.proxy_sg.id
  security_group_id = aws_security_group.appserver_sg.id
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
  device_name   =  var.appserver_ebs_attachment_device_name
  volume_id     = aws_ebs_volume.appserver02_volume.id
  instance_id   = aws_instance.appserver02.id

  depends_on    = [aws_instance.appserver02, aws_ebs_volume.appserver02_volume]
}


#######################################################################################################
# Proxy server configiuration 
#######################################################################################################

resource "aws_instance" "proxy01" {
    ami              = var.proxy_ami
    instance_type    = var.instance_type_proxy
    key_name         = var.proxy_key_name

    subnet_id               = module.vpc.public_subnet_2a_id
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

resource "aws_instance" "proxy02" {
    ami              = var.proxy_ami
    instance_type    = var.instance_type_proxy
    key_name         = var.proxy_key_name

    subnet_id        = module.vpc.public_subnet_2b_id
    vpc_security_group_ids  = [aws_security_group.proxy_sg.id]
    availability_zone       = data.aws_availability_zones.available_zones.names[1]

    tags                    = var.tags_proxy02
    disable_api_termination = true # Enable termination protection
    
    metadata_options {
      http_tokens                   = "optional" # Makes IMDSv2 optional
      http_endpoint                 = "enabled"  # Enables the instance metadata service
      http_put_response_hop_limit   = 1          # The desired HTTP PUT response hop limit for instance metadata requests
      instance_metadata_tags        = "enabled"  # Enables the use of tags in instance metadata
    
    }

    root_block_device {
      tags = var.tags_proxy02_ebs_root_vol 
    }
}

############################################################################################################
# EIP for Proxy1 and Proxy2
#########################################################################################################

resource "aws_eip" "eip_proxy01" {
    domain = "vpc"
    instance = aws_instance.proxy01.id
    tags = var.tags_proxy01_eip
}

resource "aws_eip" "eip_proxy02" {
    domain = "vpc"
    instance = aws_instance.proxy02.id
    tags = var.tags_proxy02_eip
}

#######################################################################################################
# security groups for Proxyserver
#######################################################################################################


resource "aws_security_group" "proxy_sg" {
  name        = var.proxy_sg_name
  description = var.proxy_sg_description
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow ssh from bastionhost"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_host_sg.id]
  }

  ingress {
    description      = "Inbound from webserver and appserver "
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_sg.id, aws_security_group.appserver_sg.id ]
  }

  ingress {
    description       = "Allow nlb for subnets"
    from_port         = 3128
    to_port           = 3128
    protocol          = "tcp"
    cidr_blocks       = [module.vpc.private_subnet_2a_cidr, module.vpc.private_subnet_2b_cidr] 
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags_proxy_sg
}

########################################################################################################
# Common sg group to allow nlb subnet as outbound 
########################################################################################################
resource "aws_security_group" "common_sg_nlb_subnets" {
  name        = var.common_sg_name
  description = var.common_sg_description
  vpc_id      = module.vpc.vpc_id

  egress {
    description       = "outbound for nlb subnets"
    from_port         = 3128
    to_port           = 3128
    protocol          = "tcp"
    cidr_blocks       = [module.vpc.private_subnet_2a_cidr, module.vpc.private_subnet_2b_cidr] 
  }
   tags = var.tags_common_sg
}
########################################################################################################
# security group for ALB
########################################################################################################

module "security_group_alb" {
  source = "../modules/security_group_alb"
  vpc_id = module.vpc.vpc_id
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
  project_name          = module.vpc.project_name
  alb_sg_id             = module.security_group_alb.alb_sg_id
  public_subnet_2a_id   = module.vpc.public_subnet_2a_id
  public_subnet_2b_id   = module.vpc.public_subnet_2b_id
  vpc_id                = module.vpc.vpc_id
  https_certificate_arn = var.https_certificate_arn
  tags                  = var.tags_alb
}


resource "aws_lb_target_group_attachment" "attach_webserver_2a" {
  target_group_arn = module.alb.alb_target_group_arn
  target_id        = aws_instance.webserver01.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_webserver_2b" {
  target_group_arn = module.alb.alb_target_group_arn
  target_id        = aws_instance.webserver02.id
  port             = 80
}

########################################################################################################
# Network load balancer configuration 
########################################################################################################

module "network_load_balancer" {
  source                  = "../modules/network_load_balancer"
  project_name            = module.vpc.project_name
  private_subnet_2a_id    = module.vpc.private_subnet_2a_id
  private_subnet_2b_id    = module.vpc.private_subnet_2b_id
  vpc_id                  = module.vpc.vpc_id
  tags                    = var.tags_nlb_internal
  
}

resource "aws_lb_target_group_attachment" "proxy01" {
  target_group_arn = module.network_load_balancer.target_group_arn
  target_id        = aws_instance.proxy01.id #using aws_instance resource block in order to create implicit dependency on proxy01
  port             = 3128
}

resource "aws_lb_target_group_attachment" "proxy02" {
  target_group_arn = module.network_load_balancer.target_group_arn
  target_id        = aws_instance.proxy02.id #using aws_instance resource block in order to create implicit dependency on proxy02
  port             = 3128
}

###########################################################################################################
# Add a CNAME record in Route 53 pointing to the NLB's DNS name
#######################################################################################################


resource "aws_route53_record" "my_nlb_cname_record" {
  zone_id = var.route53_zone_id 
  name    = var.cname_record_name  # The subdomain for the CNAME record
  type    = "CNAME"
  ttl     = "300" # Time to live
  records = [module.network_load_balancer.network_load_balancer_dns_name]
}

# Associate Route 53 zone with a VPC
resource "aws_route53_zone_association" "Associate_vpc_hosted_zone" {
  zone_id = var.route53_zone_id   # The ID of the hosted zone to associate with the VPC
  vpc_id  = module.vpc.vpc_id           # The ID of the VPC to be associated
}



