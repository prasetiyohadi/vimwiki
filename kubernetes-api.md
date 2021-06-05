---
title: The Kubernetes API
---

[Index](index.md) >> [Kubernetes](kubernetes.md) >> [Concepts](kubernetes-concepts.md)

* The core of Kubernetes' control plan
* exposes an HTTP API for end users, internal, and external components communication
* lets user query and manipulate the state of API objects in Kubernetes (e.g., Pods, Namespaces, ConfigMaps, and Events)

Accessing the Kubernetes API

* [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
* [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)
* REST calls
* [client libraries](https://kubernetes.io/docs/reference/using-api/client-libraries/)

# OpenAPI specification

The Kubernetes API server serves an [OpenAPI](https://www.openapis.org/) spec via the `/openapi/v2` endpoint.

| Header            | Possible values                                              | Notes                                          |
| ----------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| `Accept-Encoding` | `gzip`                                                       | *not supplying this header is also acceptable* |
| `Accept`          | `application/com.github.proto-openapi.spec.v2@v1.0+protobuf` | *mainly for intra-cluster use*                 |
|                   | `application/json`                                           | *default*                                      |
|                   | `*`                                                          | *serves `application/json`*                    |

# Persistence

Kubernetes stores the serialized state of objects by writing them into etcd.

# API groups and versioning

Kubernetes supports multiple API versions

* each at a different API path, such as `/api/v1` or `/apis/rbac.authorization.k8s.io/v1alpha1`
* easier to eliminate fields or restructure resource representations
* versioning is done at the API level rather than at the resource or field level
    * ensure that the API presents a clear, consistent view of system resources and behavior
    * enable controlling access to end-of-life and/or experimental APIs
* implements [API groups](https://kubernetes.io/docs/reference/using-api/#api-groups) that can be [enabled or disabled](https://kubernetes.io/docs/reference/using-api/#enabling-or-disabling)
* API resources distinguished by their API group, resource type, namespace (for namespaced resources)
* The API server handles the conversion between API versions transparently

## API changes

* [API deprecation policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/)
* [API versions reference](https://kubernetes.io/docs/reference/using-api/#api-versioning)

# API Extension

1. Using [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) by adding [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)
2. Implementing an [aggregation layer](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/apiserver-aggregation/)
