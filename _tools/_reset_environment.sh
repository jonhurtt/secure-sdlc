#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="

echo $spacer
echo "Start of Resetting Enviornment"
echo $spacer
#1. Step 1 remove Yor Tags from by repalcing with files without tags
echo $spacer
echo "Removing Yor Tags from Terraform Files"
echo $spacer
cd ..
current_path=$(pwd)

terraform_dir=$current_path"/terraform"
untagged_dir=$terraform_dir"/_untagged"
module_dir=$terraform_dir"/modules"

echo "Current Path: " $current_path
echo $spacer

echo "Terraform Directory: " $terraform_dir
ls -al $terraform_dir/ | grep .tf
echo $spacer

echo "Untagged Terraform Dir"
ls -al $untagged_dir/ | grep .tf
echo $spacer

for directory in `find $module_dir -type d -maxdepth 1 -mindepth 1 -not -name .svn`
do
    module="$(basename $directory)"
    echo "Searching Module "${module}
    echo "Saving from ${module}.untagged-tf to ${module}/main.tf"
    cp $untagged_dir/$module.untagged-tf $module_dir/$module/main.tf 
    echo $spacer
done

echo $spacer
echo "Updating Untagged Terraform Files Complete - Commit Code Now"
echo $spacer