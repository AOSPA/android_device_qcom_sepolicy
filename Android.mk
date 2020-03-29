# Use QCOM Legacy UM SEPolicy by default for legacy UM boards
ifeq ($(call is-board-platform-in-list, msm8909 msm8937 msm8953 msm8996 msm8998 sdm660),true)
  TARGET_USES_QCOM_LEGACY_UM_SEPOLICY ?= true
endif

# Use QCOM Legacy SEPolicy by default for legacy pre-UM boards
ifeq ($(call is-board-platform-in-list, apq8084 msm8226 msm8909 msm8916 msm8952 msm8960 msm8974 msm8976 msm8992 msm8994),true)
  TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY ?= true
endif

# Board specific SELinux policy variable definitions
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifneq ($(TARGET_EXCLUDE_QCOM_SEPOLICY),true)
# Include Legacy Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY),true)
    include device/qcom/sepolicy/legacy-pre-um/legacy-pre-um.mk
else ifeq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)
    include device/qcom/sepolicy/legacy-um/legacy-um.mk
else
BOARD_PLAT_PUBLIC_SEPOLICY_DIR := \
    $(BOARD_PLAT_PUBLIC_SEPOLICY_DIR) \
    device/qcom/sepolicy/generic/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := \
    $(BOARD_PLAT_PRIVATE_SEPOLICY_DIR) \
    device/qcom/sepolicy/generic/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR := \
    $(BOARD_PLAT_PUBLIC_SEPOLICY_DIR) \
    device/qcom/sepolicy/qva/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR := \
    $(BOARD_PLAT_PRIVATE_SEPOLICY_DIR) \
    device/qcom/sepolicy/qva/private

# sepolicy rules for product images
PRODUCT_PUBLIC_SEPOLICY_DIRS := \
    $(PRODUCT_PUBLIC_SEPOLICY_DIRS) \
     device/qcom/sepolicy/product/public

PRODUCT_PRIVATE_SEPOLICY_DIRS := \
    $(PRODUCT_PRIVATE_SEPOLICY_DIRS) \
     device/qcom/sepolicy/product/private

# Include vendor sepolicies only if vendor image is built.
ifneq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
ifeq (,$(filter sdm845 sdm710 qcs605, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
       $(BOARD_SEPOLICY_DIRS) \
       device/qcom/sepolicy \
       device/qcom/sepolicy/generic/vendor/common \
       device/qcom/sepolicy/qva/vendor/common/sysmonapp \
       device/qcom/sepolicy/qva/vendor/ssg \
       device/qcom/sepolicy/timeservice \
       device/qcom/sepolicy/qva/vendor/qwesas \
       device/qcom/sepolicy/qva/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/generic/vendor/$(TARGET_BOARD_PLATFORM)
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/qva/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/generic/vendor/$(TARGET_SEPOLICY_DIR)
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/qva/vendor/$(TARGET_SEPOLICY_DIR)
    endif

    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/generic/vendor/test
    BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/qva/vendor/test
    endif
endif

ifneq (,$(filter sdm845 sdm710 qcs605, $(TARGET_BOARD_PLATFORM)))
    BOARD_SEPOLICY_DIRS := \
                 $(BOARD_SEPOLICY_DIRS) \
                 device/qcom/sepolicy \
                 device/qcom/sepolicy/legacy/vendor/common/sysmonapp \
                 device/qcom/sepolicy/legacy/vendor/ssg \
                 device/qcom/sepolicy/timeservice \
                 device/qcom/sepolicy/legacy/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/legacy/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/legacy/vendor/$(TARGET_SEPOLICY_DIR)
    endif
    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_SEPOLICY_DIRS += device/qcom/sepolicy/legacy/vendor/test
    endif
endif # sdm845 sdm710 qcs605
endif # !PREBUILT_VENDOR_SEPOLICY
endif

endif # Exclude QCOM SEPolicy
endif # QCOM Platform
