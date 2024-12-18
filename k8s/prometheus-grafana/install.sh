#!/bin/bash

git clone https://github.com/prometheus-operator/kube-prometheus.git

mv grafana-ingress.yaml kube-prometheus/manifests/grafana-ingress.yaml
mv prometheus-ingress.yaml kube-prometheus/prometheus-ingress.yaml
mv alertmanager-ingress.yaml kube-prometheus/manifests/alertmanager-ingress.yaml

kubectl create -f kube-prometheus/manifests/setup
kubectl create -f kube-prometheus/manifests
