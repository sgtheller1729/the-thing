module "vpc" {
  source = "./modules/aws-vpc-setup"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  subnet_count         = var.subnet_count
  public_internet_cidr = var.public_internet_cidr
}

module "eks" {
  source = "./modules/aws-eks-cluster-setup"

  vpc_cidr = var.vpc_cidr

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

# module "rds" {
#   source = "./modules/aws-rds-setup"

#   vpc_cidr = var.vpc_cidr

#   vpc_id             = module.vpc.vpc_id
#   public_subnet_ids  = module.vpc.public_subnet_ids
#   private_subnet_ids = module.vpc.private_subnet_ids
# }

# module "iot" {
#   source     = "./modules/aws-iot-core-setup"
#   account_id = var.account_id
#   vehicle_id = var.vehicle_id
#   model      = var.model
# }
