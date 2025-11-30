module "networking" {
  source                = "./modules/networking"
  vpc_availability_zone = "eu-west-1a"
}


module "resources" {
  source = "./modules/resources"

  public_subnet_id    = module.networking.public_subnet_id
  ssh_public_key_name = module.networking.ssh_public_key_name
  app_sg_id           = module.networking.app_sg_id
}

module "ansible_files" {
  source = "./modules/ansible"

  concrete_csm_public_ip = module.resources.concrete_csm_public_ip
}

