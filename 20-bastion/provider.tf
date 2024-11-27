terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "srikanth-tf-expense-dev"
    key    = "expense-bastion-ci"
    region = "us-east-1"
    dynamodb_table = "srikanth-tf-expense-dev-lock"
  }
}
provider "aws" {
  region = "us-east-1"
}