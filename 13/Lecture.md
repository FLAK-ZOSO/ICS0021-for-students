# Linux Administration - Week 13

> [!NOTE]
> This material here is quite raw. More in the slides and the recording.

## Storage Management

In [this diagram](https://www.thomas-krenn.com/en/wiki/Linux_Storage_Stack_Diagram) the insane amount of libraries, subsystems and layers needed to abstract hardware storage is presented. We will go over part of it; some useful links follow.

- what and why the [page cache is](https://kernel-internals.org/mm/page-cache/)?

Consider that different people will care about different parts of this: a user mostly cares about the free space remaining; an administrator cares about filesystems, partitioning, drivers, mapping and much more; a C/C++/Rust developer cares about the API; a kernel developer will care about the internals of the layer(s) they are working on.

### Example storage stack

1. Directories, files, user space
2. File systems
3. LVM
4. LUKS
5. Partitions
6. \[Multipath\] mapper [`[source]`](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_device_mapper_multipath/overview-of-device-mapper-multipathing_configuring-device-mapper-multipath) [`[source]`](https://ubuntu.com/server/docs/explanation/intro-to/multipath/)
7. Hardware interfaces (SCSI, NVMe, ...) \[hardware RAID\]

Keep in mind that...
- This is one of the possible orders in which to stack these layers
  - LVM can be on top of LUKS, but also a LUKS partition can live on top of an LVM logical volume
- Many layers are optional (likely your home laptop has no software RAID, no LVM, no LUKS)

### Partitions

- concept of a partition
    - why is it useful?
      - separate operating system files and user files (very handy for upgrades)
      - create an area for swap
      - limit disk space to scan for diagnostic tools
      - limit disk space to snapshot for backups
- MBR vs GPT
    - only 2TiB for MBR
    - maximum 4 (primary) partitions in MBR
    - partition table stored at both beginning and end of disk
    - GPT associated to UEFI, MBR to BIOS
- parted as a tool (practice session)
- mention Udev (practice session)
- how GPT IDs differ from filesystem UUIDs [`[source]`](https://serverfault.com/a/1117141/1062438)

### LUKS

- mention what it is
- `/etc/crypttab` at least mentioned

### LVM

Show the graphical explanation of those.

- physical volumes (PVs)
- volume groups (VGs)
- logical volumes (LVs)

We will cover the manipulation during the practice session.

### Filesystems

- refresh what we said about what a directory really is and that it lives in a filesystem
- mention different filesystem types (ext2, ext3, ext4, FAT32, ZFS, NTFS, XFS, ...)
- mounting filesystems (`mount` and `/etc/fstab`)
    - let's look into `man 5 fstab` to comment quickly on the mount fields
- mention that you can resize filesystems (`xfs_growfs`) but XFS cannot be shrank
- mention `fsck` and what it does on boot to a journaling filesystem

### Swap

- what is swap space and what tradeoff does it bring
- swapfile vs swap partition
    - mention SSD wearing risk
    - `parted` -> `mkswap`
- explain that it has to be activated
- mention swappiness, with the warning that it works based on the vibes

---

## [Practice session](./Practice.md)
