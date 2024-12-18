#!/bin/bash

kubectl create -f k8s/application/namespace.yaml
kubectl create -f k8s/job-seeker-application/database 
kubectl create -f k8s/job-seeker-application/backend
kubectl create -f k8s/job-seeker-application/frontend

echo "Checking namespace main-application..."
kubectl get all -n main-application
