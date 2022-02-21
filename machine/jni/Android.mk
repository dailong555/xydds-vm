LOCAL_PATH := $(call my-dir)

CORE_DIR    := $(LOCAL_PATH)/..
SOURCE_DIR  := $(CORE_DIR)
INCFLAGS    := -I$(SOURCE_DIR)/../libretro-common/include
INCLUDES    :=
SOURCES_C   :=
SOURCES_CXX :=

include $(CORE_DIR)/Makefile.common

COREFLAGS := -DANDROID -D__LIBRETRO__ -DHAVE_STRINGS_H -DRIGHTSHIFT_IS_SAR $(INCFLAGS)
GIT_VERSION := " $(shell git rev-parse --short HEAD || echo unknown)"
ifneq ($(GIT_VERSION)," unknown")
  COREFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := retro
LOCAL_SRC_FILES := $(SOURCES_C)
LOCAL_CFLAGS    := $(COREFLAGS)
LOCAL_LDFLAGS   := -Wl,-version-script=$(CORE_DIR)/link.T
include $(BUILD_SHARED_LIBRARY)
