#!/bin/bash
set -e

case "$1" in
    --list)
        virt-lab list --format=inventory ${VIRTLAB_NAME}
        ;;
    *)
        echo "{}"
        ;;
esac
