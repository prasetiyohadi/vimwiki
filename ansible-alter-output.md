---
title: Alter Ansible's output on debugging
---

[Index](index.md) >> [Ansible](ansible.md)

**Use wrapper script for Ansible**

```
#!/bin/sh

echo -n "$@" | grep -q -- "-v" && export ANSIBLE_STDOUT_CALLBACK=yaml

ansible-playbook test.yml "$@"
```
