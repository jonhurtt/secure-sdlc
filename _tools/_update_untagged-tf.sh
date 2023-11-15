#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
# Bash Script to update untagged-tf files for demo purposes
# use when ever terraform files are updated and before enabling Yor Tagging


spacer="=============================================================================================================="

echo $spacer
echo "Updating Untagged Terraform Files"
echo $spacer
cd ..
current_path=$(pwd)

terraform_dir="/terraform"
untagged_dir="/_untagged"
module_dir="/modules"

full_path=$current_path
full_path+=$terraform_dir

echo "Current Location: " $full_path
ls -al $full_path | grep .tf
echo $spacer

echo "Untagged Terraform Files"
ls -al $full_path$untagged_dir/ | grep .tf
echo $spacer

terraform_modules=("aws-apache-ec2" "aws-ec2-scanner" "aws-ecs-cluster" "aws-eks-cluster" "aws-s3-static-website-bucket")

for module in ${terraform_modules[@]}; do
  echo "Saving from $module/main.tf to $module.untagged-tf"
  cp $full_path$module_dir/$module/main.tf $full_path$untagged_dir/$module.untagged-tf 
done

echo $spacer

echo $spacer
echo "Updating Untagged Terraform Files Complete - Commit Code Now"
echo $spacer