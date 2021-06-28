#!/usr/bin/env bash


open https://hub.helm.sh/charts


open https://helm.sh/docs/chart_template_guide/getting_started/
helm create mychart
rm -rf mychart/templates/*
cat >> mychart/templates/configmap.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: mychart-configmap
data:
  myvalue: "Hello World"
EOF
helm install full-coral ./mychart
kubectl get configmap --all-namespaces
    # default       mychart-configmap                                     1      11s
# The helm get manifest command takes a release name (full-coral) and prints out all of the Kubernetes resources
helm get manifest full-coral
helm uninstall full-coral
cat > mychart/templates/configmap.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myvalue: "Hello World"
EOF
helm install clunky-serval ./mychart
kubectl get configmap --all-namespaces
    # default       clunky-serval-configmap                               1      14m
helm get manifest clunky-serval
helm uninstall clunky-serval
# When you want to test the template rendering, but not actually install anything, you can use :
helm install --debug --dry-run goodly-guppy ./mychart



open https://hub.helm.sh/charts
helm create diy1
helm template diy1


# helm search
helm search [command]
  hub  #         search for charts in the Helm Hub or an instance of Monocular
  repo #       search repositories for a keyword in charts


# hub
helm repo add nginx https://helm.nginx.com/stable
helm repo update
helm search repo nginx-ingress
helm install my-ingress-controller nginx/nginx-ingress
kubectl get deployments
helm uninstall my-ingress-controller


# hub
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
helm install stable/redis-ha --version 4.1.5

# hub
helm repo add apphub https://apphub.aliyuncs.com


open https://helm.sh/docs/topics/chart_repository/

open https://helm.sh/docs/intro/
open https://github.com/helm/helm
open https://github.com/helm/helm/releases
open https://kubernetes.io/zh/docs/tasks/service-catalog/install-service-catalog-using-helm/

### tiller been removed
open https://helm.sh/blog/helm-3-released/
open https://www.kubernetes.org.cn/6680.html
open https://helm.sh/docs/faq/#changes-since-helm-2
open https://helm.sh/blog/helm-3-preview-pt2/



### install
wget https://get.helm.sh/helm-v3.1.1-linux-amd64.tar.gz
tar zxvf helm-v3.1.1-linux-amd64.tar.gz
cp linux-amd64/helm /usr/local/bin/



The Kubernetes package manager

Common actions for Helm:

- helm search:    search for charts
- helm pull:      download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts

Environment variables:

+------------------+-----------------------------------------------------------------------------+
| Name             | Description                                                                 |
+------------------+-----------------------------------------------------------------------------+
| $XDG_CACHE_HOME  | set an alternative location for storing cached files.                       |
| $XDG_CONFIG_HOME | set an alternative location for storing Helm configuration.                 |
| $XDG_DATA_HOME   | set an alternative location for storing Helm data.                          |
| $HELM_DRIVER     | set the backend storage driver. Values are: configmap, secret, memory       |
| $HELM_NO_PLUGINS | disable plugins. Set HELM_NO_PLUGINS=1 to disable plugins.                  |
| $KUBECONFIG      | set an alternative Kubernetes configuration file (default "~/.kube/config") |
+------------------+-----------------------------------------------------------------------------+

Helm stores configuration based on the XDG base directory specification, so

- cached files are stored in $XDG_CACHE_HOME/helm
- configuration is stored in $XDG_CONFIG_HOME/helm
- data is stored in $XDG_DATA_HOME/helm

By default, the default directories depend on the Operating System. The defaults are listed below:

+------------------+---------------------------+--------------------------------+-------------------------+
| Operating System | Cache Path                | Configuration Path             | Data Path               |
+------------------+---------------------------+--------------------------------+-------------------------+
| Linux            | $HOME/.cache/helm         | $HOME/.config/helm             | $HOME/.local/share/helm |
| macOS            | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm      |
| Windows          | %TEMP%\helm               | %APPDATA%\helm                 | %APPDATA%\helm          |
+------------------+---------------------------+--------------------------------+-------------------------+

Usage:
  helm [command]

Available Commands:
  completion  Generate autocompletions script for the specified shell (bash or zsh)
  create      create a new chart with the given name
  dependency  manage a chart's dependencies
  env         Helm client environment information
  get         download extended information of a named release
  help        Help about any command
  history     fetch release history
  install     install a chart
  lint        examines a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      install, list, or uninstall Helm plugins
  pull        download a chart from a repository and (optionally) unpack it in local directory
  repo        add, list, remove, update, and index chart repositories
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  show        show information of a chart
  status      displays the status of the named release
  template    locally render templates
  test        run tests for a release
  uninstall   uninstall a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client version information

Flags:
      --add-dir-header                   If true, adds the file directory to the header
      --alsologtostderr                  log to standard error as well as files
      --debug                            enable verbose output
  -h, --help                             help for helm
      --kube-context string              name of the kubeconfig context to use
      --kubeconfig string                path to the kubeconfig file
      --log-backtrace-at traceLocation   when logging hits line file:N, emit a stack trace (default :0)
      --log-dir string                   If non-empty, write log files in this directory
      --log-file string                  If non-empty, use this log file
      --log-file-max-size uint           Defines the maximum size a log file can grow to. Unit is megabytes. If the value is 0, the maximum file size is unlimited. (default 1800)
      --logtostderr                      log to standard error instead of files (default true)
  -n, --namespace string                 namespace scope for this request
      --registry-config string           path to the registry config file (default "/root/.config/helm/registry.json")
      --repository-cache string          path to the file containing cached repository indexes (default "/root/.cache/helm/repository")
      --repository-config string         path to the file containing repository names and URLs (default "/root/.config/helm/repositories.yaml")
      --skip-headers                     If true, avoid header prefixes in the log messages
      --skip-log-headers                 If true, avoid headers when opening log files
      --stderrthreshold severity         logs at or above this threshold go to stderr (default 2)
  -v, --v Level                          number for the log level verbosity
      --vmodule moduleSpec               comma-separated list of pattern=N settings for file-filtered logging

Use "helm [command] --help" for more information about a command.
