---
title: Validate node setup
---

[Index](index.md) >> [Kubernetes](kubernetes.md)

# Node Conformance Test

*Node conformance test* is a containerized test framework that provides a system verification and functionality test for a node to qualify a node to join a cluster.

# Node Prerequisite

At a minimum, the node should have

* container runtime
* kubelet

# Running Node Conformance Test

1. Workout the value of the `--kubeconfig` option for the kubelet, for example `--kubeconfig=/var/lib/kubelet/config.yaml`
    * Use `http://localhost:8080` as the URL of the API server
    * Specify arbitrary CIDR for Kubelet, for example `--pod-cidr=10.180.0.0/24`
    * Remove the `--cloud-provider` value to run the test
2. Run the node conformance test
```
# $CONFIG_DIR is the pod manifest path of your Kubelet.
# $LOG_DIR is the test output path.
sudo docker run -it --rm --privileged --net=host \
  -v /:/rootfs -v $CONFIG_DIR:$CONFIG_DIR -v $LOG_DIR:/var/result \
  k8s.gcr.io/node-test:0.2
```

# Running Node Conformance Test for Other Architectures

| Arch  | Image           |
| ----- | --------------- |
| amd64 | node-test-amd64 |
| arm   | node-test-arm   |
| arm64 | node-test-arm64 |

# Running Selected Test

To run specific test, overwrite the environment variable `FOCUS` with the regex of tests you want to run
```
sudo docker run -it --rm --privileged --net=host \
  -v /:/rootfs:ro -v $CONFIG_DIR:$CONFIG_DIR -v $LOG_DIR:/var/result \
  -e FOCUS=MirrorPod \ # Only run MirrorPod test
  k8s.gcr.io/node-test:0.2
```

To skip specific test, overwrite the environment variable `SKIP` with the regex of tests you want to skip
```
sudo docker run -it --rm --privileged --net=host \
  -v /:/rootfs:ro -v $CONFIG_DIR:$CONFIG_DIR -v $LOG_DIR:/var/result \
  -e SKIP=MirrorPod \ # Run all conformance tests but skip MirrorPod test
  k8s.gcr.io/node-test:0.2
```

It is strongly recommended to only run conformance test.

# Caveats

* The test leaves some docker images on the node
* The test leaves dead containers on the node
