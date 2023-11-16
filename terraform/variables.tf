variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name for Tagging"
  type        = string
  default     = "secure-sdlc-project"
}

variable "environment_name" {
  description = "Environment Name for Tagging"
  type        = string
  default     = "QA"
}

#App Count for ECS Cluster (Module Default of 3)
variable "ecs_app_count" {
  type = number
  default = 4
}

#Name for S3 Static Website
variable "s3_bucket_name" {
  description = "S3 Bucket Name for Static Website"
  type        = string
  default     = "jhurtt-s3-static-website"
}

#Name for S3 Static Website
variable "eks_cluster_name_prefix" {
  description = "EKS Cluster Name Prefix"
  type        = string
  default     = "jhurtt-aws-eks-deploy-"
}
