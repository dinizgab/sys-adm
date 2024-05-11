#!/bin/bash

MACHINE_1_IP="192.168.1.3"
MACHINE_2_IP="192.168.1.4"
PORT=22



if ! nc -4 -d -z -w 1 ${MACHINE_1_IP} ${PORT} &> /dev/null; then
    ansible-playbook /sys-adm/playbook_vm1.yaml -i /sys-adm/inventory.ini --ask-become-pass -e "ansible_sudo_pass=aula"

else
    if  ssh aula@${MACHINE_1_IP} 'systemctl is-failed apache2*' ; then
        ansible-playbook /home/aula/sys-adm-master/playbook_vm1.yaml -i /sys-adm/inventory.ini --ask-become-pass -e "ansible_sudo_pass=aula"
    fi
fi

if ! nc -4 -d -z -w 1 ${MACHINE_2_IP} ${PORT} &> /dev/null; then
    ansible-playbook /sys-adm/playbook_vm2.yaml -i /sys-adm/inventory.ini --ask-become-pass -e "ansible_sudo_pass=aula"

else
    if ssh aula@${MACHINE_2_IP} 'systemctl is-failed isc-dhcp-server' ; then
        ansible-playbook /home/aula/sys-adm-master/playbook_vm2.yaml -i /sys-adm/inventory.ini --ask-become-pass -e "ansible_sudo_pass=aula"
    fi
fi
