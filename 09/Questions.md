# Linux Administration - Week 9 - Questions

- Explain the difference between `~/.ssh/config` and `/etc/ssh/ssh_config`
<!-- - What additional information does `ssh -vvv` provide when troubleshooting a connection? -->
- What is the purpose of `ssh-agent`, and what does agent forwarding allow a remote host to do?
- What problem does `ProxyJump` solve?
- What is the difference between a user's public key, private key, and a server's host key?
- What is the purpose of `known_hosts`, and when is a changed host-key warning expected?
- What does <!-- do local, remote, and dynamic --> local SSH port forwarding provide?
- Why should compatibility options for obsolete host-key or key-exchange algorithms be scoped to one host rather than configured globally?
- Briefly comment the contents of an `~/.ssh/config` file.

```sh
# Normal jump host using modern SSH defaults.
Host router-gateway
    HostName gateway.example.org
    User admin
    IdentityFile ~/.ssh/router_admin

# Compatibility exception for one legacy router.
Host old-router
    HostName 192.0.2.10
    User admin
    Port 22
    ProxyJump router-gateway
    IdentityFile ~/.ssh/router_admin
    HostKeyAlgorithms +ssh-rsa
    KexAlgorithms +diffie-hellman-group14-sha256
```
*One such configuration*

- Explain the practical difference between `AllowUsers`/`AllowGroups`, and `/etc/nologin`.
- Why is disabling direct root login useful even when administrators can use `sudo`?
- What is the difference between a tar archive and a gzip-compressed tar archive?
- Why can archiving many files before transferring them improve performance even without compression?
- What is the difference between copying and moving a file within one filesystem? What changes when the destination is on another filesystem?
- Compare how ordinary `cp` and `cp -a` handle symbolic links and hard-link relationships.
- What does the trailing slash on a source directory change in `rsync`?
<!-- With trailing slash it copies the directory contents, without it nests the directory -->
- Why is enabling rsync compression usually unhelpful for files that are already compressed?

---

Remember that often a good answer doesn't have to be boolean, it may just be a concise explanation to prove your understanding of the topic.

> *Yes, I don't know why tho*

The previous is a considerably worse answer than the following.

> *I am unsure: I know that archiving transfers the computational burden of the filesystem to a monolithic, static file, however I also believe the bandwidth to be a more common bottleneck for this scenario.*

This answer is admittedly beyond the expectations that I have, but you are still expected to show some reasoning on top of the notions given in class; the alternative would be grading your ability to memorize command options. What matters the most is not the answer but how you get to it.
