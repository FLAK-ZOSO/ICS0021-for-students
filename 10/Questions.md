# Linux Administration - Week 10 - Questions

- Explain the relationship between netfilter, nftables, and firewalld.
- How does firewalld decide which zone handles an incoming packet?
- Explain the concepts of zone and target.
- What is the difference between the *"default zone"* and a zone whose target is `default`?
- How does the zone target affect services and ports listed in said zone?
- What (modest) security benefit(s) can dropping ICMP traffic have over rejecting it? What advantages can rejecting it explicitly bring? Explain in which cases you would choose one over the other.
- Describe a usecase for IP sets in firewall frontends (e.g. in firewalld) and what benefit it brings over the naive approach.
- Why can an established connection continue working after a firewall rule blocks new connections?
- A port is allowed through Firewalld for a source. What could cause connections to that port to still fail?
- When is IP forwarding required, and why is it not necessarily required for redirecting one local port to another?
- Why can assigning a source to the `block` zone affect SSH as well as ping?
- In RHEL 9 and derivates, what other software/daemon other than Firewalld manages the association of network interfaces to firewall zones?
