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