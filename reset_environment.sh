#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="
echo $spacer
echo "Start of Resetting Enviornment"
echo $spacer
#1. Step 1 remove Yor Tags from by repalcing with files without tags
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

echo "Removing Tags from build_apache_ec2"
cp $full_path/_baseline/build_apache_ec2.untagged-tf $full_path/build_apache_ec2.tf
echo "Removing Tags from build_aws_ecs"
cp $full_path/_baseline/build_aws_ecs.untagged-tf $full_path/build_aws_ecs.tf 
echo "Removing Tags from build_aws_eks_cluster"
cp $full_path/_baseline/build_aws_eks_cluster.untagged-tf $full_path/build_aws_eks_cluster.tf
echo $spacer

#2 Initiate a Commit via API? 


echo $spacer
echo "End of Resetting Enviornment"
echo $spacer