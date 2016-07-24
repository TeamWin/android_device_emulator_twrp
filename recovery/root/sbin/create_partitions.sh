#!/sbin/sh
# This will repartition the emulated sdcard so that
# you can emulate a newer, non-MTD device.
# This partitioning scheme is based on a 1500MiB
# sdcard.

umount /external_sd

echo "Creating partition table..."
# Wipe all partitions and give you a gpt partition table
parted -s /dev/block/mmcblk0 mklabel gpt
# 8MB boot partition
parted -s /dev/block/mmcblk0 mkpart boot ext2 0 8MB
# 8MB recovery partition
parted -s /dev/block/mmcblk0 mkpart recovery ext2 8MB 16MB
# sdcard partition
parted -s /dev/block/mmcblk0 mkpart sdcard ext4 16MB 2048MB

echo "Formatting external_sd..."
# Format external_sd as vfat
mkdosfs /dev/block/mmcblk0p3

echo "Mounting new sdcard..."
mount -t vfat /dev/block/mmcblk0p3 /external_sd
echo "Done!"
