#!/bin/bash

kubectl apply -f configmap.yaml
kubectl apply -f pvc.yaml
kubectl apply -f service.yaml
kubectl apply -f statefulset.yaml
