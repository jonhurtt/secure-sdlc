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
    echo "Saving from ${module}/main.tf to ${module}.untagged-tf"
    cp $module_dir/$module/main.tf $untagged_dir/$module.untagged-tf
    echo $spacer
done

echo $spacer
echo "Updating Untagged Terraform Files Complete - Commit Code Now"
echo $spacer