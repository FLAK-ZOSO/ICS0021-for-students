# Linux Administration - Week 10

## More on networking

<!-- This is for some things we left out in week 8 -->

### More configurations

- priority for DNS resolution
    - `/etc/nsswitch.conf` as a concept
    - mDNS (for .local)

```yaml
hosts:          files mdns4_minimal [NOTFOUND=return] mymachines dns
```
*Explained [here](https://superuser.com/a/1417265/1528755) by [grawity](https://superuser.com/users/1686/grawity), plus ["mymachines" is for containers](https://www.man7.org/linux//man-pages/man8/systemd-machined.service.8.html)*

### NAT

Just introduce the concept, because we will see iptables/firewallcmd with the firewall.

- https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/security_guide/sec-configuring_nat_using_nftables

### Routing

```bash
# Write the piece of configuration
sudo sysctl -w net.ipv4.ip_forward = 1
# Loading it from the configuration file
sudo sysctl -p
```
*Explain this and its meaning: the host can now get packets from one interface to an other*

## Firewalls

> *As a premise, the firewall nomenclature in Linux is madness, more on it [here](https://datahacker.blog/industry/technology-menu/networking/a-brief-history-of-linux-networking)*

### Concepts

- zones and interfaces
  - as opposed to sequential access control lists such as those in `ufw`
- NAT and port forwarding

Some more.

- chains and tables
- policies and rules
- targets and actions
- stateful and stateless firewalls

### Tools - netfilter->iptables/nftables->firewalld

> The Linux kernel includes the netfilter subsystem, which is used to manipulate or decide the fate of network traffic headed into or through your server. All modern Linux firewall solutions use this system for packet filtering.
> The kernel’s packet filtering system would be of little use to administrators without a userspace interface to manage it. This is the purpose of the iptables utility: when a packet reaches your server, it will be handed off to the netfilter subsystem for acceptance, manipulation, or rejection based on the rules supplied to it from the userspace (via iptables). Thus, iptables is all you need to manage your firewall, if you’re familiar with it, but many frontends are available to simplify the task.
> ([Ubuntu Server documentation - Firewall](https://ubuntu.com/server/docs/how-to/security/firewalls/))

### Firewalld

Knowing what zones are, we can start from there.

- `man firewall-cmd` for the documentation
- what is an active zone
- show how to check the zones and their interfaces (`firewall-cmd --get-active-zones`)
- show how to check the rules for a zone (`--list-all`, `firewall-cmd --zone=public --list-all` for example)
- show how to add rules to a zone, permanently and not permanently (`--add-port=80/tcp`, `--permanent` for example)
- show how to add a port forwarding rule (`--add-forward-port=port=80:proto=tcp:toport=8080` for example)

The documentation provides a page on [concepts](https://firewalld.org/documentation/concepts.html) and one on [architecture](https://firewalld.org/documentation/architecture.html) that can be useful to understand how it works.

- Some zones are included by default
    - public, dmz, work, home, internal, external, trusted, drop, block
- difference between drop and block
- difference between a zone and a target, even if they have the same names

### Notes on NetworkManager

> One of these zones is set as the default zone. When interface connections are added to NetworkManager, they are assigned to the default zone. On installation, the default zone in firewalld is set to be the public zone. The default zone can be changed.
> ([RedHat documentation - Using firewalld](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/security_guide/sec-using_firewalls#sec-Getting_started_with_firewalld))

- you have to manage interfaces with NetworkManager for reliable firewalling with firewalld

> Today the approach is more and more reliant on NetworkManager for things that were managed separately in the past (addressing, DNS, firewall)

---

## [Practice session](./Practice.md)
