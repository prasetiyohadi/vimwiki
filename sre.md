---
title: Site Reliability Engineering (SRE)
---

[Index](index.md)

## Characteristics of Successful Monitoring

[Source](https://thenewstack.io/5-monitoring-characteristics-sres-must-embrace/)

1. Measure Performance to Meet Quality-of-Service Requirements
    * You need full observability of all your infrastructure and all your metrics.
2. Democratize Data To Improve Productivity and Save Time
    * A centralized platform that consistently presents and correlates all data in real time consolidates monitoring efforts across all teams within the organization and enables the business to extract the maximum value from its monitoring efforts.
3. Gain Deeper Context to Reduce MTTR and Gain Higher Insights
    * Metrics with context allow SREs to correlate events, so they can reduce the amount of time required to identify and correct the root cause of service-impacting faults (Metrics 2.0 compliant).
4. Articulate What Success Looks Like
    * You should have a feedback loop that informs you about whether you need to change your concept of what deserves an SLO and what the parameters should be, based on information you learn every day.
5. Retain Your Data So You Can Reduce Future Risk
    * Data retention can often lead to valuable learning that reduces future risk.

## Metrics 2.0

[Metrics 2.0](http://metrics20.org/) is an emerging set of conventions, standards and concepts around timeseries metrics metadata.

**Traditional systems**

```
collectd.dfs1.df.srv-node-dfs10.df-complex.used
```

```
diskspace._srv_node_dfs10.byte_used
{
    host: dfs1
}
```

**Metrics 2.0**

```
{
    host: dfs1
    what: diskspace
    mountpoint: srv/node/dfs10
    unit: B
    type: used
    metric_type: gauge
}
meta: {
    agent: diamond,
    processed_by: statsd2
}
```
