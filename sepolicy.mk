#
# Copyright (C) 2020 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include Legacy pre-UM Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_PRE_UM_SEPOLICY),true)
    include device/qcom/sepolicy/legacy-pre-um/legacy-pre-um.mk
endif

# Include Legacy UM Makefiles
ifeq ($(TARGET_USES_QCOM_LEGACY_UM_SEPOLICY),true)
    include device/qcom/sepolicy/legacy-um/legacy-um.mk
endif

# Include latest sepolicy
ifeq ($(TARGET_USES_QCOM_LATEST_SEPOLICY),true)
    BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
        device/qcom/sepolicy/generic/public \
        device/qcom/sepolicy/qva/public

    BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
        device/qcom/sepolicy/generic/private \
        device/qcom/sepolicy/qva/private

    PRODUCT_PUBLIC_SEPOLICY_DIRS += \
        device/qcom/sepolicy/product/public

    PRODUCT_PRIVATE_SEPOLICY_DIRS += \
        device/qcom/sepolicy/product/private

    # Include vendor sepolicies only if vendor image is built.
    ifneq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
        ifneq ($(TARGET_USES_QCOM_LEGACY_SEPOLICY),true)
            BOARD_SEPOLICY_DIRS += \
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
            BOARD_SEPOLICY_DIRS += \
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
endif
