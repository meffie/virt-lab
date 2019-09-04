#!/bin/bash
set -e
set -x
echo "Running post create script for lab ${VIRTLAB_NAME}"
sudo systemd-resolve --interface ${VIRTLAB_BRIDGE} --set-dns ${VIRTLAB_GATEWAY} --set-domain ${VIRTLAB_DOMAIN}
