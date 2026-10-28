# Linux Administration - Week 9 - Practice session

## Practice session

### Securing SSH

- follow the hardening steps provided during the lecture on your VM
  - Not the changing port one, because we need it for logging in teacher side
  - leave `ListenAddress` unchanged

> [!WARNING]
> If you get locked out, we will have to recover your VM: always push to GitLab and try to be careful.

- push all the relevant configuration files (don't forget the `.d/` ones) to GitLab, committing them under `09/` in the repository

Back up configuration, **not** secrets: files matching `/etc/ssh/ssh_host_*_key` are the server's private host keys and must **never** be committed: someone owning those keys can lie to an SSH client pretending to be the legitimate server! Their corresponding `.pub` files are public, but they are not needed for this exercise either.

### SSH client configuration

Create an SSH client configuration for connecting to your course VM, specifying...

- username
- identity file
- preferred authentication
- hostkey algorithm
- jump host
- port

Copy the completed host entry to either `~/ics0021/09/config` or `~/ics0021/09/ssh_config` and push it to GitLab. Copy only the configuration, never a private key.

- Some Cisco routers require you to set `HostKeyAlgorithms` to include `ssh-rsa` and `KexAlgorithms` to include `diffie-hellman-group14-sha256`
    - Use `ssh -Q key` to list supported key types
    ```bash
    for F in $(ssh -Q help); do 
        printf "=== $F ===\n"
        ssh -Q $F
        echo ""
    done
    ```
    _Credit to [Mike Slinn](https://unix.stackexchange.com/a/617870/508535)_
    ```conf
    HostKeyAlgorithms=+ssh-rsa
    PubkeyAcceptedAlgorithms=+ssh-rsa
    KexAlgorithms=+diffie-hellman-group1-sha1 # Probably older than your parents
    ```
    *Consider some modern [FIPS guidelines](https://security.stackexchange.com/a/131045/336325) and only do this when needed*

    ```conf
    Host old-router
        HostName 192.0.2.10
        HostKeyAlgorithms +ssh-rsa
        PubkeyAcceptedAlgorithms +ssh-rsa
        KexAlgorithms +diffie-hellman-group1-sha1
    ```
    *As mentioned above, scope it to an host*

- Explore local forwarding (`LocalForward` or `-L`), remote forwarding (`-R`), and dynamic forwarding (`-D`) using the examples below.

### SSH forwarding

| Option | Listener runs on | Destination | Example | Effect |
|---|---|---|---|---|
| `-L` | Local machine | Fixed when SSH starts | `ssh -L 8080:internal-web:80 server` | `localhost:8080` reaches `internal-web:80` through `server`. |
| `-R` | Remote SSH server | Fixed when SSH starts | `ssh -R 8080:localhost:3000 server` | Port `8080` on `server` reaches port `3000` on your local machine. |
| `-D` | Local machine | Chosen by each SOCKS connection | `ssh -D 1080 server` | Creates a SOCKS proxy at `localhost:1080` for reaching different destinations through `server`. |

Check out this [tutorial](https://labs.iximiuz.com/tutorials/ssh-tunnels) with visuals.

### Tar

Before the homework, read about the [risk of placing an archive inside the directory being archived](https://stackoverflow.com/a/4572985/15888601).

## Homework

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
