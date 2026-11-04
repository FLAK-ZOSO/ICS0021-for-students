# Linux Administration - Week 10 - Practice session

When making changes to the firewall, just in case, make them temporary.

```bash
firewall-cmd --add-service=ssh --timeout 15m
```
*This change will automatically revert after 15 minutes*

We give a look at zones and rich rules, `man 5 firewalld.richlanguage` for the latter.

- prevent ICMP echo requests at least from 192.168.42.0/24, with explicit denial
- verify that you cannot ping each other

Some demo on port translation follows.

### IP Sets

Guide [here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/security_guide/sec-setting_and_controlling_ip_sets_using_firewalld).

## Hometask on the VM

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
