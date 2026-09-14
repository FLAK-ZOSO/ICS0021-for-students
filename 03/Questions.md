# Linux Administration - Week 3 - Questions

- What is the difference between a user's primary group and supplementary groups? Know how to inspect them.
- What information is stored in `/etc/passwd`, `/etc/shadow`, and `/etc/group`? Why is password information kept separately?
- Why might a service need a user account even though no person logs in with it? What clue(s) would you inspect to distinguish a service account from a regular user’s account?
- What is the difference between password expiration and account expiration?
- What do `whoami`, `who`, and `w` tell you? How do `last` and `lastb` differ from them?
- What is the difference between `su alice` and `su - alice`?
- How does `sudo` differ from `su`?
- Why use `visudo` when editing sudo rules? What is the purpose of `/etc/sudoers.d/`?
- Does `NOPASSWD` in the sudoers configuration remove the need to authenticate when logging in over SSH?
- Before removing a suspicious account, what evidence would you collect?
- What does `userdel` remove, and what does `userdel -r` additionally remove? What would you verify separately about the user's group and files elsewhere on the system?
