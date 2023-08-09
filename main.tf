terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-state-bucket-pune"
    key    = "myapp/state.tfstate"
    region = "ap-south-1"
  }

}

provider "aws" {
  region = "ap-south-1"
}


module "vpc" {
  source                    = "./module/vpc"
  vpc_cidr_block            = var.vpc_cidr_block
  avail_zone_private        = var.avail_zone_private
  avail_zone_public         = var.avail_zone_public
  subnet_cidr_block_private = var.subnet_cidr_block_private
  subnet_cidr_block_public  = var.subnet_cidr_block_public
  my-ip                     = var.my-ip
}

module "instance" {
  source            = "./module/instance"
  vpc_id            = module.vpc.my-vpc.id
  my-ip             = var.my-ip
  instance_type     = var.instance-type
  image_name        = var.image_name
  public_subnet_id  = module.vpc.subnet_public.id
  private_subnet_id = module.vpc.subnet_private.id

}




