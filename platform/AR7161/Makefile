ifdef AP99
#Matrix architecure
ifndef BUILD_TYPE
export BUILD_TYPE=jffs2
endif

all:
	@echo "Making Kernel Build Version $(KERNELVER)"
	cd $(KERNEL_PATH) && $(MAKEARCH)
	cd $(KERNEL_PATH) && $(MAKEARCH) $(KERNELTARGET)
	if [ -f $(KERNEL_PATH)/../../drivers/Makefile ]; then \
                $(MAKE) -C $(KERNEL_PATH)/../../drivers/ ;\
        fi

clean:	
	cd $(KERNEL_PATH) &&  $(MAKEARCH) mrproper
	cd $(KERNEL_PATH)/arch/$(KERNELARCH)/boot && rm -f vmlinux.* && rm -f $(PROJECTS_IMAGE_PATH)/vmlinux.*
	if [ -f $(KERNEL_PATH)/../../drivers/Makefile ]; then \
                $(MAKE) -C $(KERNEL_PATH)/../../drivers/ clean ;\
        fi

install:
	if [ -f $(KERNEL_PATH)/../../drivers/Makefile ]; then \
		$(MAKE) -C $(KERNEL_PATH)/../../drivers/ install ;\
        fi
	if grep -q "CONFIG_MODULES=y" $(KERNEL_PATH)/.config ; then \
                $(MAKE) -C $(KERNEL_PATH) modules_install DEPMOD=/bin/true INSTALL_MOD_PATH=$(FS_PATH) ; \
        fi
	cd $(KERNELPATH)/arch/$(KERNELARCH)/boot && \
	$(LZMA_PATH) e $(KERNELTARGET) vmlinux.lzma -d23 && \
	cp -f vmlinux.lzma $(PROJECTS_IMAGE_PATH)
else
#Eagle architecture

ifndef BOARD_TYPE
#error "You have to define Board Type to use this Makefile"
ifeq ($(PLATFORM), AR7241)
BOARD_TYPE = ap98
else

ifeq ($(PLATFORM), AR9100)
ifeq ($(AP_TYPE), ap81)
BOARD_TYPE = ap81
endif
ifeq ($(AP_TYPE), ap83)
BOARD_TYPE = ap83

ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)	
__ETH_SWITCH__=rtl8366sr
else
__ETH_SWITCH__=aths26
endif ### CFG_RTL8366SR_PHY ###

endif ### ap83 ###	

else
BOARD_TYPE = ap94
endif
endif
endif

ifeq ($(PLATFORM), AR7241)
	__PLATFORM__=AR7161
else
ifeq ($(PLATFORM), AR9100)
    __PLATFORM__=AR7161
else
	__PLATFORM__=$(PLATFORM)
endif
endif


ifndef BUILD_TYPE
export BUILD_TYPE = jffs2
endif

#
# Include the specific configuration files from the config.boardtype file
# here.  This removes the need to set environmental variables through a
# script before building
#

include scripts/$(BOARD_TYPE)/config.$(BOARD_TYPE)

#
# Put in safety checks here to ensure all required variables are defined in
# the configuration file
#

ifndef TOOLPREFIX
$(error "Must specify TOOLPREFIX value")
endif

ifndef TOOLCHAIN
$(error "Must specify TOOLCHAIN value")
endif

ifndef TOOLARCH
$(error "Must specify TOOLARCH value")
endif

ifndef KERNEL
$(error "Must specify KERNEL value")
endif

ifndef KERNELVER
$(error "Must specify KERNELVER value")
endif

ifndef KERNELTARGET
$(error "Must specify KERNELTARGET value")
endif

ifndef KERNELARCH
$(error "Must specify KERNELARCH value")
endif

ifndef TOOLPREFIX
$(error "Must specify TOOLPREFIX value")
endif

ifndef BUSYBOX
$(error "Must specify BUSYBOX value")
endif

ifndef TFTPPATH
export TFTPPATH=/tftpboot/
endif

#
# Other environmental variables that are configured as per the configuration file
# specified above.  These contain all platform specific configuration items.
#

export TOPDIR=$(PWD)
export INSTALL_ROOT=$(TOPDIR)/rootfs.build
export IMAGEPATH=$(TOPDIR)/images/$(BOARD_TYPE)

export STRIP=$(TOOLPREFIX)strip
export KERNELPATH=$(KERNEL_PATH)
export MAKEARCH=$(MAKE) ARCH=$(KERNELARCH) CROSS_COMPILE=$(TOOLPREFIX)

export TOOLPATH=$(TOPDIR)/build/$(TOOLCHAIN)/$(TOOLARCH)/
export BOOTLOADERDIR=$(TOPDIR)/platform/$(__PLATFORM__)/u-boot
export UBOOTDIR=$(TOPDIR)/platform/$(__PLATFORM__)/u-boot

export PATH:=$(TOPDIR)/build/util:$(TOOLPATH)/bin:$(TOPDIR)/linux:$(TOPDIR)/build:$(BOOTLOADERDIR)/ecos/tools/bin:`pwd`:${PATH}


#
# This is to allow the target file system size to be specified on the command
# line, if desired
#

ifndef TARGETFSSIZE
export TARGETFSSIZE=2621440
endif


ENTRY=`readelf -a vmlinux|grep "Entry"|cut -d":" -f 2`
LDADR=`readelf -a vmlinux|grep "\[ 1\]"|cut -d" " -f 26`

#
# Include the board specific make file
#

include scripts/$(BOARD_TYPE)/Makefile.$(BOARD_TYPE)	


redboot_build:
	@echo "redboot_build: $(BOOTLOADERDIR) $(PWD) $(ETH_SWITCH)"
	cd $(BOOTLOADERDIR) && $(MAKEARCH) mrproper
ifeq ($(PLATFORM), AR7241)
	cd $(BOOTLOADERDIR) && $(MAKEARCH) $(BOARD_TYPE)_config _FLASH_SIZE_=8
else
	cd $(BOOTLOADERDIR) && $(MAKEARCH) $(BOARD_TYPE)_config
endif
	cd $(BOOTLOADERDIR) && $(MAKEARCH) all

redboot_clean:
	cd $(BOOTLOADERDIR) && $(MAKEARCH) clean

uboot:
	echo "uboot"
	cd $(UBOOTDIR) && $(MAKEARCH) mrproper
	cd $(UBOOTDIR) && $(MAKEARCH) $(BOARD_TYPE)_config
	cd $(UBOOTDIR) && $(MAKEARCH) all
	cp $(UBOOTDIR)/u-boot.bin ${IMAGEPATH}
	
uboot_clean:
	cd $(BOOTLOADERDIR) && make clean


endif	
