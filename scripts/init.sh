#!/bin/bash
set -e
set -x
echo "Set virtual dns server for ${VIRTLAB_NAME}."
sudo systemd-resolve --interface ${VIRTLAB_BRIDGE} --set-dns ${VIRTLAB_GATEWAY} --set-domain ${VIRTLAB_DOMAIN}
