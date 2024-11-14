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

  depends_on = [module.vpc]
}

module "docker" {
  source = "./modules/docker"

  aws_account_id = var.account_id
  aws_region     = var.region

  depends_on = [module.eks]
}

module "k8s" {
  source = "./modules/k8s"

  nlb_name              = module.eks.nlb_name
  alb_name              = module.eks.alb_name
  mqtt_target_group_arn = module.eks.mqtt_target_group_arn
  html_target_group_arn = module.eks.html_target_group_arn

  depends_on = [module.docker]
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
