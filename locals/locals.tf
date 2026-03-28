locals {
 type = var.is_prod ? "t3.small" : "t2.micro"
}

#locals used to store expressions ,conditions etc