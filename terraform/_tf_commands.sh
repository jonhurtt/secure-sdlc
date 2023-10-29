#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment

#Notes for terraform
terraform init
terraform plan -out="tfplan"