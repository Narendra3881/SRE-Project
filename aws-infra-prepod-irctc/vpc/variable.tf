
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

variable public_subnet_1a_cidr {
  description = "The CIDR block for the public subnet in availability zone 2a"
  type        = string
  default     = ""
}

variable public_subnet_1b_cidr {
  description = "The CIDR block for the public subnet in availability zone 2b"
  type        = string
  default     = ""
}

variable private_subnet_1a_cidr {
  description = "The CIDR block for the private subnet in availability zone 2a"
  type        = string
  default     = ""
}

variable private_subnet_1b_cidr {
  description = "The CIDR block for the private subnet in availability zone 2b"
  type        = string
  default     = ""
}

variable db_subnet_1a_cidr {
  description = "The CIDR block for the Database subnet in availability zone 2a"
  type        = string
  default     = ""
}
variable db_subnet_1b_cidr {
  description = "The CIDR block for the Database subnet in availability zone 2a"
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
variable "tags_public_subnet_1a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_public_subnet_1b"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_private_subnet_1a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}

variable "tags_private_subnet_1b"  {
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
variable "tags_db_subnet_1a"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_db_subnet_1b"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}
variable "tags_rds_pvt_route_table"  {
  description = "A map of tags to add to the resources"
  type        = map(string)
  default     = {}
}