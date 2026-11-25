# Week 13 homework

The VM has an empty 10 GiB disk at `/dev/vdb`; if it is not free because you used it during the practice, worry not: you can destroy that partition table.

> [!CAUTION]
> Do **not** modify `/dev/vda` or the root filesystem: you could break your system beyond repair.

Create at least two partitions on `/dev/vdb`:

1. use one partition to create an LVM physical volume, volume group, and logical volume of at least 5 GiB;
2. create an ext4 filesystem on that logical volume and mount it at `/mnt/ics0021-data`;
3. use a different partition to create at least 1 GiB of swap space and enable it.

Make both the filesystem mount (at the given mountpoint) and swap activation persistent across reboots.
Names, partition numbers, and the amount of remaining free space are your choice.

Automated feedback is written to `/home/UNI_ID/ics0021/13/feedback.txt`.
