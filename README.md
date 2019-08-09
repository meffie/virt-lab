# Virtual Linux Lab

Install sets of virtual guests using cloud-init images on a local KVM
hypervisor. Guest sets are defined in a simple configuration file.  The last MAC
address assigned to each guest is saved for the next generation.

`virt-lab` can be useful for spinning up clusters of guests for testing and/or
development and then removing them after the tests have been run.

`virt-lab` uses the excellent [`kvm-install-vm`][1] shell script written by
Giovanni Torres to download and install the cloud-init images.

## Setup

You need to have the KVM hypervisor installed, along with a few other tools.

* [kvm-install-vm][1]
* genisoimage or mkisofs
* virt-install
* libguestfs-tools-c
* qemu-img
* libvirt-client

### Setup playbook

An Ansible playbook to install the KVM hypervisor and required tools is
provided in the setup directory. This should be run as a regular user on the
local machine.  The playbook requires roles from Ansible galaxy which are
listed in the requirements file.  The run the playbook:

    $ cd setup
    $ ansible-galaxy install -r requirements.yaml
    $ ansible-playbook virtlab.yaml

After running the play book, log out and and then back in again to join the new
libvirt group.


### Guest hostname resolution

Systemd based systems can be configured to use the local resolver to resolve
guests by hostname instead of needing to ssh to them by IP address.

1. Configure a libvirt network which uses an external nameserver instead if
   local resolution. This is needed to avoid resolution looping between the
   libvirt dnsmasq and the local resolver. Such a network will be configured
   by the setup Ansible playbook in the `setup` directory.

2. Each time guests have been installed, run the `systemd-resolve` command as a
   regular user to set the dns gateway for the virtual bridge. This can be done
   by providing a `postinstall` command in the `virt-lab` configuration file. See
   the `virt-lab.cfg.example` file the `systemd-resolve` command syntax.


## Configuration

| Option     | Description               | Default |
| ---------- | ------------------------- | ------- |
| desc       | lab description           | none |
| autostart  | enable guest autostart    | true |
| bridge     | bridge interface          | virbr0 |
| cpus       | number of cpus            | 1 |
| disksize   | disk size (GB)            | 10 |
| distro     | distro name               | centos7 |
| domain     | DNS domain                | example.com |
| feature    | cpu model / feature       | host |
| gateway    | virtual network gateway   | 192.168.122.1 |
| graphics   | graphics type             | spice |
| image      | custom image (qcow2)      | none |
| images     | number and type of guests | 3 |
| key        | ssh public key            | `$HOME/.ssh/id_rsa.pub` |
| mac        | mac address               | previous value if one, auto-assigned otherwise |
| memory     | memory (MB)               | 1024 |
| namefmt    | guest name format         | `{lab}{guest:02d}` |
| port       | console port              | auto-assigned |
| scriptname | custom command            | none |
| timezone   | timezone name             | US/Eastern |
| user       | additional username       | current login username |
| imagedir   | image directory           | `$HOME/virt/images` |
| vardir     | guest data directory      | `$HOME/virt/var` |
| vmdir      | data directory            | `$HOME/virt/vms` |

## Distributions


| Name            | Description                         | Login    |
| --------------- | ----------------------------------- | -------- |
| amazon2         | Amazon Linux 2                      | ec2-user |
| centos7         | CentOS 7                            | centos   |
| centos7-atomic  | CentOS 7 Atomic Host                | centos   |
| centos6         | CentOS 6                            | centos   |
| debian9         | Debian 9 (Stretch)                  | debian   |
| fedora29        | Fedora 29                           | fedora   |
| fedora29-atomic | Fedora 29 Atomic Host               | fedora   |
| fedora30        | Fedora 30                           | fedora   |
| ubuntu1604      | Ubuntu 16.04 LTS (Xenial Xerus)     | ubuntu   |
| ubuntu1804      | Ubuntu 18.04 LTS (Bionic Beaver)    | ubuntu   |


## Examples

todo


[1]: https://github.com/giovtorres/kvm-install-vm
