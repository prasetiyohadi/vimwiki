---
title: Considerations for large clusters
---

[Index](index.md) >> [Kubernetes](kubernetes.md)

**Kubernetes v1.21**

* <= 100 pods per node
* <= 5000 nodes
* <= 150000 total pods
* <= 300000 total containers

# Cloud providers

Prevent cloud provider quota issues

* Requesting a quota increase for cloud resources
    * Computer instances
    * CPUs
    * Storage volumes
    * In-use IP addresses
    * Packet filtering rule sets
    * Number of load balancers
    * Network subnets
    * Log streams
* Gating cluster scaling actions to batches of new nodes with delay between batches to factor cloud providers rate limit of new instances creation

# Control plane components

* 1 or 2 control plane instances per failure zone
* Scale vertically first, then horizontally
* At least 1 per failure zone for fault-tolerance
* Use managed load balancer to send traffic from kubelets and pods to control plane in the same failure zone

## etcd storage

Improve performance by store Event objects in a separate dedicated etcd instance

* Start and configure additional etcd instance when creating a cluster
* Configure the API server to use it for storing eventso

# Addon resources

Addon can consume more of some resources than their default limits when running large cluster and may continuously get killed because hitting the memory limit.

* Some addons scale vertically, increase requests and limits as you scale out your cluster
* Many addons scale horizontally, add capacity by running more pods, raise CPU or memory limits slightly for a very large cluster
* Some addons run as one copy per node controlled by a DaemonSet, raise CPU or memory limits slightly for a very large cluster

# What's next

[VerticalPodAutoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#readme) is a custom resource to help manage resource requests and limits for pods and can run in *recommender* mode to provided suggested figures for requests and limits.

The [cluster autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#readme) integrates with a number of cloud providers to help run the right number of nodes for the level of resource demand.
