#!/sbin/sh
# This will repartition the emulated sdcard so that
# you can emulate a newer, non-MTD device.
# This partitioning scheme is based on a 1500MiB
# sdcard.

umount /sdcard

echo "Creating partition table..."
# Wipe all partitions and give you a gpt partition table
parted -s /dev/block/mmcblk0 mklabel gpt
# 8MB boot partition
parted /dev/block/mmcblk0 mkpart boot ext2 0 8MB
# 8MB recovery partition
parted /dev/block/mmcblk0 mkpart recovery ext2 8MB 16MB
# 200MB system partition
parted /dev/block/mmcblk0 mkpart system ext4 16MB 216MB
# 64MB cache partition
parted /dev/block/mmcblk0 mkpart cache ext4 216MB 280MB
# 720MB data partition
parted /dev/block/mmcblk0 mkpart data ext4 280MB 1000MB
# 573MB external_sd partition
parted /dev/block/mmcblk0 mkpart external_sd ext4 1000MB 1573MB

echo "Formatting system, data, and cache..."
# Format system, cache, and data as ext4
make_ext4fs /dev/block/mmcblk0p3
make_ext4fs /dev/block/mmcblk0p4
make_ext4fs -l -16384 /dev/block/mmcblk0p5

echo "Formatting external_sd..."
# Format external_sd as vfat
mkdosfs /dev/block/mmcblk0p6

echo "Mounting new system and sdcard and make a copy of system..."
mount -t vfat /dev/block/mmcblk0p6 /sdcard
mkdir /systemmtd
mount -t ext4 /dev/block/mmcblk0p3 /system
mount -t yaffs2 /dev/block/mtdblock0 /systemmtd
cd /system2 && cp -R * /system
echo "DONE!"

