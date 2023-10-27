#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment
spacer="=============================================================================================================="
echo $spacer
echo "Start of Resetting Enviornment"
echo $spacer
#1. Step 1 remove Yor Tags from by repalcing with files without tags
currentlocation=$(pwd)
echo "Current Location"
ls -al $currentlocation | grep .tf
echo $spacer

echo "Basline Files"
ls -al $currentlocation/_baseline/ | grep .tf
echo $spacer

echo "Replacing build_apache_ec2"
cp $currentlocation/_basline/build_apache_ec2.untagged-tf $currentlocation/build_apache_ec2.tf
echo $spacer

echo "Replacing build_aws_ecs"
cp $currentlocation/_basline/build_aws_ecs.untagged-tf $currentlocation/build_aws_ecs.tf 
echo $spacer

#2 Initiate a Commit via API? 


echo $spacer
echo "End of Resetting Enviornment"
echo $spacer