terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}
#proveedor de servicios 
provider "aws" {
  region     = var.aws-region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Modules
module "networking" {
  source = "./modules/networking"

  vpc_az              = var.vpc_az
  vpc_name            = var.vpc_name
  vpc_db_subnet       = var.vpc_db_subnet
  vpc_cidr            = var.vpc_cidr
  vpc_private_subnet  = var.vpc_private_subnet
  vpc_public_subnet   = var.vpc_public_subnet
}

module "ec2" {
  source = "./modules/ec2"

  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  vpc_id                    = module.networking.vpc_id
  subnet_private_a          = module.networking.subnet_private_a
  subnet_public_a           = module.networking.subnet_public_a
  subnet_private_b          = module.networking.subnet_private_b
  subnet_public_b           = module.networking.subnet_public_b
  subnet_private_management = module.networking.subnet_private_management
  key_pair                  = var.key_pair
}

module "db" {
  source = "./modules/db"
  vpc_id            = module.networking.vpc_id
  subnet_private_db = module.networking.subnet_private_db
  subnet_private_db_ha = module.networking.subnet_private_db_ha
}


