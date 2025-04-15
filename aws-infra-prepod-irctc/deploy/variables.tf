variable region {
  description = "AWS region in which the resources should be created"
  type        = string
  default     = ""
}

variable environment {
  description = "AWS environment in which the resources should be created"
  type        = string
  default     = ""
}

variable project_name {
  description = "Name of the project"
  type        = string
  default     = ""
}

variable proxy_domain {
  description = "Name of the proxy"
  type        = string
  default     = ""
}


variable "vpc_id" {
  description = "The ID of the ubona bcp dr hyderbad VPC"
  type        = string
}

variable "public_subnet_1_id" {
  description = "The ID of the first public subnet(a)."
  type        = string
  default     = ""
}
variable "public_subnet_2_id" {
  description = "The ID of the second public subnet(b)."
  type        = string
  default     = ""
}

variable "private_subnet_1_id" {
  description = "The ID of the first private subnet(a)."
  type        = string
  default     = ""
}
variable "private_subnet_2_id" {
  description = "The ID of the second private subnet(b)."
  type        = string
  default     = ""
}

variable "db_subnet_1_id" {
  description = "The ID of the first database subnet(a)."
  type        = string
  default     = ""
}
variable "db_subnet_2_id" {
  description = "The ID of the second database subnet(b)."
  type        = string
  default     = ""
}

#bastionhost variables

variable "bastionhost_instance_profile" {
  description = "The type of instance profile to assume role to the instance"
  type        = string
  default     = ""
}

variable "instance_type_bastionhost" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "bastionhost_ami" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

variable "bastionhost_key_name" {
  description = "Name of the ssh key for instance"
  type        = string
  default     = ""
}

variable "tags_bastionhost" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_bastionhost_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}



#EIP for bastionhost variables

variable "tags_bastionhost_eip" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

# security groups for bastion host variables
variable "bastion_host_sg_name" {
  description = "The name of the bastion host security group"
  type        = string
}

variable "bastion_host_sg_description" {
  description = "The description of the bastion host security group"
  type        = string
}

variable "tags_bastionhost_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "bastionhost_ssh_access_cidr_act" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

variable "bastionhost_ssh_access_cidr_airtel" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

variable "bastionhost_ssh_access_cidr_ubona_gate" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

#webserver variables

variable "webserver_instance_profile" {
  description = "The type of instance profile to assume role to the instance"
  type        = string
  default     = ""
}


variable "instance_type_webserver" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "webserver_ami_01" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

#variable "webserver_ami_02" {
#  description = "The image ami id for instance"
#  type        = string
#  default     = ""
#}

variable "webserver_key_name" {
  description = "Name of the ssh key for instance"
  type        = string
  default     = ""
}

variable "tags_webserver01" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#variable "tags_webserver02" {
#  description = "A map of tags to add to the resources"
#  type        = map(string)
#  default     = {}
#}

# security group for webserver variables

variable "webserver_sg_name" {
  description = "The name of the webserver security group"
  type        = string
}

variable "webserver_sg_description" {
  description = "The description of the webserver security group"
  type        = string
}

variable "tags_webserver_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_webserver01_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#variable "tags_webserver02_ebs_root_vol"  {
#  description = "A map of tags to add to the resources"
#  type        = map(string)
#  default     = {}
#}

#EBS attachment Volume for webserver

variable "ebs_size_webserver01_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "ebs_type_webserver01_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "tags_ebs_webserver01_vol" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "webserver_ebs_attachment_device_name" {
  description = "Name of the device to attach to the instance"
  type        = string
  default     = ""
}
#appserver variables 

variable "appserver_instance_profile" {
  description = "The type of instance profile to assume role to the instance"
  type        = string
  default     = ""
}

variable "instance_type_appserver" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "appserver_ami_01" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

variable "appserver_ami_02" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

variable "appserver_key_name" {
  description = "Name of the ssh key for the instances"
  type        = string
  default     = ""
}

variable "tags_appserver01" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_appserver02" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_appserver01_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_appserver02_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#EBS attachment Volume for appserver

variable "ebs_size_appserver01_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "ebs_type_appserver01_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "tags_ebs_appserver01_vol" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "ebs_size_appserver02_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "ebs_type_appserver02_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "tags_ebs_appserver02_vol" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "appserver_ebs_attachment_device_name" {
  description = "Name of the device to attach to the instance"
  type        = string
  default     = ""
}


# security group for appserver variables

variable "appserver_sg_name" {
  description = "The name of the appserver security group"
  type        = string
}

variable "appserver_sg_description" {
  description = "The description of the appserver security group"
  type        = string
}

variable "tags_appserver_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}


#proxyserver variables 

variable "instance_type_proxy" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "proxy_ami_01" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}
#variable "proxy_ami_02" {
#  description = "The image ami id for instance"
#  type        = string
#  default     = ""
#}

variable "proxy_key_name" {
  description = "Name of the ssh key for the instances"
  type        = string
  default     = ""
}

variable "tags_proxy01" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#variable "tags_proxy02" {
#  description = "A map of tags to add to the resources"
#  type        = map(string)
#  default     = {}
#}

variable "tags_proxy01_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#variable "tags_proxy02_ebs_root_vol"  {
#  description = "A map of tags to add to the resources"
#  type        = map(string)
#  default     = {}
#}

#EIP for proxy variables

variable "tags_proxy01_eip" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
#variable "tags_proxy02_eip" {
#  description = "A map of tags to add to the resources"
#  type        = map(string)
#  default     = {}
#}



# security groups for proxy variables
variable "proxy_sg_name" {
  description = "The name of the proxy security group"
  type        = string
}

variable "proxy_sg_description" {
  description = "The description of the proxy security group"
  type        = string
}

variable "tags_proxy_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#Reporting_server variables

variable "reporting_server_instance_profile" {
  description = "The type of instance profile to assume role to the instance"
  type        = string
  default     = ""
}

variable "instance_type_reporting_server" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "existing_reporting_server_sg" {
  description = "Existing reporting_server-sg-id"
  type        = string
  default     = ""
}

variable "reporting_server_ami" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

variable "reporting_server_key_name" {
  description = "Name of the ssh key for instance"
  type        = string
  default     = ""
}

variable "tags_reporting_server" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_reporting_server_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}


#EBS attachment Volume for reporting_server

variable "ebs_size_reporting_server_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "ebs_type_reporting_server_vol" {
  description = "The type of ebs volume to create"
  type        = string
  default     = ""
}

variable "tags_ebs_reporting_server_vol" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "reporting_server_ebs_attachment_device_name" {
  description = "Name of the device to attach to the instance"
  type        = string
  default     = ""
}

# security groups for reporting_server variables
variable "reporting_server_sg_name" {
  description = "The name of the reporting_server security group"
  type        = string
  default     = ""
}

variable "reporting_server_sg_description" {
  description = "The description of the reporting_server security group"
  type        = string
  default     = ""
}

variable "tags_reporting_server_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

# ALB variables
variable "alb_name" {
  description = "The Name of the ALB"
  type        = string
  default     = ""
}

variable "https_certificate_arn" {
  description = "The ARN of the SSL/TLS certificate to be used for HTTPS communication on the ALB"
  type        = string
  default     = ""
}

variable "tags_alb" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

# security groups for RDS variables
variable "rds_sg_name" {
  description = "The name of the rds security group"
  type        = string
  default     = ""
}

variable "rds_sg_description" {
  description = "The description of the rds security group"
  type        = string
  default     = ""
}

variable "tags_rds_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#Monitoring service variables

variable "centralized_monitoring_cidr_range" {
  description = "The Cidir Range for centralized Monitoring"
  type        = string
  default     = ""
}

# security groups for MSK variables
variable "msk_sg_name" {
  description = "The name of the msk security group"
  type        = string
  default     = ""
}

variable "msk_sg_description" {
  description = "The description of the msk security group"
  type        = string
  default     = ""
}

variable "tags_msk_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

# security groups for redis_server variables

variable "redis_server_sg_name" {
  description = "The name of the redis_server security group"
  type        = string
  default     = ""
}

variable "redis_server_sg_description" {
  description = "The description of the redis_server security group"
  type        = string
  default     = ""
}

variable "tags_redis_server_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}