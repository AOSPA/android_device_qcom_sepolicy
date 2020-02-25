# Use QCOM Legacy UM SEPolicy by default for legacy UM boards
ifeq ($(call is-board-platform-in-list, msm8909 msm8937 msm8953 msm8996 msm8998 sdm660),true)
  TARGET_USES_QCOM_LEGACY_UM_SEPOLICY ?= true
endif

# Use QCOM Legacy SEPolicy by default for legacy pre-UM boards
ifeq ($(call is-board-platform-in-list, apq8084 msm8226 msm8909 msm8916 msm8952 msm8960 msm8974 msm8976 msm8992 msm8994),true)
  TARGET_USES_QCOM_LEGACY_SEPOLICY ?= true
endif

# Board specific SELinux policy variable definitions
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifneq ($(TARGET_EXCLUDE_QCOM_SEPOLICY),true)
ifneq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)
ifneq ($(TARGET_USES_QCOM_LEGACY_NON_UM_SEPOLICY),true)
LOCAL_PATH:= $(call my-dir)
BOARD_PLAT_PUBLIC_SEPOLICY_DIR := \
    $(BOARD_PLAT_PUBLIC_SEPOLICY_DIR) \
    $(LOCAL_PATH)/generic/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := \
    $(BOARD_PLAT_PRIVATE_SEPOLICY_DIR) \
    $(LOCAL_PATH)/generic/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR := \
    $(BOARD_PLAT_PUBLIC_SEPOLICY_DIR) \
    $(LOCAL_PATH)/qva/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := \
    $(BOARD_PLAT_PRIVATE_SEPOLICY_DIR) \
    $(LOCAL_PATH)/qva/private

# sepolicy rules for product images
PRODUCT_PUBLIC_SEPOLICY_DIRS := \
    $(PRODUCT_PUBLIC_SEPOLICY_DIRS) \
     $(LOCAL_PATH)/product/public

PRODUCT_PRIVATE_SEPOLICY_DIRS := \
    $(PRODUCT_PRIVATE_SEPOLICY_DIRS) \
     $(LOCAL_PATH)/product/private

ifeq (,$(filter sdm845 sdm710 qcs605, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       $(LOCAL_PATH) \
       $(LOCAL_PATH)/generic/vendor/common \
       $(LOCAL_PATH)/qva/vendor/common/sysmonapp \
       $(LOCAL_PATH)/qva/vendor/ssg \
       $(LOCAL_PATH)/timeservice \
       $(LOCAL_PATH)/qva/vendor/qwesas \
       $(LOCAL_PATH)/qva/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/generic/vendor/$(TARGET_BOARD_PLATFORM)
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/qva/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/generic/vendor/$(TARGET_SEPOLICY_DIR)
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/qva/vendor/$(TARGET_SEPOLICY_DIR)
    endif

    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/generic/vendor/test
    BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/qva/vendor/test
    endif
endif

ifneq (,$(filter sdm845 sdm710 qcs605, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
                 $(BOARD_SEPOLICY_DIRS) \
                 $(LOCAL_PATH) \
                 $(LOCAL_PATH)/legacy/vendor/common/sysmonapp \
                 $(LOCAL_PATH)/legacy/vendor/ssg \
                 $(LOCAL_PATH)/timeservice \
                 $(LOCAL_PATH)/legacy/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/legacy/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/legacy/vendor/$(TARGET_SEPOLICY_DIR)
    endif
    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/legacy/vendor/test
    endif
endif # sdm845 sdm710 qcs605

endif # Legacy UM SEPolicy
endif # Legacy Non UM SEPolicy

# Include Legacy Makefiles
include $(call all-subdir-makefiles)

endif # Exclude QCOM SEPolicy
endif # QCOM Platform
