resource "aws_instance" "ec2" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "ansible"
  }
}
resource "aws_security_group" "roboshop" { #tf name
  name        = "allow_all" #aws name
  description = "Allow all trafiic"
  #vpc_id      = aws_vpc.main.id

   dynamic "ingress" {
    for_each = var.ingress
    content {
     from_port        = ingress.value["from_port"]
     to_port          = ingress.value["to_port"]
     protocol         = ingress.value["protocol"]
     cidr_blocks      = ingress.value["cidr_blocks"]
   }
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
