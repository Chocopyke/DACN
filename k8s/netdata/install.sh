#!/bin/bash

kubectl create namespace netdata
kubectl create secret generic nginx-basic-auth --from-file=auth -n netdata
helm repo add netdata https://netdata.github.io/helmchart/
helm repo update

helm install netdata netdata/netdata -n netdata

kubectl delete ingress -n netdata
kubectl create -f .
