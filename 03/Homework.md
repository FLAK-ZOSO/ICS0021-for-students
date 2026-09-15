# Week 3 homework

A suspicious account has been planted on your course VM. Identify it by examining users, groups, login information, home directories, and login shells.

Before changing anything, record the account name, UID, and home directory in `03/account-investigation.md`. Include at least one finding explaining why the account is suspicious, together with the command used and its relevant output.

Then remove the suspicious account, its home directory, and its private group. Do not modify unrelated users or groups. Record your removal commands and how you verified the result.

Use this report template:

```markdown
# Account investigation

## Suspected account

Account name:
UID:
Home directory:

## Evidence

1. Finding:
   Command:
   Relevant output:

## Remediation

Commands used:
How I verified that the suspicious account, its home directory, and its private group no longer exist:
```

Commit and push `03/account-investigation.md` to your GitLab repository. Keep the submitted version in `~/ics0021/03/account-investigation.md` on your course VM for grading.

The homework is worth **3 points**:

- 1 point for identifying the account and recording its name, UID, and home directory;
- 1 point for an explained finding supported by a command and relevant output;
- 1 point for removing the account, its private group, and its home directory without modifying unrelated accounts.

The deadline is two weeks after the homework is assigned, no extensions.

---

Use manual pages and look up how commands work. You may ask for clarification, but do not ask another person or an AI tool to identify the account or write the report for you.
