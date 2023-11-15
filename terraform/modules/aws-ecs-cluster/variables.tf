variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "ecs_app_count" {
  type = number
  default = 3
}
