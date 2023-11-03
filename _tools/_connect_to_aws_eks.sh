#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="
echo $spacer

echo "Updating AWS CLI to connect to newly created EKS Cluster"
echo $spacer
aws sts get-caller-identity
echo $spacer
cd ../terraform/
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
echo $spacer
kubectl cluster-info
echo $spacer
kubectl get pods --all-namespaces -o wide
echo $spacer