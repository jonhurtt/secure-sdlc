#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment

#1. Step 1 remove Yor Tags from by repalcing with files without tags
currentlocation=$(pwd)
ls -al $currentlocation | grep .tf
ls -al $currentlocation/_baseline/ | grep .tf
cp $currentlocation/_basline/build_apache_ec2.untagged-tf $currentlocation/build_apache_ec2.tf
cp $currentlocation/_basline/build_aws_ecs.untagged-tf $currentlocation/build_aws_ecs.tf 

#2 Initiate a Commit via API? 
