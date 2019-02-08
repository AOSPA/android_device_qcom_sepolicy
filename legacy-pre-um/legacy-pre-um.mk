ifeq ($(TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY),true)

SELINUX_IGNORE_NEVERALLOWS := true

# Board specific SELinux policy variable definitions
BOARD_SEPOLICY_DIRS += \
    device/qcom/sepolicy/legacy-pre-um/common \
    device/qcom/sepolicy/legacy-pre-um/ssg \
    device/qcom/sepolicy/legacy-pre-um/$(TARGET_BOARD_PLATFORM)

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_SEPOLICY_DIRS += \
        device/qcom/sepolicy/legacy-pre-um/test
endif

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    device/qcom/sepolicy/legacy-pre-um/public

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/qcom/sepolicy/legacy-pre-um/private

# Board specific SELinux policy variable definitions for legacy devices
BOARD_SEPOLICY_DIRS += \
    device/qcom/sepolicy/legacy-pre-um/legacy-common

# Add sepolicy version to support OS upgrade and backward compatibility
BOARD_SEPOLICY_VERS := $(PLATFORM_SDK_VERSION).0

endif
