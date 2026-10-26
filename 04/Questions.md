# Linux Administration - Week 4 - Questions

- What information does the first character of `ls -l` output provide? Name at least four file types.
- How do `r`, `w`, and `x` affect a directory differently from a regular file?
- How are owner, group, and other permissions selected for a process accessing a file?
- Translate `rwxr-xr--` to octal.
- Translate `755` to "rwx notation".
- What is the effect of setgid on a directory? Why is it useful for a collaborative directory?
- What does the sticky bit protect in a shared writable directory such as `/tmp`?
- Why does changing only a directory's group not make subsequent files inherit that group? What do they get their group from, when created?
- What does `umask` do? What typical modes result from `umask 027` for a new regular file and a new directory?
- Why should a persistent `umask` be checked from a fresh login shell?
- When would an ACL be preferable to changing traditional owner, group, and other permissions?
- What does the ACL mask limit? Which ACL entries does it affect?
- What is the difference between an access ACL and a default ACL on a directory?
<!-- A default ACL is the one that gets inherited by NEW children, the access ACL restricts the directory itself -->
- What does `find` search recursively? Give examples of criteria it can test.
- Why can `locate` be faster than `find`, and why might its result be outdated?
