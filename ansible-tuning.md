[Index](index)
[Ansible](ansible)

# Measuring Ansible Tasks Execution Time

Update `ansible.cfg`
```
[defaults]

# Enable timing information
callback_whitelist = timer, profile_tasks
```

## Optimizing Ansible SSH Performance

**Enable SSH multiplexing**

Update `ansible.cfg`
```
[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=18000 -o PreferredAuthentications=publickey
control_path = %(directory)s/ansible-ssh-%%h-%%p-%%r
```

Kill broken SSH [mux] processes
```
ps faux | grep ssh | grep "\[mux\]" | awk '{print $2}' | xargs kill
```

**Optimizing SSH PreferredAuthentications**

Update `ansible.cfg`
```
# Adding PreferredAuthentications=publickey to the ssh_args line
ssh_args = -o ControlMaster=auto -o ControlPersist=18000 -o PreferredAuthentications=publickey
```

**Enabling Pipelining**

Update `ansible.cfg`
```
[ssh_connection]
pipelining = True
```

## Optimizing Facts Gathering Process

**Fully disable facts gathering**

Use this snippet on your playbook
```
- hosts: web
  gather_facts: False
```

**Enable only certain facts to be gathered**

Use this snippet on your playbook to gather minimal set of facts
```
- hosts: all
  gather_facts: False
  pre_tasks:
    - setup:
        gather_subset:
          - '!all'
  roles:
    - some_role_here
```

Use this snippet on your playbook to gather minimal set of facts and network and virtual facts groups
```
- hosts: all
  gather_facts: False
  pre_tasks:
    - setup:
        gather_subset:
          - '!all'
          - '!any
          - 'network'
          - 'virtual'
  roles:
    - some_role_here
```

Control fact gathering process using `ansible.cfg`
```
[defaults]
gather_subset=!hardware
```

**Enable facts caching mechanism**

Ansible caching plugins https://docs.ansible.com/ansible/latest/plugins/cache.html

Example configuration of facts caching in json files
```
[defaults]
gathering = smart
fact_caching_connection = /tmp/facts_cache
fact_caching = jsonfile

# The timeout is defined in seconds
fact_caching_timeout = 7200
```

## Some additional optimizations

Update `forks` parameter in `ansible.cfg`
```
[defaults]
forks = 50
```
