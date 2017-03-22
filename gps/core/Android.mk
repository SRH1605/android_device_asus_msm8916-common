ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libloc_core
LOCAL_VENDOR_MODULE := true

LOCAL_MODULE_TAGS := optional

ifeq ($(TARGET_DEVICE),apq8026_lw)
LOCAL_CFLAGS += -DPDK_FEATURE_SET
else ifeq ($(BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET),true)
LOCAL_CFLAGS += -DPDK_FEATURE_SET
endif

ifeq ($(QCPATH),)
LOCAL_CFLAGS += -DOSS_BUILD
endif

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libutils \
    libcutils \
    libgps.utils \
    libdl \
    libprocessgroup

LOCAL_SRC_FILES += \
    LocApiBase.cpp \
    LocAdapterBase.cpp \
    ContextBase.cpp \
    LocDualContext.cpp \
    loc_core_log.cpp

LOCAL_CFLAGS += \
     -fno-short-enums \
     -D_ANDROID_ \
     -O3

LOCAL_C_INCLUDES:= \
    $(TARGET_OUT_HEADERS)/gps.utils \
    $(TARGET_OUT_HEADERS)/libflp

LOCAL_HEADER_LIBRARIES := libutils_headers

LOCAL_COPY_HEADERS_TO:= libloc_core/
LOCAL_COPY_HEADERS:= \
    LocApiBase.h \
    LocAdapterBase.h \
    ContextBase.h \
    LocDualContext.h \
    LBSProxyBase.h \
    UlpProxyBase.h \
    gps_extended_c.h \
    gps_extended.h \
    loc_core_log.h \
    LocAdapterProxyBase.h

LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
