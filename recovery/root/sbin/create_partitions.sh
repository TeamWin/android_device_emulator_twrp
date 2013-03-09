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
# 250MB system partition
parted -s /dev/block/mmcblk0 mkpart system ext4 16MB 266MB
# 64MB cache partition
parted -s /dev/block/mmcblk0 mkpart cache ext4 266MB 330MB
# 670MB data partition
parted -s /dev/block/mmcblk0 mkpart data ext4 330MB 1000MB
# 573MB external_sd partition
parted -s /dev/block/mmcblk0 mkpart external_sd ext4 1000MB 1573MB

echo "Formatting system, data, and cache..."
# Format system, cache, and data as ext4
make_ext4fs /dev/block/mmcblk0p3
make_ext4fs /dev/block/mmcblk0p4
make_ext4fs -l -16384 /dev/block/mmcblk0p5

echo "Formatting external_sd..."
# Format external_sd as vfat
mkdosfs /dev/block/mmcblk0p6

echo "Mounting new system and sdcard and make a copy of system..."
mount -t vfat /dev/block/mmcblk0p6 /external_sd
mount -t yaffs2 /dev/block/mtdblock0 /system
echo " *** IMPORTANT ***"
echo "To properly copy your system from the old MTD device to the new mmc"
echo "device you need to make a backup of system right now. Currently the"
echo "MTD device is mounted to /system so you can back it up right now."
echo "After making the backup, unmount system on the mount page, then"
echo "restore the backup using the restore page."

