# Some handy scripts for Linux (mostly Ubuntu)

### Check basic system info

[check-system.sh](check-system.sh)

### Install some desktop apps

[install-apps.sh](install-apps.sh)

### Enable SSH server

[enable-ssh.sh](enable-ssh.sh)

### Create a list of user accounts

[create-users.sh](create-users.sh)

### Check existing user accounts from a list of machines

[check-users.py](check-users.py)

pre-requisites: `paramiko`, `numpy`

```bash
python3 check-users.py
```

### Setup WPA2 Enterprise Network

-   [setup-wifi.sh](setup-wifi.sh)
-   [setup-wired.sh](setup-wired.sh)

### Clear audit logs on Linux systems

-   This file is used to clear audit logs: [clear-audit-logs.sh](clear-audit-logs.sh)

Install the script to `/usr/local/sbin`:

```bash
sudo install -m 0750 -o root -g root linux/clear-audit-logs.sh /usr/local/sbin/clear-audit-logs.sh
```

Create a cron job to execute the script every day at 4:00 AM:

```bash
sudo crontab -e
```

Add the following line to the cron job:

```bash
0 4 * * * root /usr/local/sbin/clear-audit-logs.sh
```
