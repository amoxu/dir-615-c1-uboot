#
# (C) Copyright 2004 Atheros Communications, Inc.
# All rights reserved.
#

# Set the HAL directory if you have the HAL sources
ifndef HAL 
export HAL=$(WL_PATH)/802_11/madwifi/hal/main
endif

# Set the Atheros Rate Control directory if you have the proprietary rate control
ifndef ATH_RATE 
export ATH_RATE=$(WL_PATH)/802_11/madwifi/ratectrl
endif

# Set the Phyerr (radar) directory if you have the proprietary phyerr control
ifndef ATH_PHYERR
export ATH_PHYERR=$(WL_PATH)/802_11/madwifi/dfs
endif

ifndef KERNELVERSION 
export LSDK_KERNELVERSION =2.4.25
endif

export KERNELPATH=$(KERNEL_PATH)
export AP_TYPE=ap61
export SOC=1
export BUS=AHB
export TOOLPREFIX := $(KRL_CROSS)
export TOOL_CHAIN_PATH := $(TOOLCHAIN_PATH)
export TOOLPATH=$(TOOL_CHAIN_PATH)/tools/gcc-3.3.3-2.4.25/toolchain_mips
ifndef TFTPPATH
export TFTPPATH=/tftpboot
endif
ifndef INSTALLPATH
export INSTALLPATH=$(KERNELPATH)/install
endif
ifndef TOPDIR
export TOPDIR=$(PWD)/..
endif



