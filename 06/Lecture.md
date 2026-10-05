# Linux Administration - Week 6

## Process

Try to define a process.

> _A process is a running instance of a program._

What else a process has that is not implied by its program?

- resources
    - one or more threads executing the program
    - a memory stack for each thread
    - allocated file descriptors
    - used sockets, network ports
- attributes
    - security context (relevant for SELinux)
    - a process state
    - [environment variables](https://www.man7.org/linux/man-pages/man7/environ.7.html)
    - current working directory ([cwd](https://www.man7.org/linux/man-pages/man5/proc_pid_cwd.5.html))

### Process states

Inspect process states and flags with `ps` and its manual page.

### Useful commands

Inspect a process on your VM. Replace `1` with another PID to inspect that process instead:

```bash
ls /proc/1
```

The practice session asks you to investigate processes. Use `man ps` to find how to...

- show only processes in the running state
- hierarchical representation (`--forest`)

Also try `pstree`.

### Background processes / jobs

- how to start a process in the background
- how to call it back to the foreground
- how to kill them

## Signals

Use `man 7 signal` to find what signal 28 means on your VM. Signal numbers can differ between architectures, so prefer signal names in commands and scripts.

Compare the effects of `SIGTERM`, `SIGKILL`, `SIGSTOP`, and `SIGCONT`.

### Useful commands

Commands for sending signals:

- `kill`
- `pkill`
- `killall`

## Daemons and Systemd

A daemon is a background process that provides a service, often managed by systemd. An ordinary shell job running in the background is not necessarily a daemon.

Systemd units are not limited to services: see `man systemd.unit`.

### States

Inspect the states of some services and find out...

- how to check them
- how to manipulate them (enable, start, restart, reload, stop, ...)
- how masking prevents a unit from being started manually or as a dependency

### Inspecting units

```bash
systemctl cat sshd.service
```

For a unit you are allowed to modify, `sudo systemctl edit UNIT.service` creates a drop-in override. `sudo systemctl edit --full UNIT.service` opens a full replacement. Replace `UNIT` with the actual unit name.

Compare the parts of a unit that control...

- dependencies (`Wants=` and `Requires=`) and ordering (`After=`)
- standard output and standard error

### Systemd timers

A timer normally activates a corresponding service: the timer defines *when* work runs, while the service defines *what* runs. The example below assumes an `example-report.service` unit exists.

```ini
# /etc/systemd/system/example-report.timer
[Unit]
Description=Run the example report every five minutes

[Timer]
OnBootSec=5min
OnUnitActiveSec=5min
Unit=example-report.service

[Install]
WantedBy=timers.target
```

> *When do you think a crontab job is preferred over a systemd timer?*

Cron and systemd timers both support calendar schedules. Systemd timers also support intervals relative to boot or the previous run and integrate with service units and the journal. A timer won't start a service that is already started.

Systemd does not automatically notice newly created or changed unit files.
After editing a unit file, reload its unit definitions before starting or restarting the affected unit:

```bash
sudo systemctl daemon-reload
```

Why might systemd require an explicit reload instead of watching every unit file for changes? Read [this explanation](https://www.reddit.com/r/systemd/comments/1l3k30b/can_anyone_explain_why_daemonreload_isnt/) if curious.

## Per-user services

You can also inspect services managed by your user session:

```bash
systemctl --user list-units --type=service
```

Use `systemctl --user start UNIT.service` and `systemctl --user status UNIT.service` for a user service you have installed.

### Diagnostics with `journalctl`

Systemd services normally send their output to journald by default.

Use `journalctl -u sshd.service` to see one service's messages and `journalctl -u sshd.service -p warning` to filter by priority.

---

## [Practice session](./Practice.md)
