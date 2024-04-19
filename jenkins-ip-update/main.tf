terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0, !=5.39"
    }
  }
  backend "s3" {
    bucket = "mins-terraform-state"
    key    = "misc/jenkins-ip-update/terraform.tfstate"
    region = "us-east-1"

  }
}

data "aws_instance" "jenkins" {
  instance_id = "i-0e3626aeec70816c8"
}

resource "aws_route53_record" "jenkins" {
  name    = "jenkins"
  type    = "A"
  zone_id = "Z05815251WQO0OK50UPQR"
  ttl     = 10
  records = [data.aws_instance.jenkins.public_ip]


}

data "aws_instance" "artifactory" {
  instance_id = "i-06d37159bf5b3ecd3"
}

resource "aws_route53_record" "artifactory" {
  name    = "artifactory"
  type    = "A"
  zone_id = "Z05815251WQO0OK50UPQR"
  ttl     = 10
  records = [data.aws_instance.artifactory.public_ip]

}

data "aws_instance" "elk" {
  instance_id = "i-0c5e20f1c334b6458"
}

resource "aws_route53_record" "elk" {
  name    = "elasticsearch"
  type    = "A"
  zone_id = "Z0021413JFIQEJP9ZO9Z"
  ttl     = 10
  records = [data.aws_instance.elk.public_ip]
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

resource "aws_instance" "load-gen" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = ["sg-033d8567b50d2e180"]
  tags = {
    Name = "load-gen"
  }
}

data "aws_instance" "gocd" {
  instance_id = "i-038e89f526420eba9"
}

resource "aws_route53_record" "gocd" {
  name    = "gocd"
  type    = "A"
  zone_id = "Z0021413JFIQEJP9ZO9Z"
  ttl     = 10
  records = [data.aws_instance.gocd.public_ip]
}