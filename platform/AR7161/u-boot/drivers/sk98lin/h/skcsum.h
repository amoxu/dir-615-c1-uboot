/******************************************************************************
 *
 * Name:	skcsum.h
 * Project:	GEnesis - SysKonnect SK-NET Gigabit Ethernet (SK-98xx)
 * Version:	$Revision: 1.2 $
 * Date:	$Date: 2010/05/26 07:20:34 $
 * Purpose:	Store/verify Internet checksum in send/receive packets.
 *
 ******************************************************************************/

/******************************************************************************
 *
 *	(C)Copyright 1998-2001 SysKonnect GmbH.
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
 *
 *	$Log: skcsum.h,v $
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
 *	Revision 1.9  2001/02/06 11:21:39  rassmann
 *	Editorial changes.
 *
 *	Revision 1.8  2001/02/06 11:15:36  rassmann
 *	Supporting two nets on dual-port adapters.
 *
 *	Revision 1.7  2000/06/29 13:17:05  rassmann
 *	Corrected reception of a packet with UDP checksum == 0 (which means there
 *	is no UDP checksum).
 *
 *	Revision 1.6  2000/02/28 12:33:44  cgoos
 *	Changed C++ style comments to C style.
 *
 *	Revision 1.5  2000/02/21 12:10:05  cgoos
 *	Fixed license comment.
 *
 *	Revision 1.4  2000/02/21 11:08:37  cgoos
 *	Merged changes back into common source.
 *
 *	Revision 1.1  1999/07/26 14:47:49  mkarl
 *	changed from common source to windows specific source
 *	added return SKCS_STATUS_IP_CSUM_ERROR_UDP and
 *	SKCS_STATUS_IP_CSUM_ERROR_TCP to pass the NidsTester
 *	changes for Tx csum offload
 *
 *	Revision 1.2  1998/09/04 12:16:34  mhaveman
 *	Checked in for Stephan to allow compilation.
 *	-Added definition SK_CSUM_EVENT_CLEAR_PROTO_STATS to clear statistic
 *	-Added prototype for SkCsEvent()
 *
 *	Revision 1.1  1998/09/01 15:36:53  swolf
 *	initial revision
 *
 *	01-Sep-1998 sw	Created.
 *
 ******************************************************************************/

/******************************************************************************
 *
 * Description:
 *
 * Public header file for the "GEnesis" common module "CSUM".
 *
 * "GEnesis" is an abbreviation of "Gigabit Ethernet Network System in Silicon"
 * and is the code name of this SysKonnect project.
 *
 * Compilation Options:
 *
 *	SK_USE_CSUM - Define if CSUM is to be used. Otherwise, CSUM will be an
 *	empty module.
 *
 *	SKCS_OVERWRITE_PROTO - Define to overwrite the default protocol id
 *	definitions. In this case, all SKCS_PROTO_xxx definitions must be made
 *	external.
 *
 *	SKCS_OVERWRITE_STATUS - Define to overwrite the default return status
 *	definitions. In this case, all SKCS_STATUS_xxx definitions must be made
 *	external.
 *
 * Include File Hierarchy:
 *
 *	"h/skcsum.h"
 *	 "h/sktypes.h"
 *	 "h/skqueue.h"
 *
 ******************************************************************************/

#ifndef __INC_SKCSUM_H
#define __INC_SKCSUM_H

#include "h/sktypes.h"
#include "h/skqueue.h"

/* defines ********************************************************************/

/*
 * Define the default bit flags for 'SKCS_PACKET_INFO.ProtocolFlags'  if no user
 * overwrite.
 */
#ifndef SKCS_OVERWRITE_PROTO	/* User overwrite? */
#define SKCS_PROTO_IP	0x1	/* IP (Internet Protocol version 4) */
#define SKCS_PROTO_TCP	0x2	/* TCP (Transmission Control Protocol) */
#define SKCS_PROTO_UDP	0x4	/* UDP (User Datagram Protocol) */

/* Indices for protocol statistics. */
#define SKCS_PROTO_STATS_IP	0
#define SKCS_PROTO_STATS_UDP	1
#define SKCS_PROTO_STATS_TCP	2
#define SKCS_NUM_PROTOCOLS	3	/* Number of supported protocols. */
#endif	/* !SKCS_OVERWRITE_PROTO */

/*
 * Define the default SKCS_STATUS type and values if no user overwrite.
 *
 *	SKCS_STATUS_UNKNOWN_IP_VERSION - Not an IP v4 frame.
 *	SKCS_STATUS_IP_CSUM_ERROR - IP checksum error.
 *	SKCS_STATUS_IP_CSUM_ERROR_TCP - IP checksum error in TCP frame.
 *	SKCS_STATUS_IP_CSUM_ERROR_UDP - IP checksum error in UDP frame
 *	SKCS_STATUS_IP_FRAGMENT - IP fragment (IP checksum ok).
 *	SKCS_STATUS_IP_CSUM_OK - IP checksum ok (not a TCP or UDP frame).
 *	SKCS_STATUS_TCP_CSUM_ERROR - TCP checksum error (IP checksum ok).
 *	SKCS_STATUS_UDP_CSUM_ERROR - UDP checksum error (IP checksum ok).
 *	SKCS_STATUS_TCP_CSUM_OK - IP and TCP checksum ok.
 *	SKCS_STATUS_UDP_CSUM_OK - IP and UDP checksum ok.
 *	SKCS_STATUS_IP_CSUM_OK_NO_UDP - IP checksum OK and no UDP checksum.
 */
#ifndef SKCS_OVERWRITE_STATUS	/* User overwrite? */
#define SKCS_STATUS	int	/* Define status type. */

#define SKCS_STATUS_UNKNOWN_IP_VERSION	1
#define SKCS_STATUS_IP_CSUM_ERROR		2
#define SKCS_STATUS_IP_FRAGMENT			3
#define SKCS_STATUS_IP_CSUM_OK			4
#define SKCS_STATUS_TCP_CSUM_ERROR		5
#define SKCS_STATUS_UDP_CSUM_ERROR		6
#define SKCS_STATUS_TCP_CSUM_OK			7
#define SKCS_STATUS_UDP_CSUM_OK			8
/* needed for Microsoft */
#define SKCS_STATUS_IP_CSUM_ERROR_UDP	9
#define SKCS_STATUS_IP_CSUM_ERROR_TCP	10
/* UDP checksum may be omitted */
#define SKCS_STATUS_IP_CSUM_OK_NO_UDP	11
#endif	/* !SKCS_OVERWRITE_STATUS */

/* Clear protocol statistics event. */
#define SK_CSUM_EVENT_CLEAR_PROTO_STATS	1

/*
 * Add two values in one's complement.
 *
 * Note: One of the two input values may be "longer" than 16-bit, but then the
 * resulting sum may be 17 bits long. In this case, add zero to the result using
 * SKCS_OC_ADD() again.
 *
 *	Result = Value1 + Value2
 */
#define SKCS_OC_ADD(Result, Value1, Value2) {				\
	unsigned long Sum;						\
									\
	Sum = (unsigned long) (Value1) + (unsigned long) (Value2);	\
	/* Add-in any carry. */						\
	(Result) = (Sum & 0xffff) + (Sum >> 16);			\
}

/*
 * Subtract two values in one's complement.
 *
 *	Result = Value1 - Value2
 */
#define SKCS_OC_SUB(Result, Value1, Value2)	\
	SKCS_OC_ADD((Result), (Value1), ~(Value2) & 0xffff)

/* typedefs *******************************************************************/

/*
 * SKCS_PROTO_STATS - The CSUM protocol statistics structure.
 *
 * There is one instance of this structure for each protocol supported.
 */
typedef struct s_CsProtocolStatistics {
	SK_U64 RxOkCts;		/* Receive checksum ok. */
	SK_U64 RxUnableCts;	/* Unable to verify receive checksum. */
	SK_U64 RxErrCts;	/* Receive checksum error. */
	SK_U64 TxOkCts;		/* Transmit checksum ok. */
	SK_U64 TxUnableCts;	/* Unable to calculate checksum in hw. */
} SKCS_PROTO_STATS;

/*
 * s_Csum - The CSUM module context structure.
 */
typedef struct s_Csum {
	/* Enabled receive SK_PROTO_XXX bit flags. */
	unsigned ReceiveFlags[SK_MAX_NETS];
#ifdef TX_CSUM
	unsigned TransmitFlags[SK_MAX_NETS];
#endif /* TX_CSUM */

	/* The protocol statistics structure; one per supported protocol. */
	SKCS_PROTO_STATS ProtoStats[SK_MAX_NETS][SKCS_NUM_PROTOCOLS];
} SK_CSUM;

/*
 * SKCS_PACKET_INFO - The packet information structure.
 */
typedef struct s_CsPacketInfo {
	/* Bit field specifiying the desired/found protocols. */
	unsigned ProtocolFlags;

	/* Length of complete IP header, including any option fields. */
	unsigned IpHeaderLength;

	/* IP header checksum. */
	unsigned IpHeaderChecksum;

	/* TCP/UDP pseudo header checksum. */
	unsigned PseudoHeaderChecksum;
} SKCS_PACKET_INFO;

/* function prototypes ********************************************************/

#ifndef SkCsCalculateChecksum
extern unsigned SkCsCalculateChecksum(
	void		*pData,
	unsigned	Length);
#endif

extern int SkCsEvent(
	SK_AC		*pAc,
	SK_IOC		Ioc,
	SK_U32		Event,
	SK_EVPARA	Param);

extern SKCS_STATUS SkCsGetReceiveInfo(
	SK_AC		*pAc,
	void		*pIpHeader,
	unsigned	Checksum1,
	unsigned	Checksum2,
	int			NetNumber);

extern void SkCsGetSendInfo(
	SK_AC				*pAc,
	void				*pIpHeader,
	SKCS_PACKET_INFO	*pPacketInfo,
	int					NetNumber);

extern void SkCsSetReceiveFlags(
	SK_AC		*pAc,
	unsigned	ReceiveFlags,
	unsigned	*pChecksum1Offset,
	unsigned	*pChecksum2Offset,
	int			NetNumber);

#endif	/* __INC_SKCSUM_H */
