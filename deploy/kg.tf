module "knowledge_graph_vpc" {
  source = "github.com/AllenInstitute/platform-terraform-modules/vpc"
  project_name       = var.project_name
  create_private_subnets = false
}

module "knowledge_graph_ecs" {
  source = "./ecs"
  project_name       = var.project_name
  domain_name        = var.domain_name
  aws_account_id     = var.aws_account_id
  region             = var.region
  vpc_id             = module.knowledge_graph_vpc.id
  vpc_public_subnets = module.knowledge_graph_vpc.public_subnets
  docker_image       = var.docker_image
  application_port   = 7474
}
