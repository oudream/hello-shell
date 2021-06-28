#!/usr/bin/env bash

# https://kubernetes.io/zh/docs/reference/kubectl/overview/
kubectl [command] [TYPE] [NAME] [flags]

kubectl get pods --all-namespaces
kubectl get pod -n kube-system

kubectl port-forward --address 0.0.0.0 pod/mypod 8888:5000
kubectl port-forward --address 0.0.0.0 svc/grafana --namespace monitoring 2230:3000

### export var
export CLUSTER_IP=$(kubectl get services/webapp1-clusterip-svc -o go-template='{{(index .spec.clusterIP)}}')
echo CLUSTER_IP=$CLUSTER_IP
curl $CLUSTER_IP:80

kubectl [command] [TYPE] [NAME] -o=[output_format]
#    根据kubectl操作，支持以下输出格式：
#    输出格式	描述
#    -o=custom-columns=<spec>	使用逗号分隔的custom columns列表打印一个表。
#    -o=custom-columns-file=<filename>	使用文件中的custom columns模板打印表<filename>。
#    -o=json	输出JSON格式的API对象。
#    -o=jsonpath=<template>	打印在jsonpath表达式中定义的字段。
#    -o=jsonpath-file=<filename>	打印由 file中的jsonpath表达式定义的字段<filename>。
#    -o=name	仅打印资源名称，而不打印其他内容。
#    -o=wide	以纯文本格式输出任何附加信息。对于pod，包括node名称。
#    -o=yaml	输出YAML格式的API对象。
# 在此示例中，以下命令将单个pod的详细信息作为YAML格式化对象输出：
kubectl get pod web-pod-13je7 -o=yaml
kubectl get pods <pod-name> -o=custom-columns=NAME:.metadata.name,RSRC:.metadata.resourceVersion
kubectl get pods <pod-name> -o=custom-columns-file=template.txt
# 要打印按名称排序的pod列表，请运行：
kubectl get pods --sort-by=.metadata.name

## kubectl create - 从file或stdin中创建资源。
# Create a service using the definition in example-service.yaml.
kubectl create -f example-service.yaml
# Create a replication controller using the definition in example-controller.yaml.
kubectl create -f example-controller.yaml
# Create the objects that are defined in any .yaml, .yml, or .json file within the <directory> directory.
kubectl create -f [directory]

## kubectl get 列出一个或多个资源。
# List all pods in plain-text output format.
kubectl get pods
# List all pods in plain-text output format and includes additional information (such as node name).
kubectl get pods -o wide
# List the replication controller with the specified name in plain-text output format. Tip: You can shorten and replace the 'replicationcontroller' resource type with the alias 'rc'.
kubectl get replicationcontroller <rc-name>
# List all replication controllers and services together in plain-text output format.
kubectl get rc,services


## kubectl describe - 显示一个或多个资源的详细状态。
# Display the details of the node with name [node-name].
kubectl describe nodes [node-name]
# Display the details of the pod with name [pod-name].
kubectl describe pods/[pod-name]
# Display the details of all the pods that are managed by the replication controller named [rc-name].
# Remember: Any pods that are created by the replication controller get prefixed with the name of the replication controller.
kubectl describe pods [rc-name]


## kubectl describe - 显示一个或多个资源的详细状态。
# Display the details of the node with name [node-name].
kubectl describe nodes [node-name]
# Display the details of the pod with name [pod-name].
kubectl describe pods/[pod-name]
# Display the details of all the pods that are managed by the replication controller named [rc-name].
# Remember: Any pods that are created by the replication controller get prefixed with the name of the replication controller.
kubectl describe pods [rc-name]


## kubectl exec - 对pod中的容器执行命令。
# Get output from running 'date' from pod [pod-name]. By default, output is from the first container.
kubectl exec [pod-name] date
# Get output from running 'date' in container [container-name] of pod [pod-name].
kubectl exec [pod-name] -c [container-name] date
# Get an interactive TTY and run /bin/bash from pod [pod-name]. By default, output is from the first container.
kubectl exec -ti [pod-name] /bin/bash


## kubectl logs - 打印pod中的容器的日志。
# Return a snapshot of the logs from pod [pod-name].
kubectl logs [pod-name]
# Start streaming the logs from pod [pod-name]. This is similar to the 'tail -f' Linux command.
kubectl logs -f [pod-name]

kubectl cluster-info

kubectl get nodes


# kubectl api-resources --verbs=list --namespaced -o name \
#   | xargs -n 1 kubectl get --show-kind --ignore-not-found -l <label>=<value> -n <namespace>
kubectl api-resources -o name
kubectl api-resources -o name | xargs -I {} kubectl get {} --show-kind --ignore-not-found


### Kubectl Context and Configuration
# Set which Kubernetes cluster kubectl communicates with and modifies configuration information.
#    See Authenticating Across Clusters with kubeconfig documentation for detailed config file information.
kubectl config view # Show Merged kubeconfig settings.
# use multiple kubeconfig files at the same time and view merged config
KUBECONFIG=~/.kube/config:~/.kube/kubconfig2
kubectl config view
# get the password for the e2e user
kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'
kubectl config view -o jsonpath='{.users[].name}'    # get a list of users
kubectl config get-contexts                          # display list of contexts
kubectl config current-context			               # display the current-context
kubectl config use-context my-cluster-name           # set the default context to my-cluster-name
# add a new cluster to your kubeconf that supports basic auth
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword
# permanently save the namespace for all subsequent kubectl commands in that context.
kubectl config set-context --current --namespace=ggckad-s2
# set a context utilizing a specific username and namespace.
kubectl config set-context gce --user=cluster-admin --namespace=foo && kubectl config use-context gce
kubectl config unset users.foo                       # delete user foo



### Updating Resources
# As of version 1.11 rolling-update have been deprecated (see CHANGELOG-1.11.md), use rollout instead.
kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
# deprecated starting version 1.11
kubectl rolling-update frontend-v1 -f frontend-v2.json           # (deprecated) Rolling update pods of frontend-v1
kubectl rolling-update frontend-v1 frontend-v2 --image=image:v2  # (deprecated) Change the name of the resource and update the image
kubectl rolling-update frontend --image=image:v2                 # (deprecated) Update the pods image of frontend
kubectl rolling-update frontend-v1 frontend-v2 --rollback        # (deprecated) Abort existing rollout in progress
cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into std
# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.json
# Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
kubectl expose rc nginx --port=80 --target-port=8000
# Update a single-container pod's image version (tag) to v4
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -
kubectl label pods my-pod new-label=awesome                      # Add a Label
kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
kubectl autoscale deployment foo --min=2 --max=10                # Auto scale a deployment "foo"


### Patching Resources
kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}' # Partially update a node
# Update a container's image; spec.containers[*].name is required because it's a merge key
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'
# Update a container's image using a json patch with positional arrays
kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'
# Disable a deployment livenessProbe using a json patch with positional arrays
kubectl patch deployment valid-deployment  --type json   -p='[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'
# Add a new element to a positional array
kubectl patch sa default --type='json' -p='[{"op": "add", "path": "/secrets/1", "value": {"name": "whatever" } }]'



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


# SAQ: no matches for kind "DaemonSet" in version "extensions/v1beta1"
# K8S version 1.16 the following APIs are no longer served by default:
# daemonsets
extensions/v1beta1 -> apiVersion: apps/v1



kubectl [flags] [options]
#Use "kubectl <command> --help" for more information about a given command.
#Use "kubectl options" for a list of global command-line options (applies to all commands).

#kubectl controls the Kubernetes cluster manager.
open https://kubernetes.io/docs/reference/kubectl/overview/

#Basic Commands (Beginner):
  create         # Create a resource from a file or from stdin.
  expose         # Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run            # Run a particular image on the cluster
  set            # Set specific features on objects
                 #
#Basic Commands (Intermediate):
  explain        # Documentation of resources
  get            # Display one or many resources
  edit           # Edit a resource on the server
  delete         # Delete resources by filenames, stdin, resources and names, or by resources and label selector
                 #
#Deploy Commands:
  rollout        # Manage the rollout of a resource
  scale          # Set a new size for a Deployment, ReplicaSet or Replication Controller
  autoscale      # Auto-scale a Deployment, ReplicaSet, or ReplicationController
                 #
#Cluster Management Commands:
  certificate    # Modify certificate resources.
  cluster-info   # Display cluster info
  top            # Display Resource (CPU/Memory/Storage) usage.
  cordon         # Mark node as unschedulable
  uncordon       # Mark node as schedulable
  drain          # Drain node in preparation for maintenance
  taint          # Update the taints on one or more nodes
                 #
#Troubleshooting and Debugging Commands:
  describe       # Show details of a specific resource or group of resources
  logs           # Print the logs for a container in a pod
  attach         # Attach to a running container
  exec           # Execute a command in a container
  port-forward   # Forward one or more local ports to a pod
  proxy          # Run a proxy to the Kubernetes API server
  cp             # Copy files and directories to and from containers.
  auth           # Inspect authorization
                 #
#Advanced Commands:
  diff           # Diff live version against would-be applied version
  apply          # Apply a configuration to a resource by filename or stdin
  patch          # Update field(s) of a resource using strategic merge patch
  replace        # Replace a resource by filename or stdin
  wait           # Experimental: Wait for a specific condition on one or many resources.
  convert        # Convert config files between different API versions
  kustomize      # Build a kustomization target from a directory or a remote url.
                 #
#Settings Commands:
  label          # Update the labels on a resource
  annotate       # Update the annotations on a resource
  completion     # Output shell completion code for the specified shell (bash or zsh)
                 #
#Other Commands:  #
  api-resources  # Print the supported API resources on the server
  api-versions   # Print the supported API versions on the server, in the form of "group/version"
  config         # Modify kubeconfig files
  plugin         # Provides utilities for interacting with plugins.
  version        # Print the client and server version information

