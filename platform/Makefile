export CROSS_COMPILE := $(KRL_CROSS)
export CC := $(CROSS_COMPILE)gcc
export AR := $(CROSS_COMPILE)ar
export AS := $(CROSS_COMPILE)as
export LD := $(CROSS_COMPILE)ld
export NM := $(CROSS_COMPILE)nm
export RANLIB := $(CROSS_COMPILE)ranlib
export STRIP := $(CROSS_COMPILE)strip
export SIZE := $(CROSS_COMPILE)size

ifeq ($(PLATFORM), AR7241)
	__PLATFORM__=AR7161
else
ifeq ($(PLATFORM), AR9100)
	__PLATFORM__=AR7161
else	
ifeq ($(PLATFORM), AR7240)
export __PLATFORM__=2.6.31
else
	__PLATFORM__=$(PLATFORM)
endif
endif
endif

all:

clean:

ifeq ($(PLATFORM), AR7161)	
	cd $(TOOL_PATH)/../tools/lzma/sdk4.17/SRC/7zip/Compress/LZMA_Alone/ && $(MAKE) clean
	make -C ./$(__PLATFORM__) uboot_clean 
endif


config:

redboot_build:
	make -C ./$(__PLATFORM__) redboot_build


redboot_clean:
	make -C ./$(__PLATFORM__) redboot_clean
