terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  count                  = 4
  ami                    = "ami-0ecb62995f68bb549"   # ensure this AMI exists in us-east-1
  instance_type          = "t3.medium"
  key_name               = "taeeb"                  # must exist in the selected region/account
  vpc_security_group_ids = ["sg-0f6f1b21e855fa2a1"] # must exist in the selected VPC/region
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  type    = list(string)
  default = ["jenkins", "tomcat-1", "tomcat-2", "Monitoring server"]
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "my-demo-project-artifact-01"  # must be globally unique across all AWS accounts
}
