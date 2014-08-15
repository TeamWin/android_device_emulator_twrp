# Release name
PRODUCT_RELEASE_NAME := twrp

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/emulator/twrp/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := twrp
PRODUCT_NAME := omni_twrp
PRODUCT_BRAND := teamwin
PRODUCT_MODEL := twrp
PRODUCT_MANUFACTURER := teamwin
