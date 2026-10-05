# Linux Administration - Week 6 - Questions

- Explain the difference between a program and a process.
- What PID and PPID are and how do they relate to each other.
- Mention three pieces of information that can be found under `/proc/PID/`?
- What do `Ctrl+Z` and `Ctrl+C` normally send to the foreground process?
- Know the standard effect of `SIGTERM`, `SIGKILL` and at least two other signals.
- Explain the difference between `SIGTERM` and `SIGKILL`.
- What does a process nice value represent? Does a larger nice value give a process more or less CPU priority? Does the nice value influence I/O speed?
- What is a daemon?
- Name at least two types of systemd units and explain what they are for.
- Describe what a systemd slice is and explain what is special about `system.slice`.
- What is the difference between an active service and an enabled service?
- When would you mask a systemd service rather than just disabling it?
<!-- Cannot be started as a dependency or manually -->
- Explain why `systemctl daemon-reload` is needed after changing a unit file.
- How can `journalctl` show messages from one service only?
