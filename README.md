# Repository contents
- This repository contains the configuration for the monitoring machine
- The script consists in a netcat to the port 22 of both machines, if the command returns a code different from 0, we run the playbook of a machine into the backup machine

## How to configure correctly?
1. Make sure that `monitoring_script.sh` is executable running `chmod +x monitoring_script.sh`;
2. Move `monitoring_script.sh` into /bin file;
3. Run `mkdir /sys-adm` and move the ansible inventories and playbook to it: `mv playbook_vm1.yaml playbook_vm2.yaml inventory.ini /sys-adm`
4. Move the `monitoring_script.service` into systemd dir: `mv monitoring_script.service /etc/systemd/system`
5. Move the `monitoring_script_timer.timer` into systemd dir: `mv monitoring_script_timer.timer /etc/systemd/system/`
6. Reload systemd `systemctl daemon-reload`
6. Start the service timer `systemctl enable --now monitoring_script_timer`
    - Because the timer is what is going to run the script, we don't need to enable it
7. (Optional) Check service status `systemctl status monitoring_script monitoring_script_timer`

The timer should run the script every 5 minutes, to change the time, just modify the value under the Timer label inside the `monitoring_script_timer.timer` file
