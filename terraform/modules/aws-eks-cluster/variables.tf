variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "eks_cluster_name_prefix" {
  description = "Name of EKS Prefix."
  type        = string
}