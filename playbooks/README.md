# Ansible playbooks for virt-lab

This is a collection of small Ansible playbooks for setting up new guests.
These may be run by the `virt-lab` postcreate script.

## Playbook

* `wait.yaml` - Wait for systems to become reachable

## Setup

1. Postcreate script

Create a script to run ansible playbook using the virt-lab `inventory.sh`
script to generate a dynamic inventory of the guest created by virt-lab.  This
script may run one or more playbooks.

For example, to run the `wait.yaml` playbook:

    #!/bin/sh
    ansible-playbook -i ${VIRTLAB_SCRIPTDIR}/inventory.sh ${VIRTLAB_PLAYBOOKDIR}/<playbook>.yaml
