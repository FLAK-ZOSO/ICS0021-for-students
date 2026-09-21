# Linux Administration - Week 4 - Practice session

## Inspecting files

Use `file`, `stat`, and `ls -l` to inspect a path. File metadata, including timestamps and ownership, is useful evidence but can be changed by a user with sufficient access.

`chown --from` changes ownership only when the current owner matches the one expected. For example:

```bash
chown --from=lfs -R root:root /mnt/lfs/{var,usr,etc}
```
*Few of you may know where this example comes from*

## File types and `find`

Find examples of the file types from the lecture on your VM and verify them with `ls -l`. For example, symbolic links can be found with `ls -l /usr/bin | grep '^l'`.

Read the `EXPRESSION` section of `man find`, then try the following searches. Think of a command first before looking at its example.

```bash
# Find regular files in /etc writable by everyone:
find /etc -type f -perm -o=w

# Find directories in /tmp with the sticky bit:
find /tmp -type d -perm -1000

# Find files in /usr/bin executable by the owner but not writable by the group:
find /usr/bin -type f -perm -u=x ! -perm -g=w

# Find files under /var owned by root and group-writable:
find /var -type f -user root -perm -g=w

# Find files in /home with exactly mode 0644:
find /home -type f -perm 0644

# Find files where anyone has at least one executable bit:
find /usr/bin -type f -perm /111

# Find files with both setuid and owner-execute set:
find /usr/bin -type f -perm -4100

# Find files not readable by their owner:
find /usr -type f ! -perm -u=r

# Find executable files under /var, but don't search in /var/log and /var/cache:
find /var \( -path /var/log -o -path /var/cache \) -prune -o -type f -perm /111 -print

# Find world-writable files under /usr, but don't search in /usr/share/doc:
find /usr -path /usr/share/doc -prune -o -type f -perm -o=w -print

# Find files owned by a user under /home, but don't search in .cache directories:
find /home -type d -name .cache -prune -o -type f -user USER -print
```

## ACL examples

Create any required users and groups first. Stop after each step and use `getfacl` to inspect the result.

```bash
# Create directory with ACLs
mkdir /tmp/acl_test
setfacl -m u:alice:rwx /tmp/acl_test
setfacl -m u:bob:rx /tmp/acl_test
setfacl -m u:charlie:--- /tmp/acl_test
# View ACLs
getfacl /tmp/acl_test

# Modify ACLs
setfacl -m u:charlie:rx /tmp/acl_test
getfacl /tmp/acl_test

# Remove ACLs
setfacl -x u:charlie /tmp/acl_test
getfacl /tmp/acl_test

# Remove all ACLs and reset to default permissions
setfacl -b /tmp/acl_test
getfacl /tmp/acl_test

# Create a directory with user, group, mask, and other permissions
mkdir /tmp/acl_test2
setfacl -m u:alice:rwx /tmp/acl_test2
setfacl -m g:developers:rx /tmp/acl_test2
setfacl -m m::r-x /tmp/acl_test2
setfacl -m o::--- /tmp/acl_test2
getfacl /tmp/acl_test2

# Create a directory with an access ACL and an inheritable default ACL
mkdir /tmp/acl_test3
setfacl -m u:alice:r-x /tmp/acl_test3
setfacl -d -m u:alice:r-x /tmp/acl_test3

# New entries inherit access ACLs from the directory's default ACL
touch /tmp/acl_test3/inherited_file
mkdir /tmp/acl_test3/inherited_directory
getfacl /tmp/acl_test3
getfacl /tmp/acl_test3/inherited_file
getfacl /tmp/acl_test3/inherited_directory
```

### Lab: Default permissions and group inheritance

Complete this exercise on your course VM:

- create the `operators` group;
- create `operator1` with a home directory and add it to `operators` as a supplementary group;
- open a login shell as `operator1` and inspect its initial `umask`;
- as `operator1`, create `/tmp/shared` and `/tmp/shared/initial.txt`, then inspect their permissions and ownership;
- change `/tmp/shared` to group `operators` and create `/tmp/shared/group-only.txt`: observe that changing the directory's group alone does not make new files inherit it;
- set setgid on `/tmp/shared`, create `/tmp/shared/inherited.txt`, and verify that it now inherits the `operators` group;
- temporarily set `umask 027`, create `/tmp/shared/restricted.txt`, and verify that it has mode `0640`;
- leave the shell, open a fresh login shell as `operator1`, and confirm that the temporary `umask` did not persist;
- configure a persistent `umask 007` for `operator1`, open another fresh login shell, and verify it.

Keep the account, group, directory, and test files in place for automatic checking. Completing all checks earns one classwork point.

## Homework

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
