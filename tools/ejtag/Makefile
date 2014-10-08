#
# (C) Copyright 2004 Atheros Communications, Inc.
# All rights reserved.
#
# $Id: Makefile,v 1.1.1.1 2007/04/04 11:39:24 albert Exp $
# $File: //depot/sw/releases/linux_5.0.1/tools/ejtag/Makefile $
# $Author: albert $
# $DateTime: 2006/01/09 19:29:24 $
# $Change: 159403 $
#
include ${ATH_ROOT}/make/includes.mk

DIRS    = ejtag_client gdbstub

prep::

build::
	for dir in ${DIRS} ; do \
		(cd $$dir; make) \
	done;

install::

clean::
	for dir in ${DIRS} ; do \
		(cd $$dir; make clean) \
	done;
