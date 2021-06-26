---
title: GitOps
---

[Index](index.md)

# What is GitOps

[Source](https://www.weave.works/blog/what-is-gitops-really)

A concise description of GitOps

1. Describe the desired state of the whole system using a declarative specification for each environment.
    * A git repo is the single source of truth for the desired state of the whole system. 
    * All changes to the desired state are Git commits.
    * All specified properties of the cluster are also observable in the cluster, so that we can detect if the desired and observed states are the same (converged) or different (diverged).   
2. When the desired and observed states are not the same then:
    * There is a convergence mechanism to bring the desired and observed states in sync both eventually, and autonomically.  Within the cluster, this is Kubernetes.
    * This is triggered immediately with a "change committed" alert.  
    * After a configurable interval, an alert "diff" may also be sent if the states are divergent.
3. Hence all Git commits cause verifiable and idempotent updates in the cluster. 
    * Rollback is: "convergence to an earlier desired state".
4. Convergence is eventual and indicated by:
    * No more "diff" alerts during a defined time interval.
    * A "converged" alert (eg. webhook, Git writeback event).

# CI/CD

## Observability

**4 Dimensions of CI/CD Observability**

[Source](https://blog.thundra.io/4-best-practices-for-observability)

1. Optimizing and centralizing log data
    * make sure your logs are structured and descriptive, tracking only the essential details:
        * Unique user ID
        * Session ID
        * Timestamps
        * Resource usage
2. DevOps culture
    * DevOps cultural transformation
        * Embrace end-to-end responsibility
        * Build a collaborative environment
        * Drive a willingness to fail (and learn from it)
        * Focus on continuous improvements
        * Zero in on customer needs
        * Automate as much as possible
    * Know your organization's shared goals
        * How are we determining failure and success?
        * What metrics are needed to assess rates of success and failure?
        * What is most important to optimize and improve?
3. Observability in Production
    * Passive monitoring: a passive monitor collects user data from individual network locations, monitoring data flow and gathering statistics about usage patterns.
    * Alerting: an alert system ensures that developers know when something has to be fixed so they can stay focused on other tasks.
4. Pre-Production observability
    * Remote debugging

# References

* [GlooOps: Progressive delivery, the GitOps way](https://www.solo.io/blog/glooops-progressive-delivery-the-gitops-way/)


