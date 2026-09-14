# Linux Administration - Week 3

## Users and groups

- what a user is and what a group is
    - identifiers (UID, GID) and names
        - identifiers ranges (system users, regular users, etc.)
    - the concept of ownership (files, processes, etc.) will be covered later, but we can already introduce it here
- how they are stored in the system
    - `/etc/passwd`
    - `/etc/shadow`
    - `/etc/group`
    - use the man pages to show how they can use the documentation to understand the formats of these files
- what the root user is and what the superuser privileges are
    - only mention that it is the user with UID 0 and that it has all privileges, but we will cover privilege escalation later

### Local user and group management commands

- `id` and `groups`
- `useradd` and `groupadd`
- `usermod` and `groupmod`
- `userdel` and `groupdel`

### Authentication and password management commands

- `passwd`
- `chage`
- explain the concept of password aging and expiration, and how modern security guidelines explicitly recommend to avoid them
- explain how local passwords overall are not a good authentication method
    - LDAP + Kerberos
    - SSH keys
    - MFA on SSO
    - Hashicorp Vault

### Pluggable Authentication Modules (PAM)

- explain what PAM is and how it works at a high level, but we won't go into the details of its configuration

### User sessions

- concept of a session
    - different ways of opening a session (console, SSH, graphical login, etc.)
    - intuition of how you can tell which users are currently logged in and what they are doing
- `whoami`
- `who` and `w`
- `last` and `lastb`

## Become, escalation

### Commands

- `su`, don't forget the `-` to switch to the target user's environment
- `sudo`
- `setuid` and `setgid` bits will be covered later

### Configuration

- `/etc/sudoers` file
- `/etc/sudoers.d/` drop-in files and their lexical processing order
- `visudo` command
- matching rules accumulate privileges; when matching rules use conflicting tags such as `PASSWD` and `NOPASSWD`, the tag in the last matching rule applies
- `sudo -l` to inspect the effective permissions for a user

```sudoers
%operators ALL=(ALL) NOPASSWD: ALL
%operators ALL=(ALL) PASSWD: /usr/bin/systemctl restart httpd
```

An `operators` member may still run any command, but the later matching rule requires a password specifically when restarting `httpd`. Therefore, ordering should not be used to “remove” permission granted by an earlier rule.

---

## [Practice session](./Practice.md)
