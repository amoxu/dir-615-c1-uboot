include $(TOPDIR)/config.mk

LIB	= lib$(BOARD).a

#OBJS	= $(BOARD).o ../common/ar9100_pflash.o ../common/vsc8601_phy.o ../common/generic_spi.o ../common/vsc73xx.o
#OBJS	= $(BOARD).o ../common/ar9100_pflash.o ../common/vsc8601_phy.o

ifneq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)
OBJS	= $(BOARD).o flash.o ../common/ar7100_flash.o ../common/athrs26_phy.o
endif

ifeq ($(ETH_SWITCH), CFG_RTL8366SR_PHY)
OBJS	= $(BOARD).o flash.o ../common/ar7100_flash.o ../common/rtl8366sr_phy.o ../common/rtl8366rb_api.o ../common/rtl8368s_asicdrv.o
endif
SOBJS	= ../common/lowlevel_init_ar9100.o

$(LIB):	.depend $(OBJS) $(SOBJS) $(HTMLOBJS)
	$(AR) crv $@ $(OBJS) $(SOBJS) $(HTMLOBJS)

#########################################################################

.depend:	Makefile $(SOBJS:.o=.S) $(OBJS:.o=.c)
		$(CC) -M $(CFLAGS) $(SOBJS:.o=.S) $(OBJS:.o=.c) > $@

sinclude .depend

#########################################################################
