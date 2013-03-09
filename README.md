**Team Win Recovery Project (TWRP)**

This is a set of device configs that you can use to build and test TWRP in the Android emulator. Note that adb will take about 10 to 15 seconds after TWRP is booted to become available. Just wait and it will come online eventually.

This branch of the device configs is intended to give you a more modern emmc type of device instead of relying on the mtd nand setup that the default emulator configuration uses. In order to make this setup work, you will have to boot the emulator with a custom kernel. We added ext2/3/4 support as well as support for reading a partition map to the kernel configuration. The source for this kernel is located here:

[Kernel Source](https://github.com/Dees-Troy/android_kernel_goldfish "Kernel Source")

To boot this in the emulator, build your recoveryimage. With the Android emulator make a new device based on a Galaxy Nexus. Allow it to have a hardware keyboard and a sdcard. Give it a name like TWRP. Then from your android-sdk/tools folder run the following command:

```
./emulator -avd TWRP -ramdisk ~/cm_folder/out/target/product/twrp/ramdisk-recovery.img -kernel ~/cm_folder/device/emulator/twrp/goldfish_2.6_kernel
```

After the first boot, wait for ADB to start up, then: adb shell /sbin/create_partitions.sh

This script will partition the sdcard with a boot, recovery, system, cache, data, and removable sdcard partition. It's designed to work with a 1500MiB sdcard. If you want a different sdcard size then you will need to modify the script in the cm_folder/device/emulator/twrp/recovery/root/sbin/create_partitions.sh location to suit your needs. The script will also copy the existing system files from the MTD system partition to the new emmc-based partition.

If you want to make the emulator boot up using the emmc partitions, you will need to modify the ramdisk.img. Locate the ramdisk.img in your android-sdk/system-images/android##/armeabi-v7a/ folder. To unpack it:

```
mkdir ramdisk
cd ramdisk
gzip -dc ../ramdisk.img | cpio -i
```

Modify the init.rc to mount your mmc based partitions instead of the mtd ones by locating the line in init.rc that says "on fs" and modifying it to look like this:

```
on fs
# mount emmc partitions
    # Mount /system rw first to give the filesystem a chance to save a checkpoint
    # mount yaffs2 mtd@system /system
    # mount yaffs2 mtd@system /system ro remount
    # mount yaffs2 mtd@userdata /data nosuid nodev
    # mount yaffs2 mtd@cache /cache nosuid nodev
    mount ext4 /dev/block/mmcblk0p3 /system wait ro
    mount ext4 /dev/block/mmcblk0p5 /data wait noatime nosuid nodev
    mount ext4 /dev/block/mmcblk0p4 /cache wait noatime nosuid nodev
```

Save the changes and repack the ramdisk image as follows:

```
find . | cpio -o -H newc > gzip > ../newramdisk.img
```

Boot the emulator using -ramdisk path/to/newramdisk.img -kernel path/to/goldfish_2.6_kernel

You can find a compiling guide for TWRP [here](http://forum.xda-developers.com/showthread.php?t=1943625 "Guide").

[More information about the project.](http://www.teamw.in/project/twrp2 "More Information")

If you have code changes to submit those should be pushed to our gerrit instance.  A guide can be found [here](http://teamw.in/twrp2-gerrit "Gerrit Guide").
