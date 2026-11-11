# Linux Administration - Week 11 - Practice session

## Package management

### Repository and local RPM walkthrough

Inspect `/etc/yum.repos.d/` and `dnf repolist --all`. See the Rocky 9 EPEL example in [the lecture notes](./Lecture.md#what-is-a-repository).

We compare `sudo dnf install ./PACKAGE.rpm` with `sudo rpm -Uvh ./PACKAGE.rpm`: DNF resolves missing dependencies, while RPM requires them to be satisfied *already*.

### 1. Restore a damaged packaged file

Identify the package owning the affected file, then repair what is broken with your installation of that package.

- http://ftp.rpm.org/max-rpm/s1-rpm-install-additional-options.html

> A user complains that the `figlet "Hello"` command fails... probably someone corrupted some piece of this absolutely fundamental software! Fix it!

### 2. Resolve a missing dependency

Read the failing application's error, then fix it.

> An intern complains about being unable to install `qrencode` for a customer with `rpm -i`, some strange error comes out they say.

The RPM is staged under `/var/lib/ics0021-week11/rpms/`. Try installing that file with `sudo rpm -i`.

Verify that `qrencode -t ANSIUTF8 'Hello'` works. Keep the installed packages for checking.

### 3. Reverse the prepared transaction

Identify the instructor's transaction. Explain what it installed or changed. Undo only that transaction that you are asked to.

> I saw an item in the package installation history... someone installed a silly command line utility, `sl`, and now every time that I mistype "`ls`" (very often) I get mocked by it! Any way that you could cleanly revert the transaction that installed it?

### Walkthrough: inspect an RPM before installing it

As an example we take `qrencode` RPM. These queries need no `sudo` and do not install anything:

```bash
rpm -qip /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -qpl /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -qp --requires /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -qp --scripts /var/lib/ics0021-week11/rpms/qrencode-*.rpm
```

- **Metadata:** identify the name, version, architecture, and description.
- **Payload:** locate the executable, documentation, and other packaged paths.
- **Dependencies:** distinguish package names from capabilities such as shared-library names.
- **Scriptlets:** inspect commands that may run during installation or removal. No output means this RPM has no scriptlets to display.

The `-p` option queries the RPM file; without it, `rpm -q` queries installed packages. Package installation can **execute scriptlets with administrative privileges**, so inspect the package and consider its source before installing it.

#### Dependency terminology

| Category | Examples |
|---|---|
| Build tools | GCC, Make, pkg-config |
| Compile-time dependencies | Headers such as `openssl/crypto.h` |
| Link-time dependencies | `libcrypto.a` or `libcrypto.so` |
| Runtime dependencies | Shared libraries such as `libcrypto.so.3` |

The first three fall under RPM's **`BuildRequires`**; runtime dependencies fall under **`Requires`**.

#### Inspect the actual payload

`rpm -qpl` lists paths; `rpm2cpio` exposes their contents.

```bash
inspection_dir=$(mktemp -d)
cd "$inspection_dir"
rpm2cpio /var/lib/ics0021-week11/rpms/qrencode-*.rpm |
    cpio -idmv --no-absolute-filenames

file usr/bin/qrencode
readelf -d usr/bin/qrencode
```
*This snipped may require you to install some software, but you should now know how to!*

Find the ELF `NEEDED` entries in `readelf` output and compare them with `rpm -qp --requires`.

> Which shared library explains task 2's installation error?

#### More package metadata

```bash
rpm -qp --provides /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -qp --configfiles /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -q --configfiles httpd
rpm -qp --dump /var/lib/ics0021-week11/rpms/qrencode-*.rpm
rpm -K /var/lib/ics0021-week11/rpms/qrencode-*.rpm
```

These show provided capabilities, configuration paths (if any), detailed file metadata, and signature/digest verification. A valid signature establishes the signing key (that you trusted!), not whether you should trust its owner.

### On removal and caching

With DNF 4's default `keepcache=False`, downloaded RPMs are not retained after successful transactions. Reinstalling a removed package may require downloading the RPM again; it can fail if the required version is no longer available (e.g. repository downtime, obsolete package removal, network connection issues, ...).

```ini
# /etc/dnf/dnf.conf
[main]
keepcache=True
```

Remember that `dnf clean packages` can still clear cached RPMs.

## Attendance point — 1 point

Complete **any two of the three exercises** to earn **1 attendance point**. Leave the repaired packages and resulting package history on the VM.

Feedback: `~/ics0021/11/lab-feedback.txt`, or `~/week11-lab-feedback.txt` if the directory does not exist.

## Hometask on the VM

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
