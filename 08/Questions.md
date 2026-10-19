# Linux Administration - Week 8 - Questions

Knowledge from courses such as ICA0019 (Fundamentals of Networking) is valuable here, but we will only ask from the subset of information that is strictly relevant to system administration.

- What is the difference between a network interface being up and having an IP address?
- Explain what information a prefix such as `/24` provides.
- What may happen if a subnet mask is misconfigured on an interface?
- What is the purpose of a default route, and why does the Week 8 interface not need one?
- What is the difference between configuration made with `ip` and configuration stored by NetworkManager?
- What does it mean for a process to listen on a network port?
- What is the difference between binding to `127.0.0.1`, one interface address, and `0.0.0.0`?
- Can multiple processes listen on the same port?
- Can multiple processes listen on the same port but on different addresses?
<!-- Think of 10.10.0.10:5000 and 192.168.42.227:5000, but then think of 0.0.0.0:5000 -->
- Mention three pieces of information <!-- about listening sockets and established connections --> that can be obtained with `ss`.
- What do a successful connection, `Connection refused`, and a timeout usually indicate?
- ~~In what order are `/etc/hosts` and DNS consulted on these systems, and where is that order configured?~~ (haven't covered NSSwitch yet, we will get to it on week 10)
