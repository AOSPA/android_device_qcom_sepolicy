$(warning SEPOLICY $(TARGET_BOARD_PLATFORM))
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
# Include Legacy Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_NON_UM_SEPOLICY),true)
    include device/qcom/sepolicy/legacy-non-um/legacy-non-um.mk
else ifeq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)
    $(warning SEPOLICY: including legacy um policy)
    include device/qcom/sepolicy/legacy-um/legacy-um.mk
else
    include device/qcom/sepolicy/sepolicy.mk
endif

endif # Exclude QCOM SEPolicy
endif # QCOM Platform
