# Linux Administration - Week 2

## Manual pages

- structure of a page
- types of pages (1-9)

```bash
man passwd
man 1 passwd
man 5 passwd
man -k passwd
```

- navigation, paging, search

## Bash

### More advanced contextual awareness

- `ls` with useful arguments
    - make this point interactive by asking them to tell us just by using the man page
- `more`/`less`, explain how all pagers work the same
- `head`/`tail`
- `grep` with useful arguments
    - make this point interactive by asking them to tell us just by using the man page
- `awk` or `sed` or `cut`
    - stop to show some useful examples
- `uniq` and `sort`

### More core syntax

- `if` and comparisons
- `for`/`while` loops

### Streams

- input/output, what are streams
- stream redirection (would be cool to show it with a small Python program that writes to a file, then to stderr, then to stdout)
- pipes and `tee`

### Environment

- syntax for using variables
- exporting variables
- environment variables (`env` and `printenv` commands also)
- configuration-specific variables
    - `PATH`
    - `PS1`
    - `HISTFILE` and `HISTLEN`
    - in general `.bashrc` and `.profile`

## VIM

- what it is
- few historical notes

---

## [Practice session](./Practice.md)

## [Homework](./Homework.md)
