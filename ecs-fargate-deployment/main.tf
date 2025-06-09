# Root module for ECS Fargate deployment of single-container React/Node.js apps

provider "aws" {
  region = var.region
}

# Local modules
module "vpc" {
  source = "./modules/vpc"

  app_name = var.app_name
  region   = var.region
}

module "security_groups" {
  source = "./modules/security_groups"

  app_name = var.app_name
  vpc_id   = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"

  app_name = var.app_name
}

module "ecs" {
  source = "./modules/ecs"

  app_name           = var.app_name
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  ecs_sg_id          = module.security_groups.ecs_sg_id
  repository_urls    = module.ecr.repository_urls
  alb_listener_arn   = module.alb.listener_https_arn
  target_group_arns  = module.alb.target_group_arns

  depends_on = [module.alb]
}

module "alb" {
  source = "./modules/alb"

  app_name        = var.app_name
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  alb_sg_id       = module.security_groups.alb_sg_id
  certificate_arn = module.route53.certificate_arn
  domain_name     = var.domain_name
}

module "route53" {
  source = "./modules/route53"

  app_name         = var.app_name
  domain_name      = var.domain_name
  hosted_zone_id   = var.hosted_zone_id
  alb_dns_name     = module.alb.alb_dns_name
  alb_zone_id      = module.alb.alb_zone_id
  cloudfront_domains = module.cloudfront.cloudfront_domains
}

module "cloudfront" {
  source = "./modules/cloudfront"

  app_name        = var.app_name
  domain_name     = var.domain_name
  alb_dns_name    = module.alb.alb_dns_name
  certificate_arn = module.route53.certificate_arn
}