#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
output "load_balancer_ip" {
  description = "DNS Name for Load Balancer"
  value = aws_lb.default_lb.dns_name
}

#from build_apache_ec2
output "web-address" {
  description = "IP Address of Apache EC2 Instance"
  value = "${aws_instance.apache_ec2_instance.public_dns}:8080"
}

# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS Region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}