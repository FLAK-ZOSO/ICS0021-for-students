# Linux Administration - Week 2 - Practice session

## Some theory

Going over the theory that did not fit the lecture.

### Stream redirection

- great tutorial on stream redirection [here](https://web.archive.org/web/20230315225157/https://wiki.bash-hackers.org/howto/redirection_tutorial)

### Cycles

- comment two simple examples at [cycles.sh](cycles.sh)

### Piped manipulation

- [sed demo](sed_demo.sh)
- basic grep
- [tee demo](tee_demo.sh)

## Lab work

We first see how exporting variables works.

```bash
a=1
echo $a
printenv
printenv | grep a
a=1 printenv
a=1 printenv | grep a
export a=1
printenv
printenv | grep a
```

- edit your `.bashrc` file in enos
    - change your [PS1](https://man7.org/linux/man-pages/man1/bash.1.html#PROMPTING) to have timestamp
    - upload to your GitLab repository a screenshot including both prompt and PS1 value
- a VIM lab
    - `vimtutor`, give the time to do it; not through the Web VNC of RedHat because key bindings don't always work for all
    - bonus points to whoever can claim the best time at a chosen [vim-racer](https://vim-racer.com/) challenge

## Homework

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
