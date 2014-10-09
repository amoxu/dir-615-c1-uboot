include .config

WORKING_DIR	:= $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
export	WORKING_DIR


ENV_PATH=$(WORKING_DIR)
TOOLCHAIN_PATH=$(WORKING_DIR)/toolchain-mips32k

ifeq ($(ENV_PATH),)
$(error "please specify ENV_PATH in .config")
endif

ifeq ($(PLATFORM),)
$(error "please specify PLATFORM in .config")
else
ifeq ($(PLATFORM), AR7241)
	__PLATFORM__=AR7161
else
ifeq ($(PLATFORM), AR9100)
	__PLATFORM__=AR7161
else	
ifeq ($(PLATFORM), AR9344)
ifeq ($(WL_PLATFORM), DB120)
	__PLATFORM__=2.6.31
else
	__PLATFORM__=$(PLATFORM)
endif
else
	__PLATFORM__=$(PLATFORM)
endif
endif
endif
endif

include $(ENV_PATH)/platform/$(__PLATFORM__)/env.mk

export ENV_PATH:= $(ENV_PATH)
export TOOLCHAIN_PATH:=$(TOOLCHAIN_PATH)
export PLATFORM := $(PLATFORM)

ifeq ($(WL_PLATFORM),)
$(error "please specify WL_PLATFORM in .config")
endif
export WL_PLATFORM := $(WL_PLATFORM)

export PRJ_PATH := $(ENV_PATH)
export FS_PATH := $(ENV_PATH)/rootfs/target

ifeq ($(WL_PLATFORM), AP71)	
include Makefile_ap71.inc
endif

ifeq ($(WL_PLATFORM), ap61)	
include Makefile.inc
endif

ifeq ($(WL_PLATFORM), AP81)	
#this inc will export AP_TYPE	
include Makefile_ap81.inc
endif

ifeq ($(WL_PLATFORM), AP83)	
include Makefile_ap83.inc
ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)	
export ETH_SWITCH := $(ETH_SWITCH)
endif
endif

ifeq ($(WL_PLATFORM), AP94)	
include Makefile_ap94.inc
endif

ifeq ($(WL_PLATFORM), AP98)
include Makefile_ap98.inc
endif

ifeq ($(WL_PLATFORM), MV_AP95)	
include Makefile_MV_AP95.inc
endif

ifeq ($(WL_PLATFORM), PB44)	
include Makefile_pb44.inc
endif

ifeq ($(AP_TYPE), AP91)
include Makefile_ap91.inc
endif

ifeq ($(AP_TYPE), AP93)
include Makefile_ap93.inc
endif

ifeq ($(AP_TYPE), AP99)
include Makefile_ap99.inc
endif

ifeq ($(WL_PLATFORM), DB120)
include Makefile_db120.inc
endif

ifneq ($(__PLATFORM__), sl3516)
ifeq ($(LSDK_KERNELVERSION),)
$(error "please specify LSDK_KERNELVERSION in Makefile_xxxx.inc")
endif
endif


ifeq ($(__PLATFORM__), sl3516)
export KERNEL_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/kernels/2.6.15_storlink
export LOADER_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/sl-boot
else
ifeq ($(__PLATFORM__), MV88F6281)	
export KERNEL_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/kernels/arm-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/u-boot
else
ifeq ($(__PLATFORM__), AthSDK_AP61)
export KERNEL_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/kernels/mips-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/redboot_cobra
else
export KERNEL_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/kernels/mips-linux-$(LSDK_KERNELVERSION)
export LOADER_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)/u-boot
endif
endif
endif

export WL_PATH := $(ENV_PATH)/wireless/$(WL_PLATFORM)
export APPS_PATH := $(ENV_PATH)/apps
export IMG_PATH := $(ENV_PATH)/image
export TOOL_PATH := $(ENV_PATH)/tools

ifeq ($(CONFIG_MODEL_NAME),)
$(error "please specify CONFIG_MODEL_NAME in .config")
endif

export WWW_PATH := $(ENV_PATH)/www/$(CONFIG_MODEL_NAME)
export PLATFORM_PATH := $(ENV_PATH)/platform/$(__PLATFORM__)
export PATH:=$(TOOL_PATH):${PATH}

export CONFIG_MODEL_NAME := $(CONFIG_MODEL_NAME)
export CONFIG_MODEL_NAME_NO_DASH := $(shell perl -w $(PRJ_PATH)/tools/split.pl $(CONFIG_MODEL_NAME))

ifeq ($(HARDWARE_ID),)
$(error "please specify HARDWARE_ID in .config")
endif
export HARDWARE_ID := $(HARDWARE_ID)

ifeq ($(APPS_CROSS),)
$(error "please specify APPS_CROSS in .config")
endif
ifeq ($(KRL_CROSS),)
$(error "please specify KRL_CROSS in .config")
endif
ifeq ($(WL_CROSS),)
$(error "please specify WL_CROSS in .config")
endif
export APPS_CROSS := $(APPS_CROSS)
export KRL_CROSS := $(KRL_CROSS)
export WL_CROSS := $(WL_CROSS)

export APPS_CFLAG := $(APPS_CFLAG)
export KRL_CFLAG := $(KRL_CFLAG)
export WL_CFLAG := $(WL_CFLAG)

all: loader


loader:
	$(MAKE) -C platform redboot_build AP_TYPE=$(AP_TYPE) ETH_SWITCH=$(ETH_SWITCH)


clean:
	$(MAKE) -C platform clean

conf mconf:
	$(MAKE) -C config
	@./config/$@ ./config/Config		

menuconfig: mconf

%:
	[ ! -d $* ] || $(MAKE) -C $*

%-clean:
	[ ! -d $* ] || $(MAKE) -C $* clean
		
.PHONY: all clean
