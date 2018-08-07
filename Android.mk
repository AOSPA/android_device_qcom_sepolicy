# Board specific SELinux policy variable definitions
ifeq ($(call is-vendor-board-platform,QCOM),true)
LOCAL_PATH:= $(call my-dir)
ifneq ($(call is-board-platform-in-list, qcs605),true)
BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       $(LOCAL_PATH) \
       $(LOCAL_PATH)/common \
       $(LOCAL_PATH)/ssg \
       $(LOCAL_PATH)/$(TARGET_BOARD_PLATFORM)
endif
ifeq ($(call is-board-platform-in-list, qcs605),true)
BOARD_SEPOLICY_DIRS := \
      $(BOARD_SEPOLICY_DIRS) \
      $(LOCAL_PATH)/ssg \
      $(LOCAL_PATH)/$(TARGET_BOARD_PLATFORM)
endif
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
BOARD_SEPOLICY_DIRS += \
       $(LOCAL_PATH)/test
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR := \
    $(BOARD_PLAT_PUBLIC_SEPOLICY_DIR) \
    $(LOCAL_PATH)/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := \
    $(BOARD_PLAT_PRIVATE_SEPOLICY_DIR) \
    $(LOCAL_PATH)/private

# Add sepolicy version to support OS upgrade and backward compatibility
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0
endif
