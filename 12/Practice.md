# Linux Administration - Week 12 - Practice session

> [!TIP]
> I understand that context switching between projector and own monitor can be stressful,
> so you are more than welcome to just look at the live without doing all steps on your
> VM, there is the homework (and the practice exercise) for that.

## SELinux

- changing contexts
- what happens to contexts when you move and copy files (`cp --preserve=context` and `mv` vs `cp`)
- reading logs with `ausearch` and `sealert`
- checking logs and generating custom policies with `audit2allow`
- making a domain permissive with `semanage permissive`
- setting a boolean with `setsebool`

- checking the status of SELinux with `getenforce` and `sestatus`

- determining the context of files, processes, ports, users with `ls -Z`, `ps -eZ`, `semanage port -l`, `semanage login -l`
- changing the context of files with `restorecon` and `semanage fcontext`
- `/.autorelabel` and the dangers when you have large storage

- creating a custom policy module [with `checkmodule` and `semodule`](https://stackoverflow.com/a/52326925/15888601)

> [!TIP]
> If you wish to use some macros such as `gen_require` and `policy_module`, it won't be enough to use `checkmodule` but you will have to compile with...
>
> ```bash
> make -f /usr/share/selinux/devel/Makefile week12_demo.pp
> ```

- not forgetting `.fc` files ([what is the best way to add/update fcontext rules for many paths?](https://unix.stackexchange.com/a/671618/508535))
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
