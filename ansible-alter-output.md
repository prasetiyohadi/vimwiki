[Index](index)
[Ansible](ansible)

# Alter Ansible's output on debugging

Use wrapper script for Ansible
```
#!/bin/sh

echo -n "$@" | grep -q -- "-v" && export ANSIBLE_STDOUT_CALLBACK=yaml

ansible-playbook test.yml "$@"
```
