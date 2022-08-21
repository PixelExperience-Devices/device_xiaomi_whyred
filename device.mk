#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sdm660-common
$(call inherit-product, device/xiaomi/sdm660-common/sdm660.mk)

DEVICE_PATH := device/xiaomi/whyred

# PRODUCT_SHIPPING_API_LEVEL indicates the first api level, device has been commercially launched on.
PRODUCT_SHIPPING_API_LEVEL := 27

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_intcodec.xml \
    $(DEVICE_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml

# Consumerir
BOARD_HAVE_IR := true

# FM
BOARD_HAVE_QCOM_FM := true

# Gatekeeper HAL
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.gatekeeper@1.0-service

# Google camera
PRODUCT_PACKAGES += \
    GoogleCameraGo

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/GoogleCameraGo/permissions/com.google.android.GoogleCameraGo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.google.android.GoogleCameraGo.xml \
    $(LOCAL_PATH)/GoogleCameraGo/configs/hiddenapi-package-whitelist-GoogleCameraGo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hiddenapi-package-whitelist-GoogleCameraGo.xml

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0.vendor \
    android.hardware.keymaster@3.0-service

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-pe

# Powerhint
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.device.rc

# Shims
PRODUCT_PACKAGES += \
    libcamera_sdm660_shim \
    libmiwatermark_shim

# Thermal
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Wifi
PRODUCT_PACKAGES += \
    WhyredWifiOverlay

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/whyred/whyred-vendor.mk)
