[Index](index)

# Production Grade Infrastructure: What I learned after writing 500k lines of infrastructure as code

| project                        | examples                           | time estimate |
| ------------------------------ | ---------------------------------- | ------------- |
| managed service                | ecs, elb, rds, elasticache         | 1-2 weeks     |
| distributed system (stateless) | nginx, node.js app, rails app      | 2-4 weeks     |
| distributed system (stateful)  | elasticsearch, kafka, mongodb      | 2-4 months    |
| entire cloud architecture      | apps, dbs, ci/cd, monitoring, etc. | 6-24 months   |

**The benefits of code**

1. automation
2. version control
3. code review
4. testing
5. documentation
6. reuse

**Primarily written on**

* bash
* go
* python
* terraform

## Outline

1. Checklist
2. Tools
3. Modules
4. Tests
5. Releases

**Reasons project takes long**

1. yak shaving
2. it is a long checklist

## 1. The production-grade checklist

**Part 1 of 4 (what most people are familiar with)**

| task      | description                                                                                                                        | example tools                                  |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| install   | install the software binaries and all dependencies                                                                                 | bash, chef, ansible, puppet                    |
| configure | configure the software at runtime: e.g., configure port settings, file paths, users, leaders, followers, replication, etc.         | bash, chef, ansible, puppet                    |
| provision | provision the infrastructure: e.g., ec2 instances, load balancers, network topology, security groups, IAM permissions, etc.        | terraform, cloudformation                      |
| deploy    | deploy the service on top of the infrastructure. roll out updates with no downtime: e.g., blue-green, rolling, canary deployments. | scripts, orchestration tools (ecs, k8s, nomad) |

**Part 2 of 4 (what most people forget)**

| task             | description                                                                                                    | example tools                               |
| ---------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| security         | encryption in transit (tls) and on disk, authentication, authorization, secrets management, server hardening.  | acm, ebs volumes, cognito, vault, cis       |
| monitoring       | availability metrics, business metrics, app metrics, server metrics, events, observability, tracing, alerting. | cloudwatch, datadog, newrelic, honeycomb    |
| logs             | rotate logs on disk. aggregate log data to a central location.                                                 | cloudwatch logs, elk, sumologic, papertrail |
| backup & restore | make backups of dbs, caches, and other data on a scheduled basis. replicate to separate region/account.        | rds, elasticache, ec2-snapper, lambda       |

**Part 3 of 4 (tend to be forgotten)**

| task              | description                                                                                                     | example tools                                            |
| ----------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| networking        | vpcs, subnets, static and dynamic ips, service discovery, service mesh, firewalls, dns, ssh access, vpn access. | eips, enis, vpcs, nacls, sgs, route53, openvpn           |
| high availability | withstand outages of individual processes, ec2 instances, services, availability zones, and regions             | multi-az, multi-region, replication, asgs, elbs          |
| scalability       | scale up and down in responses to load. scale horizontally (more servers) and/or vertically (bigger servers)    | asgs, replication, sharding, caching, divide and conquer |
| performance       | optimize cpu, memory, disk, network, and gpu usage. query tuning. benchmarking, load testing, profiling.        | dynatrace, valgrind, visualvm, ab, jmeter                |

**Part 4 of 4 (almost nobody get to be paid for)**

| task              | description                                                                                          | example tools                            |
| ----------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| cost optimization | pick proper instance types, use spot and reserved instances, use auto-scaling, nuke unused resources | asgs, spot instances, reserved instances |
| documentation     | document your code, architecture, and practice. create playbooks to respond to incidents.            | readmes, wikis, slack                    |
| tests             | write automated tests for your infrastructure code. run tests after every commit and nightly.        | terratest                                |

**Key takeaway: use a checklist to build production-grade infrastructure.**

## 2. Tools

**We prefer tools that**

1. define infrastructure as code
2. are open source & popular
3. support multiple providers
4. support reuse & composition
5. require no extra infrastructure
6. support immutable infrastructure

**The most effective toolset as 2018**

1. deploy all the basic infrastructure with terraform
2. configure the vms using packer
3. some of the vms form a cluster (e.g. ecs or kubernetes cluster)
4. we use that docker cluster to run docker containers
5. under the hood: glue everything together with bash, go, and python

**Key takeaway: tools are not enough, you also need to change the behavior.**

> Old way: make changes directly and manually.
New way: make changes indirectly and automatically.

## 3. Modules

> It's tempting to define all of your infrastructure code in 1 file or folder.

**Downsides**

* runs slower
* harder to understand
* harder to review
* harder to testing
* harder to reuse code
* need admin permissions
* team concurrency limited to 1
* mistake anywhere could break everything

> Large modules considered harmful

**Recommendations:**

* what you really want is isolation for each environment and for each component
* take your infrastructure and break it up into small, reusable, standalone, tested modules

**Implementation:**

* break architecture down by environment
* break environments down by infrastructure types
* implement infrastructure in modules
* build complex modules from simpler modules
* typical repo has three key folders:
  * /modules: implementation code, broken down into standalone sub-modules
  * /examples: runnable example code for how to use the sub-modules
  * /test: automated tests for the sub-modules

**Key takeaway: build infrastructure from small, composable modules.**

## 4. Tests

**Infrastructure code rots very quickly -> infrastructure code without automated tests is broken**

For general purpose language (bash, go, python) we can run tests on localhost. But, for infrastructure as code tools, there is no localhost.

**Therefore, the test strategy is**

1. deploy real infrastructure
2. validate it works
3. undeploy the infrastructure

Write infrastructure code integration test using go using terratest. Tests create and destroy lots of resources.

**Pro tips:**

1. run tests in completely separate "sandbox" accounts
2. clean up left-over resources with cloud-nuke

**Test pyramid:**

* smallest end-to-end tests: entire stack (30-120+ minutes): test entire environments (stage, prod)
* smaller integration tests: multiple modules (5-60 minutes): test multiple sub-modules together
* small unit tests: individual modules (1-20 minutes): test individual sub-modules (keep them small!)

As you go up the pyramid, tests get more expensive, brittle, and slower. Make sure to checkout terratest best practices for how to speed things up.

**Key takeaway: infrastructure code without automated tests is broken**

## 5. Releases

**Here is how you will build your infrastructure from now on:**

1. go through the checklist
2. write some code
3. write automated tests
4. do a code review
5. release a new version of your code
6. promote that versioned code from environment to environment

**Key takeaway: we go from pizza on iron to tested code that has been through checklist, a code review, it is versioned and we are rolling it from environment to environment.**
