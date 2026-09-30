# Linux Administration - Week 5 - Practice session

## Lab "theory"

- Tmux, use tmux throughout the whole practice, at home, while you sleep, always
  - unless you are using [mosh](https://mosh.org/), it will make your homework way easier just by making your sessions survive the VPN dying

- crontab+anacrontab: conf files revision and format

### Scripting

- getopts
- trap
- set
- source

Special "arguments" available within each Bash script.

How to validate syntax and use shellcheck. ShellCheck really can help you in the homework.

## Week 5 lab: Crontab

Complete this exercise on your course VM as your normal user. Run this Bash command to find your assigned exercise number (1–15):

```bash
echo $(( 0x$(printf '%s' "$USER" | sha256sum | cut -c1-15) % 15 + 1 ))
```
*I have put `$USER` for your convenience, but if you are in a shell belonging to some other user just type your UNI_ID instead*

Create `/home/UNI_ID/ics0021/05/crontab.txt`, replacing `UNI_ID` with your university ID. Put one schedule line in the file: the five crontab time fields, optionally followed by a command of your choice. Its schedule must match your assigned exercise below. Keep the file on the VM and commit and push it to your GitLab repository for grading. You do not need to install this entry in your live crontab.

1. Every day at 08:00.
2. Every Monday at 18:30.
3. Every 15 minutes.
4. At minute 10 of every hour.
5. On the first day of every month at midnight.
6. Every Friday and Saturday at 23:45.
7. Every weekday at 09:00.
8. Every five minutes during the hours 09:00 through 17:00, inclusive.
9. At noon every day in June, July, and August.
10. On the 1st and 15th of every month at 07:30.
11. Every 20 minutes during the hours 08:00 through 12:00 on weekdays.
12. Every Sunday in January and February at 05:10.
13. Every minute during the 03:00 hour.
14. At 00:05 every third day of the month, starting on day 1.
15. Every seven minutes during the 09:00, 13:00, and 17:00 hours on Mondays, Wednesdays, and Fridays.
