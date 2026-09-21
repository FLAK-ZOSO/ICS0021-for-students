# Linux Administration — Week 4

## Files and permissions

Linux represents much of the system through files: ordinary data, directories, devices, sockets, and communication channels all have a path and can be inspected with `ls -l`.

| Type | First character in `ls -l` | Meaning |
| --- | --- | --- |
| Regular file | `-` | Text, data, or a program. |
| Directory | `d` | Names that refer to files and directories. |
| Symbolic link | `l` | A path referring to another file or directory. |
| Block device | `b` | Block-oriented device, such as a disk. |
| Character device | `c` | Stream-oriented device, such as a terminal. |
| Socket | `s` | Inter-process or network communication endpoint. |
| Named pipe | `p` | One-way communication channel between processes. |

### Read, write, and execute

Permissions are evaluated separately for the file owner (`u`), owning group (`g`), and everyone else (`o`). For a regular file, `r` permits reading its contents, `w` modifying it, and `x` executing it as a program.

Directory permissions mean something slightly different:

| Permission | On a directory |
| --- | --- |
| `r` | List its names. |
| `w` | Create, remove, or rename names in it. |
| `x` | Traverse it: access an entry in it or `cd` into it. |

For example, `rwxr-xr--` is owner `rwx`, group `r-x`, other `r--`; the same mode in octal is `754`.

Use `chmod` to change modes, `chown` to change owner and optionally group, and `chgrp` to change only group:

```bash
chmod u=rw,g=r,o= report.txt
chmod 640 report.txt
chown alice:research report.txt
chgrp research report.txt
```

### Special permissions

Special bits are uncommon enough that looking up their exact syntax is normal, but common enough to recognise when reading a mode or an `ls -l` listing.

| Bit | Typical use | Symbolic form |
| --- | --- | --- |
| setuid | An executable runs with the file owner's effective identity. | `u+s` |
| setgid | On a directory, new entries inherit its group. | `g+s` |
| sticky | In a shared writable directory, users can remove or rename only their own files. | `o+t` |

For example, `/tmp` is normally world-writable and sticky. A setgid directory is useful for a collaborative group directory. In octal notation these bits occupy a leading digit: setuid `4`, setgid `2`, sticky `1`.

## Default permissions and `umask`

Programs normally request mode `666` for new regular files and `777` for new directories; the `umask` removes permissions from that request. With `umask 027`, a typical new file is `640` and a typical new directory is `750`. Programs may still request a more restrictive mode themselves.

Inspect the current shell's mask with:

```bash
umask
```

Changing it with `umask 027` affects only that shell and its children. Put an appropriate setting in a login or shell configuration file when it must persist for an account; verify it in a fresh login shell.

## Filesystem hierarchy

The [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html) gives Linux systems predictable locations for programs, configuration, data, and virtual kernel interfaces.

```text
/
├── etc/      system and application configuration
├── home/     regular users' home directories
├── root/     root's home directory
├── usr/      most installed programs, libraries, and shared data
├── var/      changing data: logs, caches, queues, databases
├── tmp/      temporary files
├── run/      runtime state since boot
├── dev/      device files; dev/shm is shared-memory tmpfs
├── proc/     process and kernel information supplied by the kernel
└── sys/      hardware and kernel subsystem information supplied by the kernel
```

On current Rocky Linux, `/bin` and `/sbin` are compatibility links into `/usr/bin` and `/usr/sbin`. `tmpfs` such as `/dev/shm` stores its contents in memory, but the kernel may swap its pages if swap is available.

## Finding files

`find` walks a directory tree and selects paths based on properties such as name, type, size, owner, and permissions. Start with a specific search root whenever possible:

```bash
find /etc -type f -name '*.conf'
find /usr/bin -type f -perm -u=s
find /var/log -type f -size +10M
```

`locate` searches a database built by `updatedb`, so it is fast but may not reflect very recent changes and does not inspect permissions as it searches.

## Access control lists

Traditional permissions give one set of permissions to the owner, one group, and everyone else. An Access Control List (ACL) can add named users and groups:

```bash
getfacl report.txt
setfacl -m u:grace:r report.txt
setfacl -m g:reviewers:rx shared-directory
```

The ACL mask limits the effective permissions of named users, named groups, and the owning group. Check it with `getfacl`: an ACL entry may say `rwx` while its effective permission is lower because of the mask.

Directories can also have a default ACL. New children inherit entries from the directory's `default:` ACL; existing children are unchanged. ACLs are useful where normal owner/group/other permissions cannot express the policy, but a well-chosen group and setgid directory are usually simpler.

Useful references: `man acl`, `man setfacl`, and [Red Hat's ACL overview](https://www.redhat.com/en/blog/linux-access-control-lists).

---

## [Practice session](./Practice.md)
