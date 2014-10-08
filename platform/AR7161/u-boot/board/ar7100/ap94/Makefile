include $(TOPDIR)/config.mk

LIB	= lib$(BOARD).a
#OBJS	= $(BOARD).o ../common/ar7100_flash.o athrs26_phy.o ap94_pci.o ../common/generic_spi.o
ifneq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)
#	Date:	2010-03-05
#	Name:	Bing Chou
#	Reason:	Added to support AR8021 phy
ifeq ($(ETH_SWITCH), CFG_AR8021_PHY)
OBJS	= $(BOARD).o ../common/ar7100_flash.o ../common/athrf1_phy.o ap94_pci.o ../common/generic_spi.o
else
OBJS	= $(BOARD).o ../common/ar7100_flash.o athrs26_phy.o ap94_pci.o ../common/generic_spi.o
endif
endif
ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)
OBJS	= $(BOARD).o ../common/ar7100_flash.o ../common/rtl8366sr_phy.o ap94_pci.o ../common/generic_spi.o
endif
SOBJS	= lowlevel_init.o

$(LIB):	.depend $(OBJS) $(SOBJS)$(HTMLOBJS)
	$(AR) crv $@ $(OBJS) $(SOBJS)$(HTMLOBJS)

#########################################################################

.depend:	Makefile $(SOBJS:.o=.S) $(OBJS:.o=.c)
		$(CC) -M $(CFLAGS) $(SOBJS:.o=.S) $(OBJS:.o=.c) > $@

sinclude .depend

#########################################################################
