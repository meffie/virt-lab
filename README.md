# Virtual Linux Lab

Create guests on a local kvm hypervisor from cloud-init images using the
`kvm-install-vm` shell script.

A simple config file can be used to define sets of guests to be created and
destroyed.  The last mac address assigned is saved for the next generation.

An ansible playbook to setup the kvm hypervisor on a new machine is provided.
