#
# Copyright (C) 2017 The Android Open-Source Project
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

LOCAL_PATH := device/google/muskie

# verity
AB_OTA_PARTITIONS += \
    vbmeta

# Audio XMLs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/mixer_paths_tasha.xml:system/etc/mixer_paths_tasha.xml \
    $(LOCAL_PATH)/mixer_paths_tavil.xml:system/etc/mixer_paths_tavil.xml \
    $(LOCAL_PATH)/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio_platform_info_tavil.xml:system/etc/audio_platform_info_tavil.xml \
    $(LOCAL_PATH)/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml

# Enable SM log mechanism by default
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.smlog_switch=1 \
    ro.radio.log_prefix="modem_log_" \
    ro.radio.log_loc="/data/vendor/modem_dump"

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.logging.userdebug.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(PRODUCT_HARDWARE).logging.rc
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.logging.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(PRODUCT_HARDWARE).logging.rc
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init-common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init-$(PRODUCT_HARDWARE).rc \
    $(LOCAL_PATH)/init.common.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.$(PRODUCT_HARDWARE).usb.rc \
    $(LOCAL_PATH)/init.insmod.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.cfg

include device/google/wahoo/device.mk

# Kernel modules
ifeq (,$(filter muskie_clang walleye_clang, $(TARGET_PRODUCT)))
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/synaptics_dsx_core_htc.ko \
    device/google/wahoo-kernel/synaptics_dsx_rmi_dev_htc.ko \
    device/google/wahoo-kernel/synaptics_dsx_fw_update_htc.ko \
    device/google/wahoo-kernel/htc_battery.ko
else
BOARD_VENDOR_KERNEL_MODULES += \
    device/google/wahoo-kernel/clang/synaptics_dsx_core_htc.ko \
    device/google/wahoo-kernel/clang/synaptics_dsx_rmi_dev_htc.ko \
    device/google/wahoo-kernel/clang/synaptics_dsx_fw_update_htc.ko \
    device/google/wahoo-kernel/clang/htc_battery.ko
endif

PRODUCT_COPY_FILES += \
    device/google/muskie/nfc/libnfc-nxp.muskie.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf

PRODUCT_COPY_FILES += \
    device/google/muskie/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf \
    device/google/muskie/thermal-engine-vr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine-vr.conf

# Wifi configuration file
PRODUCT_COPY_FILES += \
    device/google/muskie/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini

#IMU calibration
PRODUCT_COPY_FILES += \
    device/google/muskie/calibration_cad.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/calibration_cad.xml

#IMU calibration
PRODUCT_PROPERTY_OVERRIDES += \
  persist.config.calibration_cad=/vendor/etc/sensors/calibration_cad.xml \
  persist.config.calibration_fac=/persist/sensors/calibration/calibration.xml
