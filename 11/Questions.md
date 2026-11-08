# Linux Administration - Week 11 - Questions

Consider that some questions, rather than merely inquiring knowledge, serve as clues for reflection that help you validate your familiarity with the topic; I have tried to keep those organized with one extra level of indentation.

- What is the "target architecture" of a package? Give two examples.
- What does `noarch` mean, and why is it appropriate for the homework RPM?
  - For what type of packages does a target architecture not matter?
- What information and files can an RPM contain besides a main executable?
- What does `rpm -V` compare? Does a reported difference necessarily mean corruption?
- What can ELF `NEEDED` entries tell you, and how do they relate to RPM dependencies?
- What happens when `rpm -i` encounters a missing dependency? How does `dnf install ./package.rpm` differ?
- Distinguish between build dependencies, compile-time dependencies and runtime dependencies.
- What is a package repository?
- What does a valid package signature establish? What does it not establish?
- How do refreshing repository metadata and upgrading installed packages differ?
  - Can you think of a case in which you would need to enable a repository on a per-transaction basis and not permanently?
- What is the difference between a module stream and a profile?
- What does a version lock do, and why might you need one?
- You are offline and you issue `dnf remove` on a package; will you normally be able to reinstall it?
  - How could you - theoretically - both uninstall a package and retain the ability to reinstall it later?
- Why should an RPM normally be built as an unprivileged user?
- What is the difference between `BuildRequires` and `Requires`?
- Why does installing a systemd unit file not necessarily enable or start it?
  - When do you think you would not want a service to come already enabled?
