# Linux Administration - Week 12

## SELinux

- discretionary access control (DAC) vs mandatory access control (MAC)
    - DAC refers to "owner of resource defines permissions"
    - MAC refers to "centrally enforced permissions"
    - UNIX-style permissions are always checked first, then SELinux is checked on top of that
- whitelisting vs blacklisting, SELinux whitelists
- AppArmor is the Debian world equivalent, more (all) LSMs are listed [here](https://github.com/torvalds/linux/tree/master/security)

### Advantages

- granularity of permissions on type of action (as opposed to rwx)
- granularity of permissions from subjects to objects
- not bypassable by root or "owner" of the resource
- better auditing and logging for permissions denials
- can provide debugging help when developing an application, because you see if it does something unexpected by the developer

### Some attacks that it is precious against...

- DNS malicious dynamic record ingestion `allow-update` is open
- path traversal on Web servers
- a lot of memory page writing attacks

### Architecture

The slides display [this image](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhRuXTy8Iaok6wzQ2kw9cx_f_GAhyphenhyphenj_WtBRybcIWLk3OcK8c1yXm9H1lPI9EXZyQ012z2w5zWKXnw4LFP0MhEMpUb3LCCRGOUd86PZ-zMNv1lgJ-vKY8uD-uRIUgybXyxLh7TCTf2J_VVQ/s1600/figure1.gif) from [this blog article](https://www.nu11secur1ty.com/2016/09/anatomy-of-security-enhanced-linux.html). Also [this](https://github.com/SELinuxProject/selinux-notebook/blob/main/src/core_components.md) can do, but it is more scary, it goes into detail that is out of our interest, and is slightly outdated on some internals.

### Terms

The [RedHat Docs](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/using_selinux/getting-started-with-selinux) are a good starting point. If you want entertainment too, there is the [coloring book](https://people.redhat.com/duffy/selinux/selinux-coloring-book_A4-Stapled.pdf).

> _May `<subject>` do `<action>` to `<object>`?, for example: May a web server access files in users' home directories?_

<!-- This will take a lot of the lecture -->

- subject: the process that is trying to do something, for example the web server process
- object: the resource that the process is trying to access, for example the files in users
- action: the type of access that the process is trying to do, for example read or write, but also more specific actions such as "bind to a port" or "transition to a domain"

<!-- One slide here -->

- type: the label that is assigned to both subjects and objects, for example `httpd_t` for the web server process and `home_t` for the files in users' home directories
- context: the combination of user, role, type and level that is assigned to a subject or object, for example `system_u:system_r:httpd_t:s0` for the web server process (represented as a "label")
- policy: the **set of** rules that defines which types can access which other types and with which actions, for example a rule that allows `httpd_t` to read `home_t`
- domain: a type that is assigned to a process, for example `httpd_t` for the web server process (`ps axZ` to see the context of processes)

<!-- One slide here -->

- boolean: a toggle that can be used to enable or disable a set of rules, for example a boolean that allows the web server to access the network (`httpd_can_network_connect`)
- module: a set of rules that can be loaded and unloaded from the policy, for example a module that allows a custom application to access a specific resource

While we don't expect you to be able to define all these concepts by heart, but you should be familiar with them by the practice or nothing will make sense.

- user: such as `sysadm_u`, `xguest_u`, `user_u`
  - list them with `selinux -u`
  - on confined and unconfined users [here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/sect-Security-Enhanced_Linux-Targeted_Policy-Confined_and_Unconfined_Users)
- role: such as `webadm_r`, `dbadm_r`, and `secadm_r`
  - list them with `selinux -r`

### System policies

Generally a system will come with multiple policies to choose from; only one will be the *active* (actively enforced) one at one given time.

Most often, you will be running with the `targeted` policy.

> [!WARNING]
> Consider that [`Gentoo Wiki - Selinux/Policy store`](https://wiki.gentoo.org/wiki/SELinux/Policy_store#Active_policy_store) is a good source but has a very outdated and narrow definition for what the targeted policy actually is, and I had no permission to edit it. Consider it rather as a *"strict policy that allows for unconfined domains/users/..."*.

### MLS/MCS

> [!WARNING]
> These systems *exist* but they are unused in the policies by default in many distributions.
> You can enable them by selecting the proper policy store as the active one. [`[source]`](https://wiki.gentoo.org/wiki/SELinux/Policy_store#Active_policy_store)

> [!NOTE]
> By default you can choose MLS *or* MCS, not both policies. This does not mean that some MCS or MLS functionality cannot have been included directly in the targeted policy.

These two are not commonly used outside RHEL products (OpenShift, containers, privileged ports, etc.), but we want to take the chance to get through the core concepts of MCS and MLS, as well as not gatekeeping what those `s0` and `c0.c1023` things are as you will see them around a lot.

> Multi Level Security (MLS) and Multi Categories Security (MCS)

In MLS, the system is based on clearance levels like in the army (unclassified, confidential, secret, top secret). The policy is based on the Bell-LaPadula model (no read up, no write down) but with _write equality_ (no write up).

> If you see `s0` or any `sx` where `x` is a number between 0 and 15, it's MLS.

In MCS, the system is based on categories that can be assigned to subjects and objects.

> _So you could have c0 for HR data and c1 for Financial data. If a user is running with categories c0 and c1 then they can read HR data and write it to a file labeled for Financial data._
> ([Wikipedia - Multi Categories Security](https://en.wikipedia.org/wiki/Multi_categories_security))

A similar example is in the slides.

> If you see `c0.c1023` or any `cx.cy` where `x` and `y` are numbers between 0 and 1023, it's MCS.

In the docs [here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/using_selinux/using-multi-category-security-mcs-for-data-confidentiality#mcs_within_multi_level_security_mls) is shown how they can be used together. The table very well summarizes this section.

### Enforcement modes

- enforcing
- permissive
- disabled

Permissive mode is valuable for debugging and for gradually enforcing a policy on an existing system, or for developing a policy for a new application.

> [!NOTE]
> Why would it help developing a policy for a new application better than enforcing mode? Because the enforcing mode will stop the application at the first violation, before it can go forward and commit more.

```bash
getenforce
sestatus
```

```bash
setenforce 1
setenforce 0
```

In `/etc/selinux/config`, `SELINUX=enforcing` is the default.

<!-- When we do the boot labs, one could be about disabling SELinux because the policies prevent boot! -->

From the bootloader, boot `linux` (or `linuxefi`) with...

- `enforcing=0`: permissive for this boot; useful for troubleshooting boot failures.
- `selinux=0`: fully disable SELinux for this boot; no SELinux enforcement, but also no labeling and no audit logs.

To persistently disable it on RHEL 9, use `sudo grubby --update-kernel ALL --args selinux=0` and reboot. More on this on week 14.

### Labeling

The contexts can be changed either temporarily or from the policy. More on this in the slides and in the practice session.

### Notes

- a typical unconfined login process has context `unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023` (inspect with `id -Z`)
- for a file context would often be `system_u:object_r:default_t:s0`
- the contexts are not path based but rather inode based
- SELinux policies are the baseline of your system, just as the default firewall rules are in networking

---

## [Practice session](./Practice.md)
