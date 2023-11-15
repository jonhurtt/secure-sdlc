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
full_path=$current_path
full_path+=$terraform_dir

echo "Current Location: " $full_path
ls -al $full_path | grep .tf
echo $spacer

echo "Untagged Terraform Files"
ls -al $full_path$untagged_dir/ | grep .tf
echo $spacer

terraform_files=("build_apache_ec2" "build_aws_ecs" "build_aws_eks_cluster" build_scanner_ec2)

for file in ${terraform_files[@]}; do
  echo "Removing Tags from" $file
  cp $full_path/$file.tf $full_path$untagged_dir/$file.untagged-tf 
done

echo $spacer

#2 Initiate a Commit via API? 


echo $spacer
echo "Updating Untagged Terraform Files Complete"
echo $spacer