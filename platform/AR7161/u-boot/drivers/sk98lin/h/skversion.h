/******************************************************************************
 *
 * Name:	version.h
 * Project:	GEnesis, PCI Gigabit Ethernet Adapter
 * Version:	$Revision: 1.2 $
 * Date:	$Date: 2010/05/26 07:20:34 $
 * Purpose:	SK specific Error log support
 *
 ******************************************************************************/

/******************************************************************************
 *
 *	(C)Copyright 1998-2003 SysKonnect GmbH.
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 *	The information in this file is provided "AS IS" without warranty.
 *
 ******************************************************************************/

/******************************************************************************
 *
 * History:
 *	$Log: skversion.h,v $
 *	Revision 1.2  2010/05/26 07:20:34  jackey
 *	*** empty log message ***
 *	
 *	Revision 1.3  2009/11/04 10:17:40  anderson_chen
 *	*** empty log message ***
 *	
 *	Revision 1.2  2009/04/14 09:52:27  jackey
 *	*** empty log message ***
 *	
 *	Revision 1.1.1.1  2008/11/17 07:38:12  anderson
 *	Matrix source code
 *	
 *	Revision 1.1.1.1  2008/11/07 10:48:28  jackey
 *	AR7240 source code
 *	
 *	Revision 1.4  2003/02/25 14:16:40  mlindner
 *	Fix: Copyright statement
 *
 *	Revision 1.3  2003/02/25 13:30:18  mlindner
 *	Add: Support for various vendors
 *
 *	Revision 1.1.2.1  2001/09/05 13:38:30  mlindner
 *	Removed FILE description
 *
 *	Revision 1.1  2001/03/06 09:25:00  mlindner
 *	first version
 *
 *
 *
 ******************************************************************************/


static const char SysKonnectFileId[] = "@(#) (C) SysKonnect GmbH.";
static const char SysKonnectBuildNumber[] =
	"@(#)SK-BUILD: 6.05 PL: 01";

#define BOOT_STRING	"sk98lin: Network Device Driver v6.05\n" \
			"(C)Copyright 1999-2003 Marvell(R)."

#define VER_STRING	"6.05"
