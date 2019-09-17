# Ansible playbooks for virt-lab

This is a collection of small Ansible playbooks for setting up new guests.
These may be run by `virt-lab` after the guests have been created. You can also
have `virt-lab` run other custom playbooks by specifying them in the
`virt-lab.cfg` file.

## Playbook

* `local_dns.yaml` - Setup local DNS resolution with the systemd resolver
* `wait.yaml` - Wait for systems to become reachable

## Running the playbooks

Playbooks may be run `virt-lab` by setting the `postcreate` option in
`virt-lab.cfg` to run `ansible-playbook` directory, or to run a shell script
which runs `ansible-playbook`.

Use the `scripts/inventory.sh` shell script to generate a dynamic inventory of
the guests created by `virt-lab`. Additional host and group variables can be
provided with additional `ansible-playbook` `-i` options.

### Running ansible-playbook directly.

Setup the `postcreate` option to run `ansible-playbook` and specify the
playbooks you wish to run.  Additional custom playbooks may also be run to
perform setup on the newly created guests. These custom playbooks may be
located in a custom directory.

Example 1:

    [mylab]
    guests = 6
    domain = example.com
    bridge = vlbr0
    gateway = 192.168.123.1
    postcreate = ansible-playbook -i {scriptdir}/inventory.sh
                 {playbookdir}/local-dns.yaml
                 {playbookdir}/wait.yaml

Example 2:

Example running custom playbooks with static host and group variables. The
playbook files and inventory directory are expected to be in the current
working directory in this example.

    [mylab]
    guests = 6
    domain = example.com
    bridge = vlbr0
    gateway = 192.168.123.1
    postcreate = ansible-playbook
                 -i {scriptdir}/inventory.sh
                 -i inventory/mylab
                 {playbookdir}/wait.yaml
                 playbook1.yaml
                 playbook2.yaml

### Running ansible-playbook from a script

Alternatively, you can specify a shell script in the `postcreate` option, which
can run `ansible-playbook` or perform any other logic needed.  A set of
environment variable are created for the script.

Example:

    [mylab]
    guests = 6
    domain = example.com
    bridge = vlbr0
    gateway = 192.168.123.1
    postcreate = mypostcreate.sh

Example script:

    #!/bin/sh
    echo "Running post create script for ${VIRTLAB_NAME}"
    ansible-playbook -i ${VIRTLAB_SCRIPTDIR}/inventory.sh ${VIRTLAB_PLAYBOOKDIR}/wait.yaml
    # Do other tasks here as needed.

## Host groups

Ansible groups can be defined in the `virt-lab.cfg` file for playbooks and
roles. Groups are specified as options in the form `group.<group_name>`. The
value of the group options is a comma separated list of guest numbers. The
first guest is number '1'.  A range of numbers can be specified in the form
`<from>..<to>`. The wildcard `*` is a shortcut to specify all of the guests.

Example:

    [mylab]
    guests = 12
    postcreate = ansible-playbook -i ...
    group.dbserver = 1
    group.webserver = 2,3,4
    group.test_client = 4..8
    group.krb_client = *
