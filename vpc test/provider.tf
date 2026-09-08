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

terraform {
  backend "s3" {
    bucket = "devops-practice999"
    key    = "vpc-test"
    region = "us-east-1"
    dynamodb_endpoint = "remote"
  }

}