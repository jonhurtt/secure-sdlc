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

variable "app_count" {
  type = number
  default = 3
}