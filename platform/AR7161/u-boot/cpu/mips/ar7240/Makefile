include $(TOPDIR)/config.mk

LIB	= lib$(SOC).a

START	=

ifeq ($(BOARD_TYPE), ap121-2MB)
OBJS	= hornet_serial.o hornet_meminit.o hornet_ag7240.o
else
OBJS	= ar7240_serial.o ag7240.o meminit.o
endif

SOBJS	=

all:	.depend $(START) $(LIB)

$(LIB):	$(OBJS) $(SOBJS) $(OBJS-0)
	$(AR) crv $@ $(OBJS) $(SOBJS)

#########################################################################

.depend:	Makefile $(START:.o=.S) $(OBJS:.o=.c)
		$(CC) -M $(CFLAGS) $(START:.o=.S) $(OBJS:.o=.c) > $@

sinclude .depend

#########################################################################
