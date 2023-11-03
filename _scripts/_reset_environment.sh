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
full_path=$current_path
full_path+=$terraform_dir

echo "Current Location: " $full_path
ls -al $full_path | grep .tf
echo $spacer

echo "Basline Files"
ls -al $full_path/_baseline/ | grep .tf
echo $spacer

terraform_files=("build_apache_ec2" "build_aws_ecs" "build_aws_eks_cluster")

for file in ${terraform_files[@]}; do
  echo "Removing Tags from" $file
  cp $full_path/_baseline/$file.untagged-tf $full_path/$file.tf 
done


echo $spacer
echo "End of Resetting Enviornment - Commit Code now"
echo $spacer