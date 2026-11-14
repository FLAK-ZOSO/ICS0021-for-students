# Linux Administration - Week 12 - Questions

- What is included in an SELinux context? Name at least three components.
- What is the difference between whitelisting and blacklisting in the context of access control? Which one does SELinux use?
- Name two advantages of using SELinux over traditional UNIX-style permissions.
- SELinux allows access to a file, but by UNIX permissions that access would not be allowed; can the process access the file?
- A file has a context of `system_u:object_r:httpd_sys_content_t:s0`. What does each part of this context represent?
- Name one type of attack that SELinux can help protect against.
- What is the purpose of a boolean in SELinux, and how does it affect the policy?
- What is a module in SELinux, and how does it relate to the policy?
- How does SELinux handle permissions for processes and files, and how does it differ from traditional UNIX permissions?
<!-- We should have more questions, this is overfitting the lecture, but I don't have more ideas right now -->
- You configure `DocumentRoot /srv/my-dear-docs` in Apache, but it seems unable to serve it. Describe at least one solution.
- An application works in a [staging environment](https://realpython.com/ref/software-engineering-glossary/staging-environment/) without SELinux but not in production. Describe at least one solution that does not require disabling SELinux.

Bonus thinking questions below.

- As a user your shell is running as `unconfined_t`. Does this mean SELinux cannot restrict you?
- A system administrator tells you that they prefer a domain permissive rather than enforcing when applying custom configuration to an application that comes with a policy module. What argument would you make for that case?
