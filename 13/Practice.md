# Linux Administration - Week 13 - Practice session

## Storage management

### Reconnaissance

- `lsblk` (also with `--fs`)
- `lspci`
- `/etc/fstab`
- `/etc/crypttab`

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
lsblk --fs
findmnt /
cat /etc/fstab
cat /etc/crypttab
lspci | grep -i -E 'storage|scsi|virtio'
```

```bash
ls /dev
ls /dev/*/by-id/
```

### Partitioning

We follow along playing with `parted`.

- `mklabel gpt`
- `mkpart`
    - sectors vs bytes
- `print`
- removing and resizing partitions

<details>
<summary>Shell commands</summary>

```bash
sudo parted /dev/vdb print
sudo parted /dev/vdb mklabel gpt
sudo parted /dev/vdb mkpart crypt-demo 1MiB 2049MiB
sudo parted /dev/vdb mkpart lvm-demo 2049MiB 8193MiB
sudo udevadm settle # Waiting for changes to be applied
sudo parted /dev/vdb unit MiB print
lsblk /dev/vdb
```
</details>

### Udev

- `udevadm settle` and the concept of an event
- `udevadm monitor` + `udevadm info`

<details>
<summary>Shell commands</summary>

```bash
sudo udevadm monitor
udevadm info --query=property --name=/dev/vdb1
```
</details>

### LUKS demonstration

LUKS can encrypt a single partition. Remember: the unlocked mapping acts like a block device on which we can create a filesystem.

For this demonstration, we use `/dev/vdb1` from before.

<details>
<summary>Shell commands</summary>

```bash
sudo cryptsetup luksFormat /dev/vdb1
sudo cryptsetup open /dev/vdb1 week13-crypt
sudo mkfs.ext4 /dev/mapper/week13-crypt
sudo mkdir -p /mnt/week13-crypt
sudo mount /dev/mapper/week13-crypt /mnt/week13-crypt
lsblk --fs
sudo umount /mnt/week13-crypt
sudo cryptsetup close week13-crypt
```
</details>

`/etc/crypttab` can configure unlocking at boot.

### LVM

We do along...
- the pv->vg->lv pipeline starting from the previously created partitions
- a filesystem on top of one of those logical volumes
- we mount the filesystem permanently

> [!NOTE]
> If you want to do the following exercise too, call your volume group `week13vg` and a logical volume `data`; the filesystem on it must be `ext[2-4]` for `resize2fs` to work as other filesystems use different commands for resizing.

Also, linking [this article](https://www.qwerty.md/til/2023/linux-lvm-layers-of-abstractions.html).

### Filesystem resizing

We will reuse the logical volume from the previous task and its ext4 filesystem.
- shrink its filesystem and the logical volume to 1GiB, then ensure that you lost no data.

<details>
<summary>Shell commands</summary>

```bash
sudo umount /mnt/week13-lvm
```

```bash
sudo e2fsck -f /dev/week13vg/data
sudo resize2fs /dev/week13vg/data 1G
```
</details>

> [!WARNING]
> Shrinking the volume before the filesystem will likely lead to data loss!


<details>
<summary>Shell commands</summary>

```bash
sudo lvreduce -L 1G /dev/week13vg/data
```

```bash
sudo e2fsck -f /dev/week13vg/data
sudo mount /dev/week13vg/data /mnt/week13-lvm
cat /mnt/week13-lvm/example.txt
df -h /mnt/week13-lvm
sudo lvs
```
</details>

### Permanent mount

```bash
sudo blkid /dev/week13vg/data
```
*This is the UUID of the block device; for our purposes, it refers to the filesystem*

```bash
findmnt --fstab
man 5 fstab
```

We will create an fstab entry for our logical volume.

#### Optional filesystems and `nofail`

An optional ("non vital"?) disk might be disconnected when the machine starts; this causes the system to fail to boot.

The `nofail` mount option lets boot continue if that filesystem cannot be mounted.

```fstab
UUID=...  /mnt/optional  ext4  defaults,nofail,x-systemd.device-timeout=5s  0  2
```

The timeout limits how long systemd waits for the device.

<!--
> [!NOTE]
> I will be [improvising](https://www.moma.org/audio/playlist/243/3120) the demo on my personal computer, please do not follow along.
-->

```bash
findmnt --fstab --target /mnt/optional
systemctl status mnt-optional.mount
```

The systemd mount unit name depends on the mount point.

```bash
systemd-escape --path --suffix=mount /mnt/optional
```
*This is how you derive it*

> [!CAUTION]
> You probably don't want to risk rebooting with a broken fstab, until you have tested a functional `mount -a`

> [!NOTE]
> If the disk is missing, applications may see the empty mount point directory instead of its contents, meaning you should not abuse `nofail` in the server world just because it is "convenient" at boot.

### Practice exercise

No graded labs, 10 labs already gone.

## Hometask on the VM

Follow [Homework.md](./Homework.md), which is the authoritative homework specification.
