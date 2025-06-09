terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "<your-unique-bucket-name>" # Replace with your S3 bucket name
    key            = "ecs-fargate-deployment/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    use_lockfile   = true
  }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "backup"
  region = "us-west-1"
}