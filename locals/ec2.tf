resource "aws_instance" "ec2" {
  ami           = "ami-0b4f379183e5706b9"
  instance_type = local.type
 #vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "HelloWorld"
  }
}