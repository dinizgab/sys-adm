#!/bin/bash

MACHINE_1_IP="192.168.1.10"
MACHINE_2_IP="192.168.1.20"
PORT=22

# Send a single ping with a 1 second timeout
#
if ! nc -4 -d -z -w 1 ${MACHINE_1_IP} ${PORT} &> /dev/null; then
    ansible-playbook /sys-adm/playbook_vm1.yaml -i /sys-adm/inventory.ini   
fi

if ! nc -4 -d -z -w 1 ${MACHINE_2_IP} ${PORT} &> /dev/null; then
   ansible-playbook /sys-adm/playbook_vm2.yaml -i /sys-adm/inventory.ini
fi
