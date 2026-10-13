# Linux Administration - Week 7 - Practice session

## Logging

### Logging with `logger`

```bash
logger -p info "week7 information"
logger -p err "week7 error"
logger -p 3 "week7 error"
logger -p warn -t test "week7 error"
```
*The default tag is the username*

```bash
journalctl --since "5 minutes ago"
journalctl -p err
journalctl -t test
journalctl -u chronyd
journalctl _COMM=logger
```

Explain [facilities](https://wiki.archlinux.org/title/Systemd/Journal#Facility), where `facility.severity` is the syntax in logger, and mention how [applications use the local ones](https://serverfault.com/questions/115923/which-program-defaults-uses-syslog-local0-7-facilities).

### Routing messages to a file with rsyslog

Create `/etc/rsyslog.d/10-ics0021-week7.conf` with this rule:

```text
local0.*    /var/log/ics0021-week7.log
```

```bash
sudo rsyslogd -N1 # Validates configuration, always do this before reloading/restarting services where possible
sudo systemctl restart rsyslog
logger -p local0.info "Week 7 informational message"
logger -p local0.err "Week 7 error message"
sudo tail /var/log/ics0021-week7.log
```

### Monitoring logs with `journalctl` — attendance option 1

We will initiate some failed login attempts to everyone's VM before the practice session, so that they have some logs to check.

- Check for failed login attempts in journald logs
- How many failed login attempts do you find?
- What information could you gather from the logs? (e.g., source IP, username, timestamp, etc.)
- Write it very briefly in `~/ics0021/07/lab.md`, make sure to include the IP address

### Persistence of logs

Create the drop-in directory with `sudo mkdir -p /etc/systemd/journald.conf.d`, then create `/etc/systemd/journald.conf.d/10-persistent.conf` with:

```ini
[Journal]
Storage=persistent
```

Prepare the persistent journal directory and restart journald:

```bash
sudo mkdir -p /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
sudo journalctl --flush # Flushes runtime journal data to persistent storage
```

Write a recognizable message, reboot, and reconnect:

```bash
logger -t week7-persistence "This message must survive a reboot"
sudo reboot
```

Verify that the previous boot and its message are available:

```bash
journalctl --list-boots
journalctl -b -1 -t week7-persistence
```

### Troubleshooting with logs

A service (`week7-greeter.service`) is broken. Investigate its status and journal messages, determine the cause without being given the solution, repair it, and verify that it starts successfully.

### Log shipping — attendance option 2

Route the `authpriv` facility with level `info` or higher (meaning *higher severity*) to the `ics0021-logs` server, using the port `601/tcp`.
Generate an `authpriv.err` log in order to prove that log shipping works for the facility.

### NTP

```bash
timedatectl
chronyc sources -v
chronyc tracking
```

## Hometask on the VM

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
