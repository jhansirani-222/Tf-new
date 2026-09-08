resource "aws_instance" "ec2" {
  count = length(var.instance_name)
  ami           = "ami-0b4f379183e5706b9"
  instance_type = var.instance_name[count.index] == "mongodb" || var.instance_name[count.index] == "shipping" || var.instance_name[count.index] == "mysql" ? "t3.small" : "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = var.instance_name[count.index]
  }
}

resource "aws_security_group" "allow_all" { #tf name
  name        = "allow_all" #aws name
  description = "Allow all trafiic"
  #vpc_id      = aws_vpc.main.id

   ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

tags = {
    Name = "allow_all"
  }
}

resource "aws_route53_record" "www" {
  count = length(var.instance_name)
  zone_id = var.zone_id
  name    = "${var.instance_name[count.index]}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [var.instance_name[count.index] == "web" ? aws_instance.ec2[count.index].public_ip : aws_instance.ec2[count.index].private_ip]
}