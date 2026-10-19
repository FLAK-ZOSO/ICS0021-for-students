# Linux Administration - Week 8

## Networking

### Layers

- explain which parts of networking are handled by the OS, by the kernel
- layer 2 connectivity with `ethtool`
- interface naming conventions
- configuration for layer 3 with `ip`
    - both interfaces and routing
- explain the concept of binding, listening and connecting to ports
- visibility of ports through `ss`

### Network Manager

- configuration in `/etc/NetworkManager/system-connections/`
    - changing the `*.nmconnection` files
- show `nmcli` and some options, more from [RedHat docs](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/networking_guide/sec-Configuring_IP_Networking_with_nmcli)
    - show also `nmcli gen permissions`

### Application layer - DNS resolution

- hostname
- `/etc/hosts`
- DNS servers
    - `/etc/resolv.conf`
        - configuring a server as a resolver does not imply that the server will accept requests from your specific network
    - per-interface configuration with NM
    - resolution through `dig`
        - it only works with FQDN so it may be confusing at times

---

## [Practice session](./Practice.md)
