---
title: Kubernetes Componets
---

[Index](index.md) >> [Kubernetes](kubernetes.md) >> [Concepts](kubernetes-concepts.md)

A Kubernetes cluster

* at least 1 worker node(s)
* worker node(s) host Pods (application workload)
* control plane manages the worker nodes and the Pods
* in production, the control plane runs across multiple computers and runs multiple nodes for fault-tolerance and high availability

![components of kubernetes](components-of-kubernetes.png)

# Control Plane Components

* make global decisions about the cluster (e.g., scheduling)
* detect and respond to cluster events

## kube-apiserver

kube-apiserver is the front end of the Kubernetes control plane and exposes the Kubernetes API.

## etcd

etcd is consistent and highly-available key value store used as Kubernetes' backing store for all cluster data. Make sure you have a [back up](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster) plan for etcd data.

## kube-scheduler

kube-scheduler is control plane component that watches for newly created Pods with no assigned node, and selects a node for them to run on.

Scheduling factors:

* individual and collective resource requirements
* hardware/software/policy constraints
* affinity and anti-affinity specifications
* data locality
* inter-workload interference
* deadlines

## kube-controller-manager

kube-controller-manager is control Plane component that runs controller processes.

Some types of controllers are:

* Node controller
* Job controller
* Endpoints controller
* Service Account & Token controllers

## cloud-controller-manager

A Kubernetes control plane component that embeds cloud-specific control logic.

The following controllers can have cloud provider dependencies:

* Node controller
* Route controller
* Service controller

# Node Components

* maintains running pods
* provides the Kubernetes runtime environment

## kubelet

kubelet is an agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

## kube-proxy

kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

## Container runtime

The container runtime is the software that is responsible for running containers (e.g., Docker, containerd, CRI-O, and any implementation of the [Kubernetes CRI (Container Runtime Interface)](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-node/container-runtime-interface.md))

# Addons

[Addons](https://kubernetes.io/docs/concepts/cluster-administration/addons/) use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features. Namespaced resources for addons which are providing cluster-level features belong within the kube-system namespace.

## DNS

[Cluster DNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/) is a DNS server, in addition to the other DNS server(s) in your environment, which serves DNS records for Kubernetes services.

## Web UI (Dashboard)

[Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) is a general purpose, web-based UI for Kubernetes clusters.

## Container Resource Monitoring

[Container Resource Monitoring](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-usage-monitoring/) records generic time-series metrics about containers in a central database, and provides a UI for browsing that data.

## Cluster-level Logging

A [cluster-level logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/) mechanism is responsible for saving container logs to a central log store with search/browsing interface.
