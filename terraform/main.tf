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
