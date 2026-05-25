module "network" {
  source = "../../modules/network"

  aws_region = "ap-south-1"
  vpc_cidr   = "10.0.0.0/16"

  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"

  private_subnet_1_cidr = "10.0.3.0/24"
  private_subnet_2_cidr = "10.0.4.0/24"
}

module "compute" {
  source = "../../modules/compute"

  ami_id        = "ami-07a00cf47dbbc844c"
  instance_type = "t3.micro"

  subnet_id = module.network.public_subnet_1_id
  vpc_id    = module.network.vpc_id

  key_name = "enterprise-key"
}

module "storage" {
  source = "../../modules/storage"

  bucket_name = "atharva-enterprise-storage-bucket"
}

module "database" {
  source = "../../modules/database"

  db_name     = "enterprise_db"
  db_username = "postgres"
  db_password = "StrongPassword123!"

  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id

  vpc_id = module.network.vpc_id
}