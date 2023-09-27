terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  region = var.aws_region
}

module "ec2-instance" {
  source = "./modules/ec2-instance"
  vpc_id = module.vpc.vpc_id
  az     = module.vpc.az1
  subnet = module.vpc.subnet_pub1
}

module "efs_unencrypted" {
  source    = "./modules/efs/unencrypted"
  subnet_id = module.vpc.subnet_priv1
}
