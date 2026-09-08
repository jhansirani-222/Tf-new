terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
#my permanent backend
terraform {
  backend "s3" {
    bucket = "permdevops" #must be unique
    key    = "ec2"#this config stores as ec2 in permdevops bucket
    region = "us-east-1"
    dynamodb_endpoint = "perm"
  }
}