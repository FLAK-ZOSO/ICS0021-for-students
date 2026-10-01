# Week 5 homework

## [HackerRank Bash arrays](https://www.hackerrank.com/domains/shell?filters%5Bsubdomains%5D%5B%5D=arrays-in-bash)

Choose from the subdomain any two easy and one medium task.
Upload the screenshot to your repository as `05/hr1.png` as proof of work.

## Permissions script

Complete the work on your course VM. Replace `UNI_ID` with your university ID. Write an executable Bash script at:

```text
/home/UNI_ID/ics0021/05/homework-permissions.sh
```

The script must accept exactly two arguments:

```text
./homework-permissions.sh PERMISSIONS_FILE DIRECTORY
```

`PERMISSIONS_FILE` contains one filename and one octal mode per line:

```text
file1.txt 644
file2.txt 600
```

For each line, the script must set the requested permissions on the corresponding file inside `DIRECTORY`.

The script must:

- print an error and exit with a non-zero status when the required arguments are missing;
- report (print) a missing target file by name (the error message must contain the filename) and continue processing the remaining lines;
- finish successfully when valid files were processed even if some listed target files were missing.

Make the script executable and commit and push it to GitLab.

P.S. both stderr and stdout work fine for printing errors, from the grader's perspective; but in real life, please use either proper logging interfaces (e.g. `logger`) or the right stream (i.e. `stderr`).

## Anacron

Complete the work on your course VM. Replace `UNI_ID` with your university ID.

Add an entry to `/etc/anacrontab` that runs the script at least once every day. Make it execute once a day, choose any delay in minutes and a unique job identifier, and run it with `/home/UNI_ID/ics0021/05/sample.txt` as the permissions file and `/home/UNI_ID/ics0021/05/files` as the target directory.

Leave the Anacron entry active on the VM for automatic checking.

## Grading

Automated feedback will be written to `~/ics0021/05/feedback.txt`, or to `~/week5-feedback.txt` if the homework directory does not exist.
