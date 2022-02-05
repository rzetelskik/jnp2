#!/bin/bash

kubectl apply -f namespace.yaml

kubectl apply -f mysql/configmap.yaml
kubectl apply -f mysql/pvc.yaml
kubectl apply -f mysql/secret.yaml
kubectl apply -f mysql/service.yaml
kubectl apply -f mysql/deployment.yaml

kubectl apply -f configmap.yaml
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml