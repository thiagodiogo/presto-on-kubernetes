## Presto on Kubernetes

## Install

1. Clone this repo:

`git clone https://github.com/thiagodiogo/presto-on-kubernetes.git`

2. Create a K8S namespace for your cluster:

`kubectl create namespace presto`

3. Install HDFS node it in your K8s cluster:

`kubectl apply -f hdfs.yaml --namespace presto`

4. Install Hive Metastore node it in your K8s cluster:

`kubectl apply -f metastore.yaml --namespace presto`

5. Install Presto Coordinator and Workers in your K8s cluster:

`kubectl apply -f presto.yaml --namespace presto`

## Changing configurations in the Cluster

1. Change the configuration file

2. Apply the change to the cluster

`kubectl apply -f presto.yaml --namespace presto`

## Uninstall

Uninstall Presto cluster in your K8s cluster:

* `kubectl delete -f hdfs.yaml --namespace presto`
* `kubectl delete -f metastore.yaml --namespace presto`
* `kubectl delete -f presto.yaml --namespace presto`
