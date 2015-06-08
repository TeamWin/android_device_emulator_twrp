USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/emulator/twrp/BoardConfigVendor.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := twrp

# Platform
TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := omap4

# Architecture
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_CPU_VARIANT := cortex-a9

BOARD_KERNEL_BASE := 0x80000000
# BOARD_KERNEL_CMDLINE :=

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x105c0000
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_PREBUILT_KERNEL := device/emulator/twrp/kernAl

# Recovery:Start

# Use this flag if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_RECOVERY_INITRC := device/emulator/twrp/recovery/init.rc
TARGET_USERIMAGES_USE_EXT4 := true

# TWRP specific build flags
TW_THEME := portrait_mdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
