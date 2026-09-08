variable "ami-id" {
    type = string
    default = "ami-0b4f379183e5706b9"
}

variable "tags" {
    type = map
    default = {
        Name = "HelloWorld"
        ENVIRONMENT = "DEV"
        terraform = "true"
    }
}

variable "inbountport" {
    type = number
    default = 0
}


variable "cidr_blocks" {
    type = list
    default = ["0.0.0.0/0"]
}

#types of variables in tf and how to call them