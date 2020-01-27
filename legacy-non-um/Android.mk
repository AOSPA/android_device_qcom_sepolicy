ifeq ($(TARGET_USES_QCOM_LEGACY_NON_UM_SEPOLICY),true)

LOCAL_PATH:= $(call my-dir)

# Board specific SELinux policy variable definitions
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/common \
    $(LOCAL_PATH)/ssg \
    $(LOCAL_PATH)/$(TARGET_BOARD_PLATFORM)

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/test

SELINUX_IGNORE_NEVERALLOWS := true
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    $(LOCAL_PATH)/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    $(LOCAL_PATH)/private

# Board specific SELinux policy variable definitions for legacy devices
BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/legacy-common

# Add sepolicy version to support OS upgrade and backward compatibility
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0

endif
