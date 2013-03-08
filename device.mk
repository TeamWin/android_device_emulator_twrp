$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/emulator/twrp/twrp-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/emulator/twrp/overlay

LOCAL_PATH := device/emulator/twrp
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernAl
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/emulator/twrp/recovery/root/sbin/network_start.sh:recovery/root/sbin/network_start.sh

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := teamwin_twrp
PRODUCT_BRAND := teamwin
