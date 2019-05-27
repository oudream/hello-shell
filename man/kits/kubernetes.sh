#!/usr/bin/env bash


### kubernetes
minikube start --docker-env http_proxy=$http_proxy --docker-env https_proxy=$https_proxy --docker-env no_proxy=$no_proxy --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy --docker-env NO_PROXY=$no_proxy
minikube start --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy --docker-env NO_PROXY=$no_proxy
minikube ssh

export no_proxy=$no_proxy,$(minikube ip)
export NO_PROXY=$no_proxy

kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl get pod
curl $(minikube service hello-minikube --url)
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube
minikube stop

