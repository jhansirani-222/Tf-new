variable "instance_name" {
    type = list
    default = ["mongodb","redis","mysql","rabbitmq","catalogue","user","cart","shipping","payment","dispatch","web"]
}
variable "zone_id" {
    type = string
    default = "Z055763434TXUZ9JMBMT3"
}
variable "domain_name" {
    type = string
    default = "jhansidevops.icu"
}