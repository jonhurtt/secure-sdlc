#==================================================
# Definding Module for website_s3_bucket
#==================================================
module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"
  bucket_name = var.s3_bucket_name  

  tags = {
    build_process = "terraform"
    environment =  var.environment_name
  }
}

#==================================================
# Definding Module for ec2_scanner
#==================================================
module "ec2_scanner" {
  source = "./modules/aws-ec2-scanner"
  
  tags = {
    name = "ec2_prisma_cloud_scanner"
    build_process = "terraform"
    environment =  var.environment_name
  }
}


#==================================================
# Definding Module for ec2_apache
#==================================================
module "ec2_apache" {
  source = "./modules/aws-apache-ec2"
  
  tags = {
    name = "ec2_apache_web"
    build_process = "terraform"
    environment =  var.environment_name
  }
}

#==================================================
# Definding Module for ecs_cluster
#==================================================
module "ecs_cluster" {
  source = "./modules/aws-ecs-cluster"
  
  tags = {
    build_process = "terraform"
    environment =  var.environment_name
  }
}

#==================================================
# Definding Module for eks_cluster
#==================================================
module "eks_cluster" {
  source = "./modules/aws-eks-cluster"
  cluster_name_prefix = var.eks_cluster_name_prefix
  tags = {
    build_process = "terraform"
    environment =  var.environment_name
  }
}