#vpc variables 

variable region {
  description = "AWS region in which the resources should be created"
  type        = string
  default     = ""
}
variable project_name {
  description = "Name of the project"
  type        = string
  default     = ""
}
variable vpc_cidr {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}    
variable public_subnet_2a_cidr {
  description = "The CIDR block for the public subnet in availability zone 2a"
  type        = string
  default     = ""
}

variable public_subnet_2b_cidr {
  description = "The CIDR block for the public subnet in availability zone 2b"
  type        = string
  default     = ""
}

variable private_subnet_2a_cidr {
  description = "The CIDR block for the private subnet in availability zone 2a"
  type        = string
  default     = ""
}

variable private_subnet_2b_cidr {
  description = "The CIDR block for the private subnet in availability zone 2b"
  type        = string
  default     = ""
}

variable db_subnet_2a_cidr {
  description = "The CIDR block for the Database subnet in availability zone 2a"
  type        = string
  default     = ""
}
variable db_subnet_2b_cidr {
  description = "The CIDR block for the Database subnet in availability zone 2a"
  type        = string
  default     = ""
}
variable https_certificate_arn {
  description = "The ARN of the SSL certificate used for HTTPS"
  type        = string
  default     = ""
}

variable "tags_vpc"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_igw"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_public_subnet_2a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_public_subnet_2b"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_private_subnet_2a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_private_subnet_2b"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_public_route_table"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_private_route_table"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_db_subnet_2a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_db_subnet_2b"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_rds_pvt_route_table"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
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

variable "availability_zone_bastionhost" {
  description = "The Avaiability zone in which the bastion host will be created"
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

variable "bastionhosst_ssh_access_cidr_act" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

variable "bastionhosst_ssh_access_cidr_airtel" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

variable "bastionhosst_ssh_access_cidr_ubona_gate" {
  description = "CIDR blocks allowed for SSH access"
  type        = string
}

#webserver variables 

variable "instance_type_webserver" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "webserver_ami" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

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

variable "tags_webserver02" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#common security group variables 
variable "common_sg_name" {
  description = "The name of the common security group"
  type        = string
}

variable "common_sg_description" {
  description = "The description of the common security group"
  type        = string
}

variable "tags_common_sg" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}


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

variable "tags_webserver02_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
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

variable "appserver_ami" {
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

#proxyserver variables 

variable "instance_type_proxy" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "proxy_ami" {
  description = "The image ami id for instance"
  type        = string
  default     = ""
}

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

variable "tags_proxy02" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_proxy01_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_proxy02_ebs_root_vol"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

#EIP for proxy variables

variable "tags_proxy01_eip" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_proxy02_eip" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

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

# ALB variables 

variable "tags_alb" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}  
}

# NLB varaibles 

variable "tags_nlb_internal" {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}  
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID for the DNS record"
  type        = string
}

variable "cname_record_name" {
  description = "Record name to route traffic for proxy from nlb"
  type        = string
}


