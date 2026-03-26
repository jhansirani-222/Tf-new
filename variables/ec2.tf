resource "aws_instance" "ec2" {
  ami           = var.ami-id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = var.tags
}

resource "aws_security_group" "allow_all" { #tf name
  name        = "allow_all" #aws name
  description = "Allow all trafiic"
  #vpc_id      = aws_vpc.main.id

   ingress {
    from_port        = var.inbountport
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks

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