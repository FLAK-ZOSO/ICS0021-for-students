# Week 4 homework

Complete all work on your course VM. Replace `UNI_ID` below with your university ID. Store every submission under:

```text
/home/UNI_ID/ics0021/04/
```

Do not remove the planted files, users, or groups. The ownership and ACL scripts must reproduce the submitted state when run again.

## 1. Find the suspicious files

Find the five paths described below:

1. An executable in a temporary memory-backed filesystem whose numeric group has no known group name.
2. A directory directly under `/etc` whose name contains your university ID.
3. A file under `/usr`, but not `/usr/local`, that its owner cannot read.
4. A file directly under `/var` whose name begins with three digits, contains your university ID, and has a five-letter extension.
5. A file under `/usr`, but not `/usr/local`, whose size is at least 1 MiB.

Write exactly the five absolute paths, in any order, one per line starting from the first line, to:

```text
~/ics0021/04/homework-find.txt
```

Do not include a heading, blank first line, explanations, or additional paths.
Push this file to GitLab.

Save the commands used to locate them to:

```text
~/ics0021/04/homework-find.sh
```

Write one `find` command per line in the same order as your paths, starting from the first line. Do not add a shebang, heading, or blank first line. Push this file to GitLab.

## 2. Ownership and permissions

Configure these existing files:

- `/home/UNI_ID/file1` must belong to user `hwuser1` and group `hwgroup1`.
  - Its owner must be able to read and modify it, its group may only read it, and everyone else must have no access.
- `/home/UNI_ID/file2` must belong to user `hwuser2` and group `hwgroup2`.
  - Its owner must be able to read and execute it, its group must have full access, and everyone else must have no access.
- `/home/UNI_ID/file3` must belong to user `hwuser3` and group `hwgroup3`.
  - Everyone must have full access.

Save the commands used in an executable Bash script:

```text
~/ics0021/04/homework-ownership.sh
```

## 3. Access control lists

Add named-user ACL entries to three separate existing files:

- On `/home/UNI_ID/acl-file1`, `hwuser1` and `hwuser2` must have read access, while `hwuser3` must have no access.
- On `/home/UNI_ID/acl-file2`, `hwuser1` and `hwuser3` must have read and write access, while `hwuser2` must have read-only access.
- On `/home/UNI_ID/acl-file3`, `hwuser1` must have read-only access, while `hwuser2` and `hwuser3` must have read and execute access.

Save the commands used in an executable Bash script:

```text
~/ics0021/04/homework-acl.sh
```

## Submission

Commit and push these four files to GitLab:

```text
04/homework-find.txt
04/homework-find.sh
04/homework-ownership.sh
04/homework-acl.sh
```

Also leave the required ownership, permissions, and ACLs active on your course VM.
Automated feedback will be written to `04/feedback.txt` (or in `~/week4-feedback.txt` if you have not yet touched the homework directory).
Consider that, while the state of the VM and the meaningful output (i.e. `04/homework-find.txt`) is automatically assessed, the commands must be there for proof of work and manual assessment where needed.
