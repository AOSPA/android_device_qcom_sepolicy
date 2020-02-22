ifeq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)

LOCAL_PATH:= $(call my-dir)

# Board specific SELinux policy variable definitions
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/vendor/common \
    $(LOCAL_PATH)/vendor/ssg \
    $(LOCAL_PATH)/timeservice \
    $(LOCAL_PATH)/vendor/common/sysmonapp

ifeq ($(TARGET_SEPOLICY_DIR),)
BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/vendor/$(TARGET_BOARD_PLATFORM)
else
BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/vendor/$(TARGET_SEPOLICY_DIR)
endif

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/vendor/test
endif

ifneq (,$(filter 24 25 26 27, $(PRODUCT_SHIPPING_API_LEVEL)))
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/vendor/ota/$(TARGET_BOARD_PLATFORM)
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    $(LOCAL_PATH)/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(LOCAL_PATH)/private

endif
