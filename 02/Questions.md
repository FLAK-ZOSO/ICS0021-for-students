# Linux Administration - Week 2 - Questions

Use manual pages when needed.

- What is the difference between `man 1 passwd` and `man 5 passwd`? Why can the same name appear in different manual sections?
- You pipe into `head`, `grep` or `tail` to inspect the output of a command, however (part of) the output appears "unfiltered": how do you explain that? Why does it happen?
- What does a pipe connect? Does `command | grep pattern` normally filter the command's error messages too?
- Why might `uniq` leave repeated lines in its output? When would you put `sort` before it?
- Explain what standard input, standard output, and standard error are.
- What is the difference between `>`, `>>`, and `2>`? What happens to an existing destination file in each case?
- What is the difference between a shell variable and an environment variable? What does `export` change?
- Compare `a=1`, `export a=1`, and `a=1 printenv a`. Which makes the value available to a child process, and for how long?
- Why is `printenv | grep a` an unreliable way to check specifically for a variable named `a`? What would you use instead?
- Explain what the `PATH` variable affects and why/for what we use it.
- What is the difference between `.bashrc` and `.profile`? How does the type of Bash session affect which startup files are read?

A perfectly valid way to convince yourself of a behaviour is to test it with an example in your shell; in that case, you have to be able to think about said example.
