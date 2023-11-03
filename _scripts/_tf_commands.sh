#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
# Bash Script with commmands for Terraform via CLI

#Notes for terraform
terraform init
terraform plan -out="tfplan"
#terraform apply "tfplan"
#terraform destory