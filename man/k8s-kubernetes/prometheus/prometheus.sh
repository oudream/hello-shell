#!/usr/bin/env bash

open https://github.com/coreos/kube-prometheus
open https://github.com/prometheus/prometheus
open https://www.jianshu.com/p/2fbbe767870d
open https://github.com/coreos/prometheus-operator
# open https://coreos.com/blog/the-prometheus-operator.html
# open https://github.com/giantswarm/prometheus



# Create the monitoring stack using the config in the manifests directory:
# Create the namespace and CRDs, and then wait for them to be availble before creating the remaining resources
kubectl create -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl create -f manifests/

# Prometheus
kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
# Then access via http://localhost:9090

# Grafana
kubectl --namespace monitoring port-forward svc/grafana 3000
# Then access via http://localhost:3000 and use the default grafana user:password of admin:admin.

# Alert Manager
kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
# Then access via http://localhost:9093


# And to teardown the stack:
kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup

