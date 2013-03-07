# Release name
PRODUCT_RELEASE_NAME := twrp

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/emulator/twrp/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := twrp
PRODUCT_NAME := cm_twrp
PRODUCT_BRAND := teamwin
PRODUCT_MODEL := twrp
PRODUCT_MANUFACTURER := teamwin
