# Linux Administration - Week 8 - Practice session

Because of Neutron port security with anti-spoofing controls in OpenStack, you won't be able to have any fun with network interface configuration, especially for what concerns addressing.

- look at the interfaces
  - `nmcli dev show`, `nmcli con show`
  - connection = profile/ruleset telling the device how to connect to a network
- look at the routes
  - `ip r` and explain why wrong subnet masks break routing
  - `ip r get`

- use netcat (`nc`) to communicate with a classmate over the new addresses
- verify through `ss` that the listening port is the right one, and what happens after a classmate connects

Let's use `tmux` with side to side panes.

<!-- - pinging other machines
- network port scanning
    - testing ports with telnet (meaning of when you get the connection refused vs when you get no response at all) -->

## Hometask on the VM

No hometask this week, however...
- Q&A session for the material covered so far
- oral exam demo with a volunteer, if time is left
