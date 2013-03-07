**Team Win Recovery Project (TWRP)**

This is a set of device configs that you can use to build and test TWRP in the Android emulator. Note that adb will take about 10 to 15 seconds after TWRP is booted to become available. Just wait and it will come online eventually.

To boot this in the emulator, build your recoveryimage. With the Android emulator make a new device based on a Galaxy Nexus. Allow it to have a hardware keyboard and a sdcard. Give it a name like TWRP. Then from your android-sdk/tools folder run the following command:
./emulator -avd TWRP -ramdisk ~/cm_folder/out/target/product/twrp/ramdisk-recovery.img

You can find a compiling guide [here](http://forum.xda-developers.com/showthread.php?t=1943625 "Guide").

[More information about the project.](http://www.teamw.in/project/twrp2 "More Information")

If you have code changes to submit those should be pushed to our gerrit instance.  A guide can be found [here](http://teamw.in/twrp2-gerrit "Gerrit Guide").
