# KVM playbook

This directory contains an Ansible playbook to install a local KVM hypervisor.
The playbook uses a contributed Ansible role. This playbook should be run as a
local user (which has sudo privileges).

## Usage

Install Ansible and then run the playbook with:

    ansible-galaxy install -r requirements.yaml
    ansible-playbook kvm.yaml

## Guest hostname resolution

Systemd based systems can be configured to use the local resolver to resolve
guests by hostname instead of needing to ssh to them by IP address. Some care
must be given to avoid resolution lookup loops, since by default libvirt will
use the local resolver.  The kvm.yaml playbook will create a libvirt network
which does not use a local resolver to avoid the lookup loops. If you install
libvirt/kvm manually, take care to add a non-local resolver.

Each time guests are installed, run the `systemd-resolve` to set the dns
gateway for the virtual bridge. This can be done by providing a `postinstall`
command in the `virt-lab` configuration file. See the `virt-lab.cfg.example`
file the `systemd-resolve` command syntax.
