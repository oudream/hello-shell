#!/usr/bin/env bash

kubectl api-resources

NAME                              SHORTNAMES   APIGROUP                       NAMESPACEDKIND

bindings                                                                      trueBinding
componentstatuses                 cs                                          falseComponentStatus
configmaps                        cm                                          trueConfigMap
endpoints                         ep                                          trueEndpoints
events                            ev                                          trueEvent
limitranges                       limits                                      trueLimitRange
namespaces                        ns                                          falseNamespace
nodes                             no                                          falseNode
persistentvolumeclaims            pvc                                         truePersistentVolumeClaim
persistentvolumes                 pv                                          falsePersistentVolume
pods                              po                                          truePod
podtemplates                                                                  truePodTemplate
replicationcontrollers            rc                                          trueReplicationController
resourcequotas                    quota                                       trueResourceQuota
secrets                                                                       trueSecret
serviceaccounts                   sa                                          trueServiceAccount
services                          svc                                         trueService
mutatingwebhookconfigurations                  admissionregistration.k8s.io   falseMutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io   falseValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io           falseCustomResourceDefinition
apiservices                                    apiregistration.k8s.io         falseAPIService
controllerrevisions                            apps                           trueControllerRevision
daemonsets                        ds           apps                           trueDaemonSet
deployments                       deploy       apps                           trueDeployment
replicasets                       rs           apps                           trueReplicaSet
statefulsets                      sts          apps                           trueStatefulSet
tokenreviews                                   authentication.k8s.io          falseTokenReview
localsubjectaccessreviews                      authorization.k8s.io           trueLocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io           falseSelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io           falseSelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io           falseSubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling                    trueHorizontalPodAutoscaler
cronjobs                          cj           batch                          trueCronJob
jobs                                           batch                          trueJob
certificatesigningrequests        csr          certificates.k8s.io            falseCertificateSigningRequest
leases                                         coordination.k8s.io            trueLease
events                            ev           events.k8s.io                  trueEvent
daemonsets                        ds           extensions                     trueDaemonSet
deployments                       deploy       extensions                     trueDeployment
ingresses                         ing          extensions                     trueIngress
networkpolicies                   netpol       extensions                     trueNetworkPolicy
podsecuritypolicies               psp          extensions                     falsePodSecurityPolicy
replicasets                       rs           extensions                     trueReplicaSet
ingresses                         ing          networking.k8s.io              trueIngress
networkpolicies                   netpol       networking.k8s.io              trueNetworkPolicy
runtimeclasses                                 node.k8s.io                    falseRuntimeClass
poddisruptionbudgets              pdb          policy                         truePodDisruptionBudget
podsecuritypolicies               psp          policy                         falsePodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io      falseClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io      falseClusterRole
rolebindings                                   rbac.authorization.k8s.io      trueRoleBinding
roles                                          rbac.authorization.k8s.io      trueRole
priorityclasses                   pc           scheduling.k8s.io              falsePriorityClass
csidrivers                                     storage.k8s.io                 falseCSIDriver
csinodes                                       storage.k8s.io                 falseCSINode
storageclasses                    sc           storage.k8s.io                 falseStorageClass
volumeattachments                              storage.k8s.io                 falseVolumeAttachment