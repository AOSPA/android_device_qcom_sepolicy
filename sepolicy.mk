# Include Legacy pre-UM Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY),true)
    $(warning including legacy-pre-um sepolicy)
    include device/qcom/sepolicy/legacy-pre-um/legacy-pre-um.mk
endif

# Include Legacy UM Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)
    $(warning including legacy-um sepolicy)
    include device/qcom/sepolicy/legacy-um/legacy-um.mk
endif

# Include latest sepolicy
ifeq ($(TARGET_USES_QCOM_LATEST_SEPOLICY),true)
    $(warning including latest sepolicy)
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

    PRODUCT_PUBLIC_SEPOLICY_DIRS := \
        $(PRODUCT_PUBLIC_SEPOLICY_DIRS) \
         device/qcom/sepolicy/product/public

    PRODUCT_PRIVATE_SEPOLICY_DIRS := \
        $(PRODUCT_PRIVATE_SEPOLICY_DIRS) \
         device/qcom/sepolicy/product/private

    ifeq ($(TARGET_USES_QCOM_LEGACY_SEPOLICY),true)
        $(warning including latest legacy sepolicy)
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
    else
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
    endif
endif
