#!/bin/bash
set -e
set -x

echo "Running post-create script for lab ${VIRTLAB_NAME}."

# Resolve the guest names with libvirt's dnsmasq. Note: The libvirt network
# must be setup to use a remote name resolver to avoid resolver loops.
echo "Set virtual dns server"
sudo systemd-resolve --interface ${VIRTLAB_BRIDGE} --set-dns ${VIRTLAB_GATEWAY} --set-domain ${VIRTLAB_DOMAIN}

echo "Wait for guests to start"
ansible-playbook -i ${VIRTLAB_SCRIPTDIR}/inventory.sh ${VIRTLAB_PLAYBOOKDIR}/wait.yaml
