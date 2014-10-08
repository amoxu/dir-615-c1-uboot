#
# (C) Copyright 2004 Atheros Communications, Inc.
# All rights reserved.
#

# Set the HAL directory if you have the HAL sources
ifndef HAL 
#export HAL=$(WL_PATH)/802_11/madwifi/hal/main
export HAL=$(WL_PATH)/802_11
endif

# Set the Atheros Rate Control directory if you have the proprietary rate control
ifndef ATH_RATE 
export ATH_RATE=$(WL_PATH)/802_11/madwifi/ratectrl11n
endif

# Set the Phyerr (radar) directory if you have the proprietary phyerr control
ifndef ATH_PHYERR
export ATH_PHYERR=$(WL_PATH)/802_11/madwifi/dfs
endif

ifndef KERNELVERSION 
export LSDK_KERNELVERSION =2.6.15
endif

export KERNELRELEASE =2.6.15
export MADWIFITARGET=mipsisa32-be-elf 
ifndef MODULEPATH
export MODULEPATH := $(FS_PATH)/lib/modules/$(LSDK_KERNELVERSION)/net
endif

export MAKEARCH=$(MAKE) ARCH=mips CROSS_COMPILE=mips-linux-

#export ATH_CAP_PHYERR_DIAG=1
#export AR5416_G_MODE=1

export KERNELPATH=$(KERNEL_PATH)
export AP_TYPE=ap81
#export SOC=1
export BUS=AHB
export TOOLPREFIX := $(KRL_CROSS)
export TOOLPATH := $(TOOLCHAIN_PATH)/bin
ifndef TFTPPATH
export TFTPPATH=/tftpboot
endif
ifndef INSTALLPATH
export INSTALLPATH=$(KERNELPATH)/install
endif
ifndef TOPDIR
export TOPDIR=$(PWD)/..
endif



