# Board specific SELinux policy variable definitions
ifneq ($(TARGET_EXCLUDE_QCOM_SEPOLICY),true)
ifeq ($(call is-vendor-board-platform,QCOM),true)
LOCAL_PATH:= $(call my-dir)
BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       $(LOCAL_PATH) \
       $(LOCAL_PATH)/common \
       $(LOCAL_PATH)/test \
       $(LOCAL_PATH)/$(TARGET_BOARD_PLATFORM)

endif
endif
