variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map
  default = {} # it is optional
}
variable "vpc_tags" {
  type = map
  default = {}
  
}

variable "project_name" {
  type = string # since default not provided user need to provide this as vars compulsory
}

variable "environment" {
  type = string #mandatory
}

variable "igw_tags" {
  type = map
  default = {}
}
variable "publicsubnet_tags" {
  default = {}
}
variable "public_subnet_cidr" {
  type = list
  validation {
    condition = length(var.public_subnet_cidr) == 2
    error_message = "Please give 2 public valid subnet CIDR"
  }
}
variable "privatesubnet_tags" {
  default = {}
}
variable "private_subnet_cidr" {
  type = list
  validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "Please give 2 private valid subnet CIDR"
  }
}
variable "databasesubnet_tags" {
  default = {}
}
variable "database_subnet_cidr" {
  type = list
  validation {
    condition = length(var.database_subnet_cidr) == 2
    error_message = "Please give 2 database valid subnet CIDR"
  }
}

variable "natgateway_tags" {
  default = {}
}
variable "route_tags" {
  default = {}
  
}
