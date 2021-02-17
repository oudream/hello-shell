sudo fdisk /dev/sdc
sudo mkdir -p /tmpdir/disk
sudo mount /dev/sdc1  /tmpdir/disk/
sudo mount -t xfs /dev/sdc1  /tmpdir/disk/
sudo mount -t ext4 /dev/sdc1  /tmpdir/disk/
sudo mount -t XFS /dev/sdc1  /tmpdir/disk/
sudo mount /dev/sdc1  /tmpdir/disk/
sudo mount /dev/sdc2  /tmpdir/disk/
sudo mount -t xfs /dev/sdc2  /tmpdir/disk/
df -T -h
sudo fdisk /dev/sdc
demsg |tail -n 20
sudo mount -t xfs /dev/sdc2  /tmpdir/disk/
fsck.xfs /dev/sdc2
fsck -t xfs /dev/sdc2
xfs_repair /dev/sdc1
sudo xfs_repair /dev/sdc2
sudo mount -t xfs /dev/sdc2  /tmpdir/disk/
sudo mount  /dev/sdc2  /tmpdir/disk/
dmesg
dmesg | tail -n 20
sudo mount -o noUUid  /dev/sdc2  /tmpdir/disk/
sudo umount -o nouuid  /dev/sdc2  /tmpdir/disk/
ls /tmpdir/disk/
umount /tmpdir/disk/
sudo umount /tmpdir/disk/
ll
cd  /tmpdir/disk
ll
cd ./etc/selinux/config
ll
cd etc/selinux/
ll
vim config
sudo vim config
cat config
exit
sudo umount -o nouuid  /dev/sdc2  /tmpdir/disk/
sudo mount -o nouuid  /dev/sdc2  /tmpdir/disk/
ls /tmpdir/disk/
sudo umount /tmpdir/disk/
