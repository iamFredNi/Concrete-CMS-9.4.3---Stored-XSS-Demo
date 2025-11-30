terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "project-advanced-security-terraform"
    key    = "tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {

}