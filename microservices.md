---
title: Microservices
---

[Index](index.md)

## Conway's Law

"Any organization that designs a system will produce a design whose structure is a copy of the organization's communication structure."

## Monolith vs Microservices

**Monolith:**

* Infrastructure simplicity -> Up and running faster
* Code simplicity -> don't need to worry about latency, graceful failure, interaction level monitoring, etc.
* Architecture & organization simplicity -> no hard boundaries, shared tech stack

**Microservices:**

* System ownership -> decoupled tech stack (API contracts)
* Smaller components -> easier to read code (learn)
* Separation of concerns -> fault isolation (easier to troubleshoot)
* Scaling separately -> add more to services that are bottlenecks

## From Monolith to Microservices

* Be pragmatic and focus on enablement
* Good architecture starts with modularity
* Start with core services and shared resources
* Make operational changes
* Start small and think about product/business value
* Move towards asynchronicity and code for resiliency
