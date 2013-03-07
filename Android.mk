ifneq ($(filter twrp,$(TARGET_DEVICE)),)
    include $(all-subdir-makefiles)
endif
