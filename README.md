**Team Win Recovery Project (TWRP)**

This is a set of device configs that you can use to build and test TWRP in the Android emulator. Note that adb will take about 10 to 15 seconds after TWRP is booted to become available. Just wait and it will come online eventually.

This branch of the device configs is intended to be used with Android 4.4.2 system image. For some reason there is no cache partition. In order to create a cache partition as well fake boot and recovery partitions, you will have to boot the emulator with a custom kernel. We added simply added support for reading a partition map to the kernel configuration. The source for this kernel is located here:

[Kernel Source](https://android.googlesource.com/kernel/goldfish/+/android-goldfish-3.4 "Kernel Source")

To boot this in the emulator, build your recoveryimage. With the Android emulator make a new device based on a Galaxy Nexus. Name it TWRP. Allow it to have a hardware keyboard and a sdcard sized to 1500MB. Give it a decent sized data partition like 500MB or more. TWRP will be using the data partition as an emulated storage setup as seen on most modern Android devices, so having some extra room may help. Then from your android-sdk/tools folder run the following command:

```
./emulator -avd TWRP -ramdisk ~/omni_folder/out/target/product/twrp/ramdisk-recovery.img -kernel ~/omni_folder/device/emulator/twrp/goldfish_3.4_kernel
```

After the first boot, wait for ADB to start up, then: adb shell /sbin/create_partitions.sh

This script will partition the sdcard with a boot, recovery, cache, and removable sdcard partition. It's designed to work with a 1500MiB sdcard. If you want a different sdcard size then you will need to modify the script in the omni_folder/device/emulator/twrp/recovery/root/sbin/create_partitions.sh location to suit your needs.


You can find a compiling guide for TWRP [here](http://forum.xda-developers.com/showthread.php?t=1943625 "Guide").

[More information about the project.](http://www.teamw.in/project/twrp2 "More Information")

If you have code changes to submit those should be pushed to OmniROM's gerrit instance.  A guide can be found [here](http://docs.omnirom.org/Contributing_code "Gerrit Guide").
