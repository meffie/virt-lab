#!/bin/bash
# Ansible dynamic inventory script wrapper for virt-lab.
set -e
case "$1" in
    --list)
        virt-lab inventory ${VIRTLAB_NAME}
        ;;
    --host)
        echo "{}"
        ;;
    *)
        echo "inventory.sh; unexpected argument: $1"
        exit 1
        ;;
esac
