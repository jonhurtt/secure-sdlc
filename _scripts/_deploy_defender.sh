#!/bin/bash
# Written By Jonathan R. Hurtt
# Part of https://github.com/jonhurtt/secure-sdlc
#Bash script to reset the enviornment


spacer="=============================================================================================================="

echo $spacer
echo "kubectl create -f ../k8-yaml/create-namespace.yaml"
kubectl create -f ../k8-yaml/create-namespace.yaml
echo $spacer
echo "kubectl get namespaces"
kubectl get namespaces
echo $spacer
echo "create -f ../k8-yaml/daemonset.yaml"
kubectl create -f ../k8-yaml/daemonset.yaml
echo $spacer
echo "kubectl get pods --namespace twistloc" 
kubectl get pods --namespace twistlock
echo $spacer