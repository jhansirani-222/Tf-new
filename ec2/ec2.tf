resource "aws_instance" "ec2" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  

  tags = {
    Name = "example"
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