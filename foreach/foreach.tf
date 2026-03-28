resource "aws_instance" "ec2" {
  for_each = var.instance_name
  ami           = "ami-0b4f379183e5706b9"
  instance_type = each.value
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = each.key
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
  for_each = aws_instance.ec2
  zone_id = var.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [each.key == "web" ? each.value.public_ip : each.value.private_ip] #o/p aws_instance.ec2 is resource we created and count.index is to state each instance 
}