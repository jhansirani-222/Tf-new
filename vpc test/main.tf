module "vpc" {
    source = "../vpc_module"
    common_tags = var.common_tags
    vpc_tags = var.vpc_tags
    project_name = var.project_name
    environment = var.environment

}