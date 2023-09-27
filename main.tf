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

module "efs_unencrypted" {
  source    = "./modules/efs/unencrypted"
  subnet_id = module.vpc.subnet_priv1
  vpc_id    = module.vpc.vpc_id
}

module "kms" {
  source = "./modules/kms"
}

module "efs_encrypted_kms" {
  source     = "./modules/efs/encrypted"
  subnet_id  = module.vpc.subnet_priv1
  vpc_id     = module.vpc.vpc_id
  kms_key_id = module.kms.key_arn
}

module "ssm" {
  source                   = "./modules/ssm"
  efs_unencrypted_dns_name = module.efs_unencrypted.dns_name
  efs_encrypted_dns_name   = module.efs_encrypted_kms.dns_name
}


module "ec2-instance" {
  source = "./modules/ec2-instance"
  vpc_id = module.vpc.vpc_id
  az     = module.vpc.az1
  subnet = module.vpc.subnet_pub1

  depends_on = [module.ssm]
}

module "datasync" {
  source = "./modules/datasync"

  subnet_arn = module.vpc.subnet_priv1_arn

  efs_unencrypted_arn    = module.efs_unencrypted.efs_arn
  efs_unencrypted_sg_arn = module.efs_unencrypted.sg_arn

  efs_encrypted_arn    = module.efs_encrypted_kms.efs_arn
  efs_encrypted_sg_arn = module.efs_encrypted_kms.sg_arn
}
