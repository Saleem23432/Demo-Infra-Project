provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "one" {
  count                  = 4
  ami                    = "ami-0ecb62995f68bb549"
  instance_type          = "t3.medium"
  key_name               = "Netflix"
  vpc_security_group_ids = ["sg-0ead21b7862e54f9a"]
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  default = ["jenkins", "tomcat-1", "tomcat-2", "Monitoring server"]
}

resource "s3_bucket" "bucket" {
  bucket = "my-demo-project-artifact-01"
}
