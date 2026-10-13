# Week 7 homework

Complete the following tasks on your course VM.

Note: as always, I will initialize the homework briefly after the practice.

## NTP

The VM's built-in NTP configuration has been damaged. Configure `chronyd` to use the `0.pool.ntp.org` server pool.

Ensure that `chronyd` is running, enabled at boot, and successfully synchronized.

## Log rotation

Create `/etc/logrotate.d/firewalld` to rotate a firewalld log stored under `/var/log/firewalld/`. Ensure that the log directory exists.

The configuration must...

- rotate the log daily
- retain seven rotations
- compress rotated logs
- tolerate a missing log without an error
- avoid rotating an empty log
- send the just-rotated log to any non-empty email recipient address
- contain valid logrotate syntax

Leave `/etc/logrotate.d/firewalld` and the log directory on the VM for automatic checking.

## Grading

The homework is worth 6 points: 2 for NTP and 4 for log rotation. Automated feedback will be written to `~/ics0021/07/feedback.txt`, or to `~/week7-feedback.txt` if the homework directory does not exist.
