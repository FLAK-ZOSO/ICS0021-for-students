# Linux Administration - Week 6 - Practice session

## Lab work

### Class walkthrough

- nice and renice
- htop
- looking into a process

### Monitoring and managing processes

This lab is based on the RH124 **Monitoring and Managing Linux Processes** lab. Complete it as your normal user.

1. Run `sleep 600` in the foreground, suspend it with `Ctrl+Z`, and inspect it with `jobs`.
2. Continue it in the background, bring it back to the foreground, and terminate it with `Ctrl+C`.
3. Start a new `sleep 600` process in the background and record its PID.
4. Inspect its PID, parent PID, nice value, state, and command with `ps`. Find the same process in a process tree and in `top` or `htop`.
5. Send it `SIGSTOP` and verify that its state changes to stopped. Send it `SIGCONT` and verify that it runs again.
6. Terminate it with `SIGTERM` and verify that the process no longer exists.
7. Start `sleep 6h` in the background, send it `SIGSTOP`, and leave it stopped for automatic checking.
8. Start `sleep 7h` with a nice value of `10`, change its nice value to `15` with `renice`, and leave it running for automatic checking.
9. Confirm that you have no `sleep 600` jobs left. Leave the `sleep 6h` and `sleep 7h` processes in place until grading is complete.

## Homework

The complete assignment is in [Homework.md](Homework.md).
