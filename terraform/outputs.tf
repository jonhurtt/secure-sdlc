#==================================================
# Output variable definitions
#==================================================
output "region" {
  description = "AWS Region"
  value       = var.region
}


#==================================================
# Output variable definitions for website_s3_bucket
#==================================================
output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.website_s3_bucket.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website_s3_bucket.name
}

output "website_bucket_domain" {
  description = "Domain name of the bucket"
  value       = module.website_s3_bucket.domain
}

#==================================================
# Output variable definitions for ec2_scanner
#==================================================
output "ec2_scanner_public_dns" {
  description = "IP Address of EC2 Scanner Instance"
  value       = module.ec2_scanner.public_dns
}

#==================================================
# Output variable definitions for ec2_scanner
#==================================================
output "ec2_apache_public_dns" {
  description = "IP Address of EC2 Apache Instance"
  value       = module.ec2_apache.public_dns
}

#==================================================
# Output variable definitions for ecs_cluster
#==================================================
output "ecs_load_balancer_ip" {
  description = "IP Address of EC2 Apache Instance"
  value       = module.ecs_cluster.load_balancer_ip
}

#==================================================
# Output variable definitions for eks_cluster
#==================================================
output "eks_cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks_cluster.cluster_security_group_id
}

output "eks_vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.eks_cluster.vpc_public_subnets
}

#output "eks_ec2_instance_public_ips" {
#  description = "Public IP addresses of EC2 instances"
#  value       = module.eks_cluster.ec2_instance_public_ips
#}

