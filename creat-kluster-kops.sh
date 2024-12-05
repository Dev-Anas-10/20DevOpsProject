#!/bin/bash

export KOPS_STATE_STORE=s3://kops-project
export NAME=kops.dev-anas.xyz

# Create the Kubernetes cluster with the specified configuration
kops create cluster \
  --name=$NAME \
  --state=$KOPS_STATE_STORE \
  --zones=us-east-1a \
  --node-count=1 \
  --node-size=t3.small \
  --master-size=t3.small \
  --dns-zone=$NAME \
  --node-volume-size=8 \
  --master-volume-size=8 

# Update the cluster and grant admin access
kops update cluster --name $NAME --state=$KOPS_STATE_STORE --yes --admin

# Validate the cluster to ensure it's set up correctly
kops validate cluster --state=$KOPS_STATE_STORE

# Delete the cluster when no longer needed
kops delete cluster --name $NAME --state=$KOPS_STATE_STORE --yes


#attaching two new permissions (AmazonEC2FullAccess, AmazonElasticLoadBalancingFullAccess) 
#to "masters.kube.xxxxxx" role in IAM Roles. Thanks.

# https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/

# https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

# https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

# https://kubernetes.io/docs/concepts/workloads/controllers/job/

# https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/

# https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/