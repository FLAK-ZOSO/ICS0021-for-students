# Linux Administration - Week 5

## Bash scripting

- syntax for writing a script (`#!/bin/bash` shebang)
    - curious about `#!/bin/bash` vs `#!/usr/bin/env bash`? [This StackOverflow answer](https://stackoverflow.com/questions/16365130/what-is-the-difference-between-usr-bin-env-bash-and-usr-bin-bash) has a good explanation.
- ask them if they remember how to make it executable
    - `chmod +x script.sh`
- how to run a script (`./script.sh`)
    - explain that the `./` is necessary to run a script in the current directory, because the current directory is not in the `PATH` by default
    - ask why do they think it is the case that the current directory is not in PATH
- using variables in scripts
- using arguments in scripts
  - `$#`, `$@`, `$1`, `$?`
- putting comments in scripts
- using arithmetic operations in scripts
- using conditionals and loops in scripts
- using functions in scripts
- [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/) has theory and exercises on these topics

## Scheduling tasks

### Background processes

We have not yet covered process management, but it is worth mentioning that you can run a command in the background by appending `&` to the end of the command.

It is necessary just so that the scheduling does not sound like dark magic to them.

### `at` command

- syntax for scheduling a one-time task
    - `echo "command" | at time`
- example: `echo "echo 'Hello, world!'" | at 10:00
- checking scheduled tasks with `atq`
- removing scheduled tasks with `atrm`

### `cron` daemon

- usage of `cron`: schedule system maintenance tasks, backups, etc.
- syntax for scheduling recurring tasks
    - `* * * * * command` (minute, hour, day of month, month, day of week)
    - definitely show them some website like [crontab.guru](https://crontab.guru/) or [cron.help](https://cron.help/) to visualize the syntax
- editing the crontab with `crontab -e`
- checking the crontab with `crontab -l`
- where the configurations are stored (`/etc/crontab`, `/etc/cron.d/`, not sure if there is more)

### `anacron` daemon

Always make sure to pause and make them reflect: what could be the limitations of `cron`?
What if the system is not running at the scheduled time? This is where `anacron` comes in.

- usage of `anacron`: schedule tasks that should run at least once a day, but not necessarily at a specific time
- difference between `cron` and `anacron`: `cron` is for tasks that should run at specific times, while `anacron` is for tasks that should run at least once a day, but not necessarily at specific times
- configuration file: `/etc/anacrontab`
- show the syntax of the configuration file and explain the fields (period in days, delay in minutes, job identifier, command)

### Systemd timers

Just mention what they do, we will cover them in the upcoming week.

---

## [Practice session](./Practice.md)
