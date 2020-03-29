ifeq ($(call is-vendor-board-platform,QCOM),true)
# Boards can opt-out of QCOM sepolicy
ifneq ($(TARGET_EXCLUDE_QCOM_SEPOLICY),true)

# Allow boards to use a different sepolicy
ifneq ($(filter true,$(TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY) $(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY) $(TARGET_USES_QCOM_LEGACY_SEPOLICY) $(TARGET_USES_QCOM_LATEST_SEPOLICY)), true)
    ifeq ($(call is-board-platform-in-list, apq8084 msm8226 msm8909 msm8916 msm8952 msm8960 msm8974 msm8976 msm8992 msm8994),true)
        # Use QCOM Legacy pre-UM SEPolicy by default for legacy pre-UM boards
        TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY ?= true
    else ifeq ($(call is-board-platform-in-list, msm8909 msm8937 msm8953 msm8996 msm8998 sdm660),true)
        # Use QCOM Legacy UM SEPolicy by default for legacy UM boards
        TARGET_USES_QCOM_LEGACY_UM_SEPOLICY ?= true
    else ifeq ($(call is-board-platform-in-list, sdm845 sdm710 qcs605),true)
        # Use QCOM Legacy SEPolicy by default for legacy boards
        TARGET_USES_QCOM_LEGACY_SEPOLICY ?= true
    else
        # Use QCOM latest SEPolicy by default for latest boards
        TARGET_USES_QCOM_LATEST_SEPOLICY ?= true
    endif

endif # Allow boards to use a different sepolicy

# Always enable latest sepolicy for legacy boards
ifeq ($(TARGET_USES_QCOM_LEGACY_SEPOLICY),true)
    # Use QCOM latest SEPolicy by default for latest boards
    TARGET_USES_QCOM_LATEST_SEPOLICY ?= true
endif

include device/qcom/sepolicy/sepolicy.mk

endif # Exclude QCOM SEPolicy
endif # QCOM Platform
