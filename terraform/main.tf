#https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
#https://github.com/hashicorp/learn-terraform-provision-eks-cluster/blob/main/main.tf 

data "aws_availability_zones" "available_zones" {
  state = "available"
}