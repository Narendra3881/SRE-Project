variable alb_name {
  description = "Name of the alb"
  type        = string
  default     = ""
}

variable alb_sg_id {
  description = "The ID of the Alb security group "
  type        = string
  default     = ""
}
variable public_subnet_2a_id {
  description = "The ID of the public subnet to associate to the Alb "
  type        = string
  default     = ""
}
variable public_subnet_2b_id {
  description = "The ID of the public subnet to associate to the Alb "
  type        = string
  default     = ""
}

variable vpc_id {
  description = "The ID Of the vpc you want resource to be associated"
  type        = string
  default     = ""
}

variable https_certificate_arn {
  description = "The ARN of the SSL certificate used for HTTPS"
  type        = string
  default     = ""
}

variable tags {}