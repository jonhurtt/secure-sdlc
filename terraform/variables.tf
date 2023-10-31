#Source: https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/

variable "app_count" {
  type = number
  default = 3
}