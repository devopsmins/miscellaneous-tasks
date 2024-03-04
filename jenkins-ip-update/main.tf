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


