# Week 12 homework

`ics0021-selinux-app.service` is a TCP service on `127.0.0.1:8123`. For every
request it must:

1. read the reply prefix from `/etc/ics0021-selinux/response.txt`;
2. append the request to `/var/log/ics0021-selinux/requests.log`;
3. write it to `/var/lib/ics0021-selinux/last-request`;
4. send `PREFIX request=REQUEST` back to the client.

The service also supports `STATE` to read the last request and `LOG TOKEN` to
check whether a request was logged. These commands let the grader verify the
file behavior through the application instead of accessing its protected files.

> The application initially fails because of SELinux. Make the complete behavior work while SELinux is **enforcing**.

The supplied `ics0021_week12_base` module already **defines** the application
domain, executable type, configuration type, log type, state-data type, TCP port
type, file-context mappings, and systemd domain transition. Do not redeclare
these types. Write a separate policy module that *references* them and adds the
permissions the application needs.

> [!NOTE]
> You can also persistently associate the
> supplied port type with TCP port 8123, but this is an **optional** part of the exercise: we will give you full points even if it stays `http_cache_port_t` as long as the application works, because the way to achieve that is a challenge of its own.

Your solution must survive `restorecon` and a service restart.

The readable supplied policy is available under:

```text
/usr/local/src/ics0021-week12/
```

> [!NOTE]
> The setup disables SELinux `dontaudit` rules (read more on it [here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/security-enhanced_linux/sect-security-enhanced_linux-fixing_problems-possible_causes_of_silent_denials)) so normally suppressed application denials are visible during this exercise.
> The policy is still enforced, just logging changes. Because this also exposes unrelated system denials, filter the audit log:
> ```bash
> sudo ausearch -m AVC,USER_AVC -ts recent -c ics0021-selinux
> ```
> The normal `dontaudit` behavior can later be restored with `sudo semodule -B`, do it if you wish to (once you understand the tradeoff, maybe).

> [!IMPORTANT]
> Disabling SELinux, making the application domain permissive, or running the service unconfined does not complete the exercise.

Automated feedback will be written to `/home/UNI_ID/ics0021/12/feedback.txt`.
