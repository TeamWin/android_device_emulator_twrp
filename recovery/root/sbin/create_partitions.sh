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
# 34 MB cache partition
parted -s /dev/block/mmcblk0 mkpart cache ext2 16MB 50MB
# sdcard partition
parted -s /dev/block/mmcblk0 mkpart sdcard ext4 50MB 1536MB

echo "Formatting cache..."
# Format external_sd as vfat
make_ext4fs -S /file_contexts -a /cache /dev/block/mmcblk0p3

echo "Formatting external_sd..."
# Format external_sd as vfat
mkdosfs /dev/block/mmcblk0p4

echo "Mounting new sdcard..."
mount -t vfat /dev/block/mmcblk0p4 /external_sd
echo "Done!"
