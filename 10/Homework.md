# Week 10 homework

Complete the following tasks on your course VM and leave every required rule and listener running until grading is complete.

## Drop and reject

A listener on TCP port `4242` has already been prepared and started by the teacher. Do not stop or replace it.

Configure firewalld so that:

- connections to TCP port `4242` from the gateway's private address, (`192.168.42.166`, but double check with `echo "$SSH_CONNECTION"` because this information could be outdated), are silently dropped;
- connections to TCP port `4242` from every other address in `192.168.42.0/24` are explicitly rejected.

The gateway belongs to that subnet, so ensure that its more specific drop rule takes precedence (or, the way the *rich* ones call it, *priority*; you get the hint?) over the subnet-wide reject rule.

## Port translation

Run a **persistent** TCP listener on port `8080` and configure firewalld to forward connections arriving on TCP port `80` to port `8080` on the same VM. There must **not** be a separate listener directly on port `80`.

The listener must remain running after you disconnect from the VM. You may use a systemd service or any another suitable method (a background task in a tmux session would be unorthodox but it would still be accepted by the grader, so don't worry much).

Suggestion: a persistent TCP listener, such as a Web server, is a piece of software that keeps listening and accepting connections (resulting into sockets, be at least familiar with this vocabulary!) on one port; we have used one last week (already installed on your VMs and certainly less complex than a Web server), but in that case it was not persistent: look at its documentation and find out how to make it accept multiple connections.

## Panic mode

Create this executable script:

```text
~/ics0021/10/panic-mode.sh
```

The script must monitor the SSH journal for new failed login attempts. When it detects one, it must enable firewalld panic mode, wait some (5-8, 8 worked for me) seconds, and disable panic mode again.

We should have already generated example SSH login failures, inspect the resulting events (logs to journald can be used in the script too, but after the homework deadline definitely comment on Teams any creative/stable alternative solution if you find one!). The grader will later generate (at least) one of the same *kinds* of failure.

The grader will run the script as `root`. The script must remain running, monitor for new failed SSH login attempts until terminated, and require no interactive input. You do not need to create a service or start the script before grading.

Be careful when testing it yourself: panic mode interrupts all network communication with the VM, including your own SSH connection.

This script can consist of just 10 lines of bash, don't overthink it, just make sure it does not lock you out permanently and it gets the job done.

## Grading

The homework is worth 6 points:

- gateway connections to port `4242` are silently dropped: 1 point;
- connections from another VM to port `4242` are explicitly rejected: 1 point;
- a service is listening on port `8080`: 1 point;
- connections to port `80` reach the listener on port `8080`: 1 point;
- a new failed SSH login activates panic mode: 1 point;
- network access is back within 10 seconds: 1 point.

Automated feedback will be written to `~/ics0021/10/feedback.txt`, or to `~/week10-feedback.txt` if the homework directory does not exist.
