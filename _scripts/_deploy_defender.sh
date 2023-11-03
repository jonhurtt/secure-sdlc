#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="
echo $spacer

echo "Creating Namesapce an"
echo $spacer
kubectl create -f ../k8/create-namespace.yaml
echo $spacer
kubectl get namespaces
echo $spacer
kubectl create -f ../k8/daemonset.yaml
echo $spacer
kubectl get pods --namespace twistlock
echo $spacer