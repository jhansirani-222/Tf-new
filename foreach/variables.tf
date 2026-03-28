variable "instance_name" {
    type = map
    default = {
    mongodb = "t3.small"
    redis = "t2.micro"
    mysql = "t3.small"
    rabbitmq = "t2.micro"
    catalogue = "t2.micro"
    cart = "t2.micro"
    user = "t2.micro"
    shipping = "t3.small"
    payment = "t2.micro"
    dispatch = "t2.micro"
    web = "t2.micro"
    }
}
variable "zone_id" {
    type = string
    default = "Z055763434TXUZ9JMBMT3"
}
variable "domain_name" {
    type = string
    default = "jhansidevops.icu"
}