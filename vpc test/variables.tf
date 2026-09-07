variable "cidr" {
  default = "10.0.0.0/16"
}

variable "common_tags" {
    default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}

variable "vpc_tags" {
  type = map
  default = {}
}

variable "project_name" {
  type = string # since default not provided user need to provide this as vars compulsory
  default = "roboshop"
  }

variable "environment" {
  type = string #mandatory
  default = "dev"
}