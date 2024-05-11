#!/bin/bash

MACHINE_1_IP="192.168.1.10"
MACHINE_2_IP="192.168.1.20"

if ! nc -4 -d -z -w 1 ${MACHINE_1_IP} ${PORT} &> /dev/null; then
    ansible-playbook /sys-adm/playbook_vm1.yaml -i /sys-adm/inventory.ini
else
    if [$(ssh aula@${MACHINE_1_IP} 'systemctl is-failed apache2*') -ne 'active' ]; then
        ansible-playbook /home/aula/sys-adm-master/playbook_vm1.yaml -i /sys-adm/inventory.ini
    fi
fi

if ! nc -4 -d -z -w 1 ${MACHINE_2_IP} ${PORT} &> /dev/null; then
    ansible-playbook /sys-adm/playbook_vm2.yaml -i /sys-adm/inventory.ini
else
    if [ $(ssh aula@${MACHINE_2_IP} 'systemctl is-failed isc-dhcp-server') -ne 'active' ]; then
        ansible-playbook /home/aula/sys-adm-master/playbook_vm2.yaml -i /sys-adm/inventory.ini
    fi
fi
