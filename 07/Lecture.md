# Linux Administration - Week 7

## NTP

- Why do we need time synchronization?
  - logging synchronization
  - distributed systems
  - security (key rotation, certificate renewal and validation, etc.)
- What is NTP
  - concept of stratum
  - NTP servers and clients
- How to configure NTP (cronyd) on RHEL
  - how to check the status of the service
  - how to check the synchronization status (`chronyc` commands)

We might need to touch the firewall like [here](https://www.redhat.com/en/blog/chrony-time-services-linux), but the lecture on the firewall will be at a later week, at week 10.

## Logging

- Why do we need logging?
  - troubleshooting
  - security monitoring and auditing

- What is syslog and journald
  - syslog: traditional logging system, uses text files, supports various log levels and facilities
  - journald: modern logging system, uses binary format, supports structured logging, better performance
  - journald can forward logs to syslog for compatibility, integration and shipping to centralized logging systems

### Some challenges with logging

The main ones:
- log rotation: log files can grow indefinitely, need to rotate and compress old logs
- log retention: need to keep logs for a certain period of time for compliance and auditing
- log priority: need to filter logs based on severity (noise vs critical)

There is more:
- log forwarding: need to forward logs to centralized logging systems for aggregation and analysis
- log security: need to protect logs from tampering and unauthorized access
- log format: need to have a consistent and structured log format for easier parsing and analysis
- log duplicates: need to handle duplicate log entries
- log flooding: you want to rate limit logs to prevent flooding

### Priority levels - `-p` in `journalctl` and `logger`

The standard levels are:
- 0: emerg (emergency)
- 1: alert
- 2: crit (critical)
- 3: err (error)
- 4: warning
- 5: notice
- 6: info (informational)
- 7: debug

- When writing Bash scripts, we can use the `logger` command to write logs to journald with a specific priority level.

```bash
logger -p local0.info "This is an informational message"
logger -p local0.err "This is an error message"
```

- When reading logs with `journalctl`, we can filter logs based on priority level using the `-p` option.

```bash
journalctl -u <name>.service -p 4
```
*This means we will see logs with severity from warning to emergency*

### Rotation - logrotate

Just what it does: rotates logs, compresses old logs, and removes old logs based on configuration.

- `man logrotate` for configuration
- `logrotate` command to rotate logs manually

Now that we know about signals, explain why [`killall -HUP <service>` is used by RHEL and is in the man page](https://unix.stackexchange.com/a/440015/508535).

### Retention - journald storage

The idea that we can configure journald to use `/var/log/journal` or `/run/log/journal` as storage, 

- `man 5 journald.conf` for configuration, we care about `Storage=`

### Integrity - Forward Secure Sealing (FSS)

[Forward Secure Sealing](https://learn.netdata.cloud/docs/logs-management/systemd-journal-logs/forward-secure-sealing-fss-in-systemd-journal) makes persistent journal files tamper-evident: an auditor with the verification key can detect alterations to sealed history. It does not prevent an attacker from deleting logs, and does not replace sending logs to another machine.

`Seal=yes` is the default, but sealing needs persistent journal storage and an FSS key pair. Generate one with `sudo journalctl --setup-keys`; keep the printed verification key off the VM. Verify later with `sudo journalctl --verify --verify-key=VERIFICATION_KEY`. The sealing key remains on the VM and changes periodically, so compromising it now does not allow rewriting older sealed intervals without detection.

### Forwarding - syslog (syslog, syslog-ng, rsyslog)

We can look into [RFC 5424](https://datatracker.ietf.org/doc/html/rfc5424) and show some schemes from there.

- What rsyslog does
- Shipping logs to a remote server
- Explain how you can do conditional rules (severity, facility, pattern matching)
- `man 5 rsyslog.conf` for configuration; legacy forwarding uses `@server:port` for UDP and `@@server:port` for TCP. The practice uses TCP port 601.

> The others that you see mentioned are compatible implementations of the syslog protocol with extra features; we use rsyslog because it's the default on RHEL and we like it.

### Duplicates and flooding - `RateLimitIntervalSec` and `RateLimitBurst` in journald

When you don't want to be flooded with logs that exhaust resources (mainly compute and storage, but also network capacity when forwarding), you can use these options in `journald.conf` to limit the rate of log messages.

- `RateLimitIntervalSec`: the time window for rate limiting
- `RateLimitBurst`: the maximum number of log messages allowed within the rate limit interval

These options allow us to limit the rate of log messages to prevent flooding and handle duplicates. Crazy knowledge [here](https://www.reddit.com/r/systemd/comments/ddl6ni/ratelimitintervalsec_and_ratelimitburst_usage/) and a useful scheme [here](https://oneuptime.com/blog/post/2026-03-04-journald-rate-limiting-storage-quotas-rhel-9/view).

---

## [Practice session](./Practice.md)
