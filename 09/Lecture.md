# Linux Administration - Week 9

## Advanced SSH client

### Reviewing the basics

- how to specify username and host
- inline command specification (`ssh user@host 'whoami'`)
- verbose output for troubleshooting (`-vvv` or `-G`)
- agent and forwarding it
    - adding to the agent, removing from the agent, start the agent
- jump host
- creating a key
- copying a key over

Consider that you as a student have been doing many of these for months now,
so the lecture will likely skip quickly over some of those.

### Client configuration

- `man ssh_config`
    - `~/.ssh/config` and `/etc/ssh/ssh_config`
- those are roughly the same options that you can specify from the command line
- how to add hosts

Show some options.

- `StrictHostKeyChecking`
- `HashKnownHosts` (with the [annoyances it brings](https://superuser.com/questions/30087/remove-key-from-known-hosts))

## SSH server

Some hardening guide...

- discuss changing ports, but keep port 22 on course VMs
- no empty passwords
- no login from root
- login only from specified users (`AllowUsers`): preserve the student and `rocky` accounts
- login only from specified groups (`AllowGroups`): verify membership for both accounts
- `/sbin/nologin` as an individual account's login shell; `/etc/nologin` is a system-wide login restriction, not a per-account setting
- protocol version 2 ([default today](https://serverfault.com/questions/1105685/should-i-add-protocol-2-to-my-sshd-config))
- client timeout

> A listening address belongs to the server; it does not specify allowed clients. `192.168.42.0` is the network address, not your VM's address, and binding to it can prevent SSH from starting.

There are also some extra possibilities that we will only namedrop...
- [2FA for SSH](https://www.linode.com/docs/guides/secure-ssh-access-with-2fa/)
- Fail2Ban
- anything else that a classmate is brave enough to mention

## Archive and transfer files

Consider compressing before large things across different filesystems and especially machines, or you may be just wasting time and bandwidth! Similarly goes with storage.

### Compressing files

Our best ally, widely available, is `tar`. We commonly use the "gzip" format, specified with `-z`.

```bash
tar -czf compressed.tar.gz ~/large_files
```
_"Create ze file"_

```bash
tar -xzf compressed.tar.gz
```
_"Extract ze file"_

Realistically you [won't remember by heart any other command line options](https://xkcd.com/1168/), just use `man tar` or a search engine any time for the rest.

`gzip`, `bzip2` and `xz` also likely exist on your system.

Consider that a `.tar` file is just an uncompressed archive file: it doesn't really save space, it just bundles files together.

Always keep in mind the risk of handling [zip bombs](https://en.wikipedia.org/wiki/Zip_bomb).

### Detour: inodes, copying, moving, archiving, hard links, symbolic links

Just listen to rainer on this one.

### `rsync`

- remember the annoying trailing slash case
