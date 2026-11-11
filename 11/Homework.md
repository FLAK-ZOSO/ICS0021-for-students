# Week 11 homework

## Package the permissions script

Build a Rocky Linux 9-compatible `noarch` RPM containing your[1] week 5 permissions script, an example configuration, and a systemd service and timer.

[1] if you did not complete the week 5 homework, worry not: you can copy the concise solution displayed during the week 7 practice as long as it is just for this purpose.

The RPM must install:

| Path | Requirement |
|---|---|
| `/usr/libexec/ics0021-permissions.sh` | Executable Bash script accepting a permissions file and target directory as arguments. |
| `/etc/ics0021-permissions.conf` | Valid `filename mode` entries; marked as a configuration file to be honoured by the package manager, mode `0644`. |
| `/usr/lib/systemd/system/ics0021-permissions.service` | Valid unit that runs the command below and finishes successfully; mode `0644`. |
| `/usr/lib/systemd/system/ics0021-permissions.timer` | Valid timer that runs the service every minute, can be enabled under `timers.target`, and has mode `0644`. |

The service must execute exactly:

```bash
/usr/libexec/ics0021-permissions.sh /etc/ics0021-permissions.conf /var/lib/ics0021-permissions/files
```

The script must apply the configured permissions to files in the target directory. Declare the package's runtime dependencies, because they may be there in your VM but not in my testing containers.

### Tips and guides

- think what would happen if the accuracy of your timer was off: you should probably use `AccuracySec` for the timer, while alternative solutions are welcome
- `rpm` is overwriting your configuration file each time? `%config(noreplace)` is your friend
- your service does not come already enabled? Check out what `%systemd_post` does.

See the [RPM-building guides](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/packaging_and_distributing_software/index) and [`rpm-packaging-guide.github.io`](https://rpm-packaging-guide.github.io/); the latter is way more verbose and towards the end spaces way outside the scope of this course.

## Submission and grading

Place **exactly one** `*.noarch.rpm` in `~/ics0021/11/` on your course VM. Installation on your VM is not required: the grader installs the RPM in a fresh Rocky 9 container and supplies test configuration and target files.

**5 points**, one each for: an installable `noarch` RPM; required files and configuration metadata; correct permissions within 95 seconds; successful service execution through the timer; and a timer that validates, enables, and starts.

Feedback: `~/ics0021/11/feedback.txt`, or `~/week11-feedback.txt` if the homework directory does not exist.
