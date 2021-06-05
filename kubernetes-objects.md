---
title: Working with Kubernetes Objects
---

[Index](index.md) >> [Kubernetes](kubernetes.md) >> [Concepts](kubernetes-concepts.md)

# Understanding Kubernetes objects

Kubernetes objects are persistent entities in the Kubernetes system which represent the state of the cluster.

* containerized applications and its node
* resource available to application
* policies around how those applications behave

## Object Spec and Status

* `spec`: description of the desired state
* `status`: description of the current state

## Describing a Kubernetes object

Most often, you provide the information to kubectl in a .yaml file.
```
kubectl apply -f https://k8s.io/examples/application/deployment.yaml --record
```

## Required Fields

* `apiVersion`
* `kind`
* `metadata`
* `spec`

The [Kubernetes API Reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/) can help you find the spec format for all of the objects you can create using Kubernetes.

* [PodSpec v1 core](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/#podspec-v1-core)
* [DeploymentSpec v1 apps](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/#deploymentspec-v1-apps)

# Kubernetes Object Management

## Management techniques

| Management technique             | Operates on          | Recommended environment | Supported writers | Learning curve |
| -------------------------------- | -------------------- | ----------------------- | ----------------- | -------------- |
| Imperative commands              | Live objects         | Development projects    | 1+                | Lowest         |
| Imperative object configuration  | Individual files     | Production projects     | 1                 | Moderate       |
| Declarative object configuration | Directories of files | Production projects     | 1+                | Highest        |

## Imperative commands

Examples
```
kubectl create deployment nginx --image nginx
```

| Advantages compared to object configuration               | Disadvantages compared to object configuration             |
| --------------------------------------------------------- | ---------------------------------------------------------- |
| expressed as a single action word                         | do not integrate with change review processes              |
| require only a single step to make changes to the cluster | do not provide an audit trail associated with changes      |
|                                                           | do not provide a source of records except for what is live |
|                                                           | do not provide a template for creating new objects         |

## Imperative object configuration

Examples
```
kubectl create -f nginx.yaml
kubectl delete -f nginx.yaml -f redis.yaml
kubectl replace -f nginx.yaml
```

| Advantages compared to imperative commands                                          | Disadvantages compared to imperative commands       |
| ----------------------------------------------------------------------------------- | --------------------------------------------------- |
| can be stored in a source control system such as Git                                | requires basic understanding of the object schema   |
| can integrate with processes such as reviewing changes before push and audit trails | requires the additional step of writing a YAML file |
| provides a template for creating new objects                                        |                                                     |

| Advantages compared to declarative object configuration | Disadvantages compared to declarative object configuration                                         |
|                                                         |                                                                                                    |
| simpler and easier to understand                        | works best on files, not directories                                                               |
| more mature as of Kubernetes version 1.5                | updates to live objects must be reflected in configuration files or it will be lost in next update |


## Declarative object configuration

Examples
```
kubectl diff -f configs/
kubectl apply -f configs/
kubectl diff -R -f configs/
kubectl apply -R -f configs/
```

| Advantages compared to imperative object configuration                                  | Disadvantages compared to imperative object configuration             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| changes made directly to live objects are retained                                      | harder to debug and understand results when they are unexpected       |
| better support for operating on directories and automatically detecting operation types | partial updates using diffs create complex merge and patch operations |

# Object Names and IDs

* name: unique for that type of resource
* uid: unique across the whole cluster
* labels and annotations: non-unique user-provided attributes

## Names

A client-provided string that refers to an object in a resource URL, such as `/api/v1/pods/some-name`.

* DNS subdomain names as defined in [RFC 1123](https://tools.ietf.org/html/rfc1123)
    * contain no more than 253 characters
    * contain only lowercase alphanumeric characters, '-' or '.'
    * start with an alphanumeric character
    * end with an alphanumeric character
* DNS label names as defined in [RFC 1123](https://tools.ietf.org/html/rfc1123)
    * contain at most 63 characters
    * contain only lowercase alphanumeric characters or '-'
    * start with an alphanumeric character
    * end with an alphanumeric character
* Path segment names
    * require to be able safely encoded as a path segment
    * may not be "." or ".."
    * may not contain "/" or "%"

## UIDs

A Kubernetes systems-generated string to uniquely identify objects universally and also known as UUID which is standardized as ISO/IEC 9834-8 and as ITU-T X.667.

# Namespaces

Kubernetes supports multiple virtual clusters backed by the same physical cluster called namespaces.

* provide a scope for names
* divide cluster resources between multiple users (via [resource quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/))
* use labels to distinguish resources within the same namespace

## Namespaces and DNS

`<service-name>.<namespace-name>.svc.cluster.local`

## Not All Objects are in a Namespace

* namespace resources are not themselves in a namespace
* low-level resources, such as nodes and persistentVolumes, are not in any namespace

## Automatic labelling

The Kubernetes control plane sets an immutable label `kubernetes.io/metadata.name` which value is the namespace on all namespaces, provided that the `NamespaceDefaultLabelName` [feature gate](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/) is enabled.

# Labels and Selectors

*Labels* are key/value pairs that intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system.

Example labels:

* `"release" : "stable"`, `"release" : "canary"`
* `"environment" : "dev"`, `"environment" : "qa"`, `"environment" : "production"`
* `"tier" : "frontend"`, `"tier" : "backend"`, `"tier" : "cache"`
* `"partition" : "customerA"`, `"partition" : "customerB"`
* `"track" : "daily"`, `"track" : "weekly"`

## Syntax and character set

Labels syntax:
```
"metadata": {
  "labels": {
    "key1" : "value1",
    "key2" : "value2"
  }
}
```

Valid label key:

* optional prefix and name, separated by a slash (`/`)
* name segment is required
    * must be 63 characters or less
    * beginning and ending with an alphanumeric character (`[a-z0-9A-Z]`)
    * dashes (`-`), underscores (`_`), dots (`.`), and alphanumerics in between
* prefix is optional
    * must be a DNS subdomain
    * a series of DNS labels separated by dots (`.`)
    * not longer than 253 characters in total
    * followed by a slash (`/`)
    * automated system components must specify a prefix
    * key without prefix is presumed to be private to the user
    * `kubernetes.io/` and `k8s.io/` prefixes are reserved for Kubernetes core components

Valid label value:

* must be 63 characters or less (can be empty)
* unless empty, must begin and end with an alphanumeric character (`[a-z0-9A-Z]`)
* could contain dashes (`-`), underscores (`_`), dots (`.`), and alphanumerics in between

## Label selectors

Via a *label selector*, the client/user can identify a set of objects.

* *equality-based*
    * three operators: `=`, `==`, `!=`
    * comma operator: e.g., `environment=production,tier!=frontend`
* *set-based*
    * three operators: `in`, `notin`, `exists` (only the key) or `!<key>` (not exists)
    * e.g., `environment in (production, qa)`, `tier notin (frontend, backend)`, `partition`, `!partition`
* multiple *requirements* using comma which acts as a logical AND (`&&`) operator
* *equality-based* and *set-based* can be mixed: e.g., `partition in (customerA, customerB),environment!=qa`

## API

### LIST and WATCH filtering

URL query string

* *equality-based* requirements: `?labelSelector=environment%3Dproduction,tier%3Dfrontend`
* *set-based* requirements: `?labelSelector=environment+in+%28production%2Cqa%29%2Ctier+in+%28frontend%29`

`kubectl`
```
kubectl get pods -l environment=production,tier=frontend
kubectl get pods -l 'environment in (production),tier in (frontend)'
```

*set-based* are more expensive because they can implement OR operator or restricting negative matching
```
kubectl get pods -l 'environment in (production, qa)'
kubectl get pods -l 'environment,environment notin (frontend)'
```

### Set references in API objects

Some Kubernetes objects, such as `services` and `replicationcontrollers`, also use label selectors to specify sets of other resources, such as `pods`.

### Service and ReplicationController

`json`
```
"selector": {
    "component" : "redis",
}
```

`yaml`
```
selector:
    component: redis
```

### Resources that support set-based requirements

Newer resources, such as `Job`, `Deployment`, `ReplicaSet`, and `DaemonSet`, support set-based requirements as well.
```
selector:
  matchLabels:
    component: redis
  matchExpressions:
    - {key: tier, operator: In, values: [cache]}
    - {key: environment, operator: NotIn, values: [dev]}
```

### Selecting sets of nodes

One use case for selecting over labels is to constrain the set of nodes onto which a pod can schedule using [node selection](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/).

# Annotations

*Annotations* are key/value pairs that used to attach arbitrary non-identifying metadata to objects.

Annotations can record information:

* Fields managed by a declarative configuration layer
* Build, release, or image information like timestamps, release IDs, git branch, PR numbers, image hashes, and registry address
* Pointers to logging, monitoring, analytics, or audit repositories
* Client library or tool information that can be used for debugging purposes: for example, name, version, and build information
* User or tool/system provenance information, such as URLs of related objects from other ecosystem components
* Lightweight rollout tool metadata: for example, config or checkpoints
* Phone or pager numbers of persons responsible, or directory entries that specify where that information can be found, such as a team web site
* Directives from the end-user to the implementations to modify behavior or engage non-standard features

## Syntax and character set

Annotations syntax
```
"metadata": {
  "annotations": {
    "key1" : "value1",
    "key2" : "value2"
  }
}
```

Valid annotation key

* optional prefix and name, separated by a slash (`/`)
* name segment is required
    * must be 63 characters or less
    * beginning and ending with an alphanumeric character (`[a-z0-9A-Z]`)
    * dashes (`-`), underscores (`_`), dots (`.`), and alphanumerics in between
* prefix is optional
    * must be a DNS subdomain
    * a series of DNS labels separated by dots (`.`)
    * not longer than 253 characters in total
    * followed by a slash (`/`)
    * automated system components must specify a prefix
    * key without prefix is presumed to be private to the user
    * `kubernetes.io/` and `k8s.io/` prefixes are reserved for Kubernetes core components

# Field Selectors

Field selectors let you select Kubernetes resources based on the value of one or more resource fields, e.g.

* `metadata.name=my-service`
* `metadata.namespace!=default`
* `status.phase=Pending`

`kubectl`
```
kubectl get pods --field-selector status.phase=Running
```

Field selectors:

* All resource types support the `metadata.name` and `metadata.namespace` fields
* Unsupported field selectors produces an error
* Support `=`, `==`, `!=` operators
* Can be chained together as a comma-separated list
* Can be used across multiple resource types

# Recommended Labels

Shared labels and annotations share a common prefix: `app.kubernetes.io` to ensure that shared labels do not interfere with custom user labels.

## Labels

In order to take full advantage of using these labels, they should be applied on every resource object.

| Key                            | Description                                        | Example              | Type   |
| ------------------------------ | -------------------------------------------------- | -------------------- | ------ |
| `app.kubernetes.io/name`       | The name of the application                        | `mysql`              | string |
| `app.kubernetes.io/instance`   | A unique name identifying the instance of an app   | `mysql-abcxyz`       | string |
| `app.kubernetes.io/version`    | Current version (e.g., semver, revision hash, etc) | `5.7.21`             | string |
| `app.kubernetes.io/component`  | The component within the architecture              | `database`           | string |
| `app.kubernetes.io/part-of`    | The name of a higher level application             | `wordpress`          | string |
| `app.kubernetes.io/managed-by` | The tool being used to manage the app operation    | `helm`               | string |
| `app.kubernetes.io/created-by` | The controller/user who created this resource      | `controller-manager` | string |

## Examples

### A Simple Stateless Service

`Deployment`
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: myservice
    app.kubernetes.io/instance: myservice-abcxzy
...
```

`Service`
```
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: myservice
    app.kubernetes.io/instance: myservice-abcxzy
...
```

### Web Application With A Database

`Deployment`
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: wordpress
    app.kubernetes.io/instance: wordpress-abcxzy
    app.kubernetes.io/version: "4.9.4"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: wordpress
...
```

`Service` for application
```
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: wordpress
    app.kubernetes.io/instance: wordpress-abcxzy
    app.kubernetes.io/version: "4.9.4"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: wordpress
...
```

`StatefulSet`
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
...
```

`Service` for database
```
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
...
```
