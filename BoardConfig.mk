#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sdm660-common
include device/xiaomi/sdm660-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/whyred

# Boot animation
TARGET_SCREEN_HEIGHT := 2160
TARGET_SCREEN_WIDTH := 1080

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel
TARGET_KERNEL_CONFIG := whyred_defconfig
TARGET_KERNEL_LLVM_BINUTILS := false

# Manifest
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_VENDORIMAGE_PARTITION_SIZE := 838860800
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Security patch level
VENDOR_SECURITY_PATCH := 2018-11-01

# Vendor init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_whyred
TARGET_RECOVERY_DEVICE_MODULES := libinit_whyred

# Inherit the proprietary files
include vendor/xiaomi/whyred/BoardConfigVendor.mk
