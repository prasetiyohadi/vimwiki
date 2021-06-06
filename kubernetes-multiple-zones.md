---
title: Running in multiple zones
---

[Index](index.md) >> [Kubernetes](kubernetes.md)

Kubernetes is designed to be able to run across multiple failure zones.
Multiple failure zones fit within a logical grouping called a *region*.
Major cloud providers define a region as a set of failure zones (also called *availability zones*) that provide a consistent set of features.

# Control plane behavior

* Place replicas of control plane components across multiple failure zones
* Select and replicate control plane components in at least three failure zones for high-availability
* Configure API server endpoints cross-zone resilience
    * DNS rount-robing
    * SRV records
    * third-party load balancing solution with health checking

# Node behavior

* Pods for workload resources (Deployment or StatefulSet) spread across different nodes automatically
* Kubelet automatically adds labels to Node object that represents the specific including zone information
* Use node labels in conjunction with Pod topology spread constrains to control how Pods are spread across cluster among fault domains: regions; zones; nodes

## Distributing nodes across zones

* Use infrastructure automation tools for deploying nodes
* Use [Cluster API](https://cluster-api.sigs.k8s.io/) to manage nodes

# Manual zone assignment for Pods

Apply node selector constraints to Pods

# Storage access for zones

* `Admission controller`'s `PersistentVolumeLabel` automatically adds zone labels to any PersistenVolumes that are linked to a specific zone
* Specify a StorageClass for PersistenVolumeClaims that specifies the failure domains that the storage in that class may use

# Networking

* Use `network plugin` to configure cluster networking that might have zone-specific elements

# Fault recovery

* Consider wheterh and how to restore service if all the failure zones in a region go off-line at the same time
* Make sure any cluster-critical repair work does not rely on there being at least one healthy node in the cluster

# What's next

* Learn how the scheduler places Pods in a cluster according the configured constraints in [Scheduling and Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/)
