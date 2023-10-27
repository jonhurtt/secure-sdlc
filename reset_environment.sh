#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment

#1. Step 1 remove Yor Tags from 
cp _basline/build_apache_ec2.untagged-tf build_apache_ec2.tf
cp _basline/build_aws_ecs.untagged-tf build_aws_ecs.tf 