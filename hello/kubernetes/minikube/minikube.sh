#!/usr/bin/env bash

# How do I ssh into the VM for Minikube?
minikube ssh
ssh -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip)
