# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  cloud {
    organization = "terraform-cloud-jhurtt"
    
    workspaces {
      name = "secure-sdlc-workspace"
    }
  }
}