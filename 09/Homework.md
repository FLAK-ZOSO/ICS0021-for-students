# Week 9 homework

Complete the work using the archive provided on your course VM:

```text
~/ics0021/09/kaev.zip
```

*We have (tried to) prevent you from committing that and subsequent artefacts to the repository, as they are just dummy data that would make your git repository (and the remote one too!) heavy for no good reason; if you for some reason commit it, before pushing just do `git reset HEAD~1` to soft-undo the commit.*

## Create the archives

Extract `kaev.zip` into a working directory named `kaev`. The dataset contains many small files in a deeply nested directory structure.

Create these two archives from the complete extracted dataset:

```text
~/ics0021/09/kaev.tar
~/ics0021/09/kaev.tar.gz
```

Create `kaev.tar` as an uncompressed tar archive and `kaev.tar.gz` as a gzip-compressed tar archive. Both archives must remain readable and contain the complete dataset. Leave them on the VM until grading is complete.

## Benchmark the transfers

Measure at least these six transfers:

1. Copy `kaev.zip` with `cp` (to any temporary directory)
2. Copy `kaev.tar` with `cp` (to any temporary directory)
3. Copy `kaev.tar.gz` with `cp` (to any temporary directory)
4. Copy `kaev.zip` with `rsync` (to another machine, i.e. your own personal computer)
5. Copy `kaev.tar` with `rsync` (to another machine, i.e. your own personal computer)
6. Copy `kaev.tar.gz` with `rsync` (to another machine, i.e. your own personal computer)

Use `time` to measure every transfer. Do not enable rsync compression for these measurements.

> Stop and reflect: do you expect it to take it long to move (`mv`) it instead of copying it? What if you were moving it to another filesystem? How would you verify whether the destination path lives in another filesystem?

For the rsync measurements, transfer each archive from your VM to your own computer and then back to the VM. Your SSH client configuration from the practice session should make this *way* easier. If your computer does not support rsync, you may instead use rsync between two locations on the VM.

Write the results to:

```text
~/ics0021/09/benchmarks.txt
```

Label every result clearly so that the archive name and whether `cp` or `rsync` was used are unambiguous. Copying the complete output produced by `time` is acceptable; copy-pasting the shell input/output from where you did the exercise is more than good.

## Submission and grading

Commit and push `09/benchmarks.txt` to GitLab. The supplied ZIP, extracted directory, and generated tar archives are intentionally ignored by Git and **must remain on the VM** for automatic grading.

The homework is worth 3 points:

- readable and complete `kaev.tar`: 1 point;
- readable and complete `kaev.tar.gz` that is smaller than `kaev.tar`: 1 point;
- at least six clearly identified timings covering both `cp` and `rsync`: 1 point.

Automated feedback will be written to `~/ics0021/09/feedback.txt`, or to `~/week9-feedback.txt` if the homework directory does not exist.
