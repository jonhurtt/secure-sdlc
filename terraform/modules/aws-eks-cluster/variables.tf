variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "cluster_name_prefix" {
  description = "Name of EKS Prefix."
  type        = string
}