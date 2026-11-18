# Linux Administration - Week 12 - Practice session

> [!TIP]
> I understand that context switching between projector and own monitor can be stressful,
> so you are more than welcome to just look at the live without doing all steps on your
> VM, there is the homework (and the practice exercise) for that.

## SELinux

- checking the status of SELinux with `getenforce` and `sestatus`

```bash
getenforce
sestatus
cat /etc/selinux/config
```
*Checking the status of SELinux*

- changing contexts (see last slide)

```bash
# Ephemeral change, useful to verify functionality
sudo chcon -R -t httpd_sys_content_t /srv/week12-web

# Verifying the label that, by policy or semanage overwrite, belongs to a file
matchpathcon /srv/week12-web/index.html
# Restoring said label
sudo restorecon -Rv /srv/week12-web
```

```bash
# All the local customizations ("semanage overwrites" informally)
sudo semanage fcontext -l -C
```

- what happens to contexts when you move and copy files (`cp --preserve=context` and `mv` vs `cp`)
- reading logs with `ausearch` and `sealert`

```bash
sudo ausearch -m AVC,USER_AVC -c httpd --raw
sudo ausearch -m AVC,USER_AVC -c httpd
```

```bash
sealert -l 9689286e-f324-44a7-81e7-fee6395dd27d
```
*Arguably the best human readability and extrapolated detail amount*

- checking logs and generating custom policies with `audit2allow`

```bash
# This will output both a compiled .pp and a human readable .te
sudo ausearch -m AVC,USER_AVC -c httpd --raw | audit2allow -M mypolicymodule
# Note that this is not a CLEAN solution: it will never create types for you,
# it is an "allow all" automation, not a detection engineer ;)
```

- making a domain permissive with `semanage permissive`
- setting a boolean with `setsebool`

- determining the context of files, processes, ports, users with

```bash
ls -Z
ps -eZ
semanage port -l
semanage login -l
seinfo -r
```

- changing the context of files with `restorecon` and `semanage fcontext`
- `/.autorelabel` and the dangers when you have large storage

- creating a custom policy module [with `checkmodule` and `semodule`](https://stackoverflow.com/a/52326925/15888601)

```bash
checkmodule -M -m -o mypolicymodule.mod mypolicymodule.te
semodule_package -o mypolicymodule.pp -m mypolicymodule.mod -f mypolicymodule.fc
sudo semodule -i mypolicymodule.pp
```

> [!TIP]
> If you wish to use some macros such as `gen_require` and `policy_module`, it won't be enough to use `checkmodule` but you will have to compile with...
>
> ```bash
> make -f /usr/share/selinux/devel/Makefile week12_demo.pp
> ```

```te
module my-httpd 1.0;

require {
	type httpd_t;
	type var_t;
	class file getattr;
}

#============= httpd_t ==============
allow httpd_t var_t:file getattr;
```
*"type", "class", "domain", "module": all good vocabulary to keep in mind*

- not forgetting `.fc` files ([what is the best way to add/update fcontext rules for many paths?](https://unix.stackexchange.com/a/671618/508535))

```fc
/home/mmarch/list_of_exam_tasks.txt -- sysadm_u:sysadm_r:week16_giga_secret_content_t:s0
```

- checking the policy with `seinfo` and `sesearch`

### Practice exercise — 1 point

Declare a new SELinux file type and assign it to `/srv/week12-web/policy.txt`.

- `http://127.0.0.1:18081/policy.txt` returns HTTP 403.
- `http://127.0.0.1:18081/index.html` returns HTTP 200.

> [!WARNING]
> Consider that forgetting some domain as permissive before the end of the lab session
> may leave `policy.txt` readable.

> *Do you need to create a policy rule in order for `httpd_t` to not be able to read this new type?*

## Hometask on the VM

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
