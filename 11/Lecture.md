# Linux Administration - Week 11

## Package management

One of the main differences between Linux distributions is the package manager they use.

Different package formats and package managers exist, such as:
- rpm (Red Hat Package Manager) -> used in RHEL, CentOS, Fedora, Rocky, Alma, (SUSE in a way), etc.
- deb (Debian package) -> used in Debian, Ubuntu, Kali, etc.
- apk (Alpine Package Keeper) -> used in Alpine Linux, which is a lightweight distribution often used in containers
- pacman -> used in Arch Linux, btw

There are tools on top of those formats, such as:
- dnf (Dandified YUM) -> used in RHEL, CentOS, Fedora, Rocky, Alma, etc.
- apt (Advanced Package Tool) -> used in Debian, Ubuntu, Kali, etc.

But also, alternatively, we can use very different formats of packages, such as:
- flatpak -> for desktop applications
- snap -> for desktop applications, but also for server applications, and with a more "containerized" approach
- appimage -> for desktop applications, but with a more "portable" approach

We focus on RPM and **DNF 4 on Rocky Linux 9**, matching the course VMs. DNF 5 has different plugin and configuration interfaces.

### What is in a package?

Conceptually, a package's objective is to provide a way to install, update and remove files. In order to achieve this, a package contains:

- the files to be installed
    - the core software files, which are usually stored in `/usr` and are overwritten during updates
    - configuration files, which are usually stored in `/etc` and are not overwritten the same way during updates, but can be modified by the user
    - documentation files, which are usually stored in `/usr/share/doc` and are not modified by the user
- metadata about the package, such as its name, version, description, dependencies, etc.
- signatures and checksums to verify the integrity and authenticity of the package
- scripts to be executed before or after installation, update or removal (pre/post install/update/remove scripts)

> _Seeing this information on packages, what privilege do you think is the minimum required to install packages?_

> _Can you think of package managers that don't require it? Why do you think that's the case? Where do they install their files?_

The name of the package itself carries some information, such as the name of the software, its version, its release, its architecture, etc.

```
httpd-2.4.57-1.el8.x86_64.rpm
```
*This package is for the httpd software, version 2.4.57, release 1, for RHEL 8, and for the x86_64 architecture*

We can use `rpm` to query the contents of a package, such as its files, its metadata, its scripts, etc.

```bash
rpm -qpl httpd-2.4.57-1.el8.x86_64.rpm
```
*This command lists the files contained in the package*

```bash
rpm -qp --scripts httpd-2.4.57-1.el8.x86_64.rpm
```
*This command lists the scripts contained in the package*

```bash
rpm -qi httpd-2.4.57-1.el8.x86_64.rpm
```
*This command shows the metadata of the package*

```bash
rpm -K httpd-2.4.57-1.el8.x86_64.rpm
```
*This command verifies the signature and the checksums of the package*

### More usage of rpm

```bash
rpm -qa
```
*This command lists all the installed packages*

```bash
rpm -qf /usr/bin/bash
```
*This command shows which package provides the file /usr/bin/bash*

```bash
rpm -ql httpd
```
*This command lists the files installed by the package httpd*

```bash
rpm -q httpd
```
*This command shows the version of the installed package httpd*

RPM checks dependency requirements and rejects operations that would break them, but it does not download missing dependencies from repositories; DNF resolves dependencies and constructs the transaction, and comes with many more features. Querying packages usually needs no root privileges; changing the system package database (cache) does.

```bash
sudo rpm -i httpd-2.4.57-1.el9.x86_64.rpm
```
*Installs this local package only if its dependencies are already satisfied*

```bash
sudo rpm -e httpd
```
*Removes httpd only if doing so does not violate dependency requirements*

<!-- We may want to bring up rpm2cpio -->

### What is a repository?

A repository is a collection of packages that are available for installation. It can be a local directory, a network location, or a remote server.

A repository contains metadata (typically a `repodata` directory) that describes it.

<!-- Show how rpm recovers keys from a repo -->

```bash
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
```
*This command imports the GPG key of the Rocky Linux repository, which is used to verify the packages from that repository*

```bash
dnf config-manager --add-repo https://dl.rockylinux.org/pub/rocky/8/BaseOS/x86_64/os/
```
*This command adds the Rocky Linux BaseOS repository to the system, so that we can install packages from it*

Some repositories are built-in, such as the BaseOS and AppStream repositories of Rocky Linux, but we can add more repositories, such as EPEL (Extra Packages for Enterprise Linux), which contains additional packages that are not available in the official repositories.

We should show that they are stored in `/etc/yum.repos.d/` and in what format.

```bash
dnf repolist --all
ls /etc/yum.repos.d/
```

```bash
dnf install epel-release
```
*This command installs the epel-release package, which contains the configuration for the EPEL repository, so that we can install packages from it*

```bash
sudo dnf install dnf-plugins-core epel-release
sudo dnf config-manager --set-enabled crb
sudo dnf config-manager --set-enabled epel
```
*This command enables the EPEL repository, so that we can install packages from it*

A repository can also be enabled for one command:

```bash
sudo dnf --enablerepo=epel install htop
```

This does not change its persistent setting. If EPEL was already enabled, it remains enabled afterward.

### DNF

DNF is a higher-level tool that uses rpm as its backend, but it also handles dependencies, repositories, and other features.

```bash
sudo dnf upgrade
```
*Upgrades installed packages and resolves the required dependency changes. `dnf update` is an alias.*

Do not confuse this behaviour with that of `apt`, where `update` fetches the available packages from the configured repositories and `upgrade` calculates/performs the actual "transaction".

```bash
dnf makecache --refresh
```
*Refreshes repository metadata without upgrading installed packages*

```bash
dnf list --showduplicates httpd
```
*This command shows the available versions of the httpd package in the repositories*

```bash
sudo dnf install httpd
```
*This command installs the httpd package, and it also installs its dependencies*

```bash
sudo dnf remove httpd
```
*Removes httpd and dependent packages; it may also remove dependencies that are no longer needed.*

Consider that you can force this with `sudo dnf autoremove` and configure the default behaviour by [`clean_requirements_on_remove` in the configuration](https://man7.org/linux/man-pages/man5/dnf.conf.5.html).

```bash
sudo dnf reinstall httpd
```
*This command reinstalls the httpd package, which can be useful if some files are missing or corrupted*

### Streams

A stream is a way to have multiple versions (not strictly sequential, it can be different development branches) of the same software available in the repositories, and to choose which one to install.

Use the available AppStream modules, rather than assuming a vendor repository is installed:

```bash
dnf module list
dnf module list nodejs
dnf module info nodejs
dnf module info --profile nodejs:22
```

On a Rocky 9 course VM, AppStream metadata lists Node.js streams 18, 20, 22, and 24 (these are *versions* of the software). Each offers these profiles:

| Profile | Packages | Purpose |
|---|---|---|
| `common` (default) | `nodejs`, `npm` | Runtime and package manager. |
| `minimal` | `nodejs` | Runtime only. |
| `development` | `nodejs`, `nodejs-devel`, `npm` | Runtime, package manager, and development files. |
| `s2i` | `nodejs`, `nodejs-nodemon`, `npm` | Source-to-Image tooling profile. |

This is for you to understand through an example what a "profile" is: a collection/suite of software for a defined purpose or with a defined set of features (e.g. open source profile vs enterprise closed source profile).

```bash
sudo dnf module enable nodejs:22
sudo dnf module install nodejs:22/common
node --version
npm --version
```

Enabling a stream selects its package content but does not install the application. Installing a profile installs its defined package set (think of it much like a group install); `module install` also enables the specified stream, so the separate enable command above is only needed to demonstrate the distinction.

To demonstrate switching an existing Node.js installation from stream 22 to stream 24:

```bash
sudo dnf module switch-to nodejs:24/common
node --version
npm --version
```

This changes the selected stream, installs the specified profile, and synchronizes (i.e. installs, upgrades, replaces) installed modular packages to the target stream, including required installations, upgrades, or downgrades.

### Version locks

A version lock is a way to prevent a package from being updated to a newer version, by locking it to a specific version.

```bash
sudo dnf install python3-dnf-plugin-versionlock
```

```bash
sudo dnf versionlock add httpd
```
*Locks the installed httpd version (install httpd first).<!-- If it is not installed, the plugin instead resolves available versions.-->*

```bash
dnf versionlock list
```
*This command lists the version locks that are currently in place*

```bash
sudo dnf versionlock delete httpd
```
*This command removes the version lock on the httpd package, so that it can be updated to a newer version*

DNF 4 uses the `python3-dnf-plugin-versionlock` plugin, normally configured through `/etc/dnf/plugins/versionlock.conf` with entries in `/etc/dnf/plugins/versionlock.list`.

> *Can you think of an issue with locking a package?*

There is a similar concept for apt: "pinning", which allows to pin a package to a specific version or to a specific repository, but we will not go into it as we are focusing on the rpm+dnf ecosystem.

### Transactions and history

A transaction is a set of operations that are performed together, such as installing a package and its dependencies, or updating a package and its dependencies.

DNF keeps a history of transactions, which allows to undo them if something goes wrong.

```bash
dnf history
```
*This command shows the history of transactions, with their ID, date, action, and packages involved*

```bash
dnf history info TRANSACTION_ID
```
*This command shows the details of the transaction with the selected ID*

```bash
sudo dnf history undo TRANSACTION_ID
```
*Attempts to reverse the selected package transaction*

Undo requires the necessary package versions to remain available: it is not a filesystem snapshot, it just keeps track of packages and versions.

### What is a group of packages?

A group of packages is a collection of packages that are related to each other, and that can be installed together to provide a specific functionality.

For example, the "development tools" group contains packages that are useful for software development, such as compilers, debuggers, etc.

```bash
dnf group list
```
*This command shows the available groups of packages in the repositories*

```bash
sudo dnf group install "Development Tools"
```
*This command installs the "Development Tools" group of packages: it installs the packages that are part of that group*

### Diagnose before reinstalling

```bash
rpm -V bash                  # Compare installed files against RPM metadata
rpm -qf /usr/bin/bash         # Find the installed owner of a file
dnf provides '*/COMMAND'      # Replace COMMAND with the missing executable
dnf check                    # Check the installed dependency state
```

`rpm -V` reports differences in properties such as file size, digest, permissions, and ownership; no output means no detected differences for the checked files. `dnf reinstall` can restore packaged files, but does not necessarily overwrite locally edited configuration (that behaviour is defined by `%config(noreplace)` or such in the package).

---

## [Practice session](./Practice.md)
