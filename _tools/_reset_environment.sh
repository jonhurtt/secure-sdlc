#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="
echo $spacer
echo "Start of Resetting Enviornment"
echo $spacer
#1. Step 1 remove Yor Tags from by repalcing with files without tags
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
  echo "Moving $module.untagged-tf to  $module/main.tf"
  cp $full_path$untagged_dir/$module.untagged-tf $full_path$module_dir/$module/main.tf  
done


echo $spacer
echo "End of Resetting Enviornment - Commit Code now"
echo $spacer