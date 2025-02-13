/******************************************************************************
 *
 * Name:	skgeinit.c
 * Project:	GEnesis, PCI Gigabit Ethernet Adapter
 * Version:	$Revision: 1.2 $
 * Date:	$Date: 2010/05/26 07:20:33 $
 * Purpose:	Contains functions to initialize the GE HW
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
 *
 *	$Log: skgeinit.c,v $
 *	Revision 1.2  2010/05/26 07:20:33  jackey
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
 *	Revision 1.85  2003/02/05 15:30:33  rschmidt
 *	Corrected setting of GIHstClkFact (Host Clock Factor) and
 *	GIPollTimerVal (Descr. Poll Timer Init Value) for YUKON.
 *	Editorial changes.
 *
 *	Revision 1.84  2003/01/28 09:57:25  rschmidt
 *	Added detection of YUKON-Lite Rev. A0 (stored in GIYukonLite).
 *	Disabled Rx GMAC FIFO Flush for YUKON-Lite Rev. A0.
 *	Added support for CLK_RUN (YUKON-Lite).
 *	Added additional check of PME from D3cold for setting GIVauxAvail.
 *	Editorial changes.
 *
 *	Revision 1.83  2002/12/17 16:15:41  rschmidt
 *	Added default setting of PhyType (Copper) for YUKON.
 *	Added define around check for HW self test results.
 *	Editorial changes.
 *
 *	Revision 1.82  2002/12/05 13:40:21  rschmidt
 *	Added setting of Rx GMAC FIFO Flush Mask register.
 *	Corrected PhyType with new define SK_PHY_MARV_FIBER when
 *	YUKON Fiber board was found.
 *	Editorial changes.
 *
 *	Revision 1.81  2002/11/15 12:48:35  rschmidt
 *	Replaced message SKERR_HWI_E018 with SKERR_HWI_E024 for Rx queue error
 *	in SkGeStopPort().
 *	Added init for pAC->GIni.GIGenesis with SK_FALSE in YUKON-branch.
 *	Editorial changes.
 *
 *	Revision 1.80  2002/11/12 17:28:30  rschmidt
 *	Initialized GIPciSlot64 and GIPciClock66 in SkGeInit1().
 *	Reduced PCI FIFO watermarks for 32bit/33MHz bus in SkGeInitBmu().
 *	Editorial changes.
 *
 *	Revision 1.79  2002/10/21 09:31:02  mkarl
 *	Changed SkGeInitAssignRamToQueues(), removed call to
 *	SkGeInitAssignRamToQueues in SkGeInit1 and fixed compiler warning in
 *	SkGeInit1.
 *
 *	Revision 1.78  2002/10/16 15:55:07  mkarl
 *	Fixed a bug in SkGeInitAssignRamToQueues.
 *
 *	Revision 1.77  2002/10/14 15:07:22  rschmidt
 *	Corrected timeout handling for Rx queue in SkGeStopPort() (#10748)
 *	Editorial changes.
 *
 *	Revision 1.76  2002/10/11 09:24:38  mkarl
 *	Added check for HW self test results.
 *
 *	Revision 1.75  2002/10/09 16:56:44  mkarl
 *	Now call SkGeInitAssignRamToQueues() in Init Level 1 in order to assign
 *	the adapter memory to the queues. This default assignment is not suitable
 *	for dual net mode.
 *
 *	Revision 1.74  2002/09/12 08:45:06  rwahl
 *	Set defaults for PMSCap, PLinkSpeed & PLinkSpeedCap dependent on PHY.
 *
 *	Revision 1.73  2002/08/16 15:19:45  rschmidt
 *	Corrected check for Tx queues in SkGeCheckQSize().
 *	Added init for new entry GIGenesis and GICopperType
 *	Replaced all if(GIChipId == CHIP_ID_GENESIS) with new entry GIGenesis.
 *	Replaced wrong 1st para pAC with IoC in SK_IN/OUT macros.
 *
 *	Revision 1.72  2002/08/12 13:38:55  rschmidt
 *	Added check if VAUX is available (stored in GIVauxAvail)
 *	Initialized PLinkSpeedCap in Port struct with SK_LSPEED_CAP_1000MBPS
 *	Editorial changes.
 *
 *	Revision 1.71  2002/08/08 16:32:58  rschmidt
 *	Added check for Tx queues in SkGeCheckQSize().
 *	Added start of Time Stamp Timer (YUKON) in SkGeInit2().
 *	Editorial changes.
 *
 *	Revision 1.70  2002/07/23 16:04:26  rschmidt
 *	Added init for GIWolOffs (HW-Bug in YUKON 1st rev.)
 *	Minor changes
 *
 *	Revision 1.69  2002/07/17 17:07:08  rwahl
 *	- SkGeInit1(): fixed PHY type debug output; corrected init of GIFunc
 *	  table & GIMacType.
 *	- Editorial changes.
 *
 *	Revision 1.68  2002/07/15 18:38:31  rwahl
 *	Added initialization for MAC type dependent function table.
 *
 *	Revision 1.67  2002/07/15 15:45:39  rschmidt
 *	Added Tx Store & Forward for YUKON (GMAC Tx FIFO is only 1 kB)
 *	Replaced SK_PHY_MARV by SK_PHY_MARV_COPPER
 *	Editorial changes
 *
 *	Revision 1.66  2002/06/10 09:35:08  rschmidt
 *	Replaced C++ comments (//)
 *	Editorial changes
 *
 *	Revision 1.65  2002/06/05 08:33:37  rschmidt
 *	Changed GIRamSize and Reset sequence for YUKON.
 *	SkMacInit() replaced by SkXmInitMac() resp. SkGmInitMac()
 *
 *	Revision 1.64  2002/04/25 13:03:20  rschmidt
 *	Changes for handling YUKON.
 *	Removed reference to xmac_ii.h (not necessary).
 *	Moved all defines into header file.
 *	Replaced all SkXm...() functions with SkMac...() to handle also
 *	YUKON's GMAC.
 *	Added handling for GMAC FIFO in SkGeInitMacFifo(), SkGeStopPort().
 *	Removed 'goto'-directive from SkGeCfgSync(), SkGeCheckQSize().
 *	Replaced all XMAC-access macros by functions: SkMacRxTxDisable(),
 *	SkMacFlushTxFifo().
 *	Optimized timeout handling in SkGeStopPort().
 *	Initialized PLinkSpeed in Port struct with SK_LSPEED_AUTO.
 *	Release of GMAC Link Control reset in SkGeInit1().
 *	Initialized GIChipId and GIChipRev in GE Init structure.
 *	Added GIRamSize and PhyType values for YUKON.
 *	Removed use of PRxCmd to setup XMAC.
 *	Moved setting of XM_RX_DIS_CEXT to SkXmInitMac().
 *	Use of SkGeXmitLED() only for GENESIS.
 *	Changes for V-CPU support.
 *	Editorial changes.
 *
 *	Revision 1.63  2001/04/05 11:02:09  rassmann
 *	Stop Port check of the STOP bit did not take 2/18 sec as wanted.
 *
 *	Revision 1.62  2001/02/07 07:54:21  rassmann
 *	Corrected copyright.
 *
 *	Revision 1.61  2001/01/31 15:31:40  gklug
 *	fix: problem with autosensing an SR8800 switch
 *
 *	Revision 1.60  2000/10/18 12:22:21  cgoos
 *	Added workaround for half duplex hangup.
 *
 *	Revision 1.59  2000/10/10 11:22:06  gklug
 *	add: in manual half duplex mode ignore carrier extension errors
 *
 *	Revision 1.58  2000/10/02 14:10:27  rassmann
 *	Reading BCOM PHY after releasing reset until it returns a valid value.
 *
 *	Revision 1.57  2000/08/03 14:55:28  rassmann
 *	Waiting for I2C to be ready before de-initializing adapter
 *	(prevents sensors from hanging up).
 *
 *	Revision 1.56  2000/07/27 12:16:48  gklug
 *	fix: Stop Port check of the STOP bit does now take 2/18 sec as wanted
 *
 *	Revision 1.55  1999/11/22 13:32:26  cgoos
 *	Changed license header to GPL.
 *
 *	Revision 1.54  1999/10/26 07:32:54  malthoff
 *	Initialize PHWLinkUp with SK_FALSE. Required for Diagnostics.
 *
 *	Revision 1.53  1999/08/12 19:13:50  malthoff
 *	Fix for 1000BT. Do not owerwrite XM_MMU_CMD when
 *	disabling receiver and transmitter. Other bits
 *	may be lost.
 *
 *	Revision 1.52  1999/07/01 09:29:54  gklug
 *	fix: DoInitRamQueue needs pAC
 *
 *	Revision 1.51  1999/07/01 08:42:21  gklug
 *	chg: use Store & forward for RAM buffer when Jumbos are used
 *
 *	Revision 1.50  1999/05/27 13:19:38  cgoos
 *	Added Tx PCI watermark initialization.
 *	Removed Tx RAM queue Store & Forward setting.
 *
 *	Revision 1.49  1999/05/20 14:32:45  malthoff
 *	SkGeLinkLED() is completly removed now.
 *
 *	Revision 1.48  1999/05/19 07:28:24  cgoos
 *	SkGeLinkLED no more available for drivers.
 *	Changes for 1000Base-T.
 *
 *	Revision 1.47  1999/04/08 13:57:45  gklug
 *	add: Init of new port struct fiels PLinkResCt
 *	chg: StopPort Timer check
 *
 *	Revision 1.46  1999/03/25 07:42:15  malthoff
 *	SkGeStopPort(): Add workaround for cache incoherency.
 *			Create error log entry, disable port, and
 *			exit loop if it does not terminate.
 *	Add XM_RX_LENERR_OK to the default value for the
 *	XMAC receive command register.
 *
 *	Revision 1.45  1999/03/12 16:24:47  malthoff
 *	Remove PPollRxD and PPollTxD.
 *	Add check for GIPollTimerVal.
 *
 *	Revision 1.44  1999/03/12 13:40:23  malthoff
 *	Fix: SkGeXmitLED(), SK_LED_TST mode does not work.
 *	Add: Jumbo frame support.
 *	Chg: Resolution of parameter IntTime in SkGeCfgSync().
 *
 *	Revision 1.43  1999/02/09 10:29:46  malthoff
 *	Bugfix: The previous modification again also for the second location.
 *
 *	Revision 1.42  1999/02/09 09:35:16  malthoff
 *	Bugfix: The bits '66 MHz Capable' and 'NEWCAP are reset while
 *		clearing the error bits in the PCI status register.
 *
 *	Revision 1.41  1999/01/18 13:07:02  malthoff
 *	Bugfix: Do not use CFG cycles after during Init- or Runtime, because
 *		they may not be available after Boottime.
 *
 *	Revision 1.40  1999/01/11 12:40:49  malthoff
 *	Bug fix: PCI_STATUS: clearing error bits sets the UDF bit.
 *
 *	Revision 1.39  1998/12/11 15:17:33  gklug
 *	chg: Init LipaAutoNeg with Unknown
 *
 *	Revision 1.38  1998/12/10 11:02:57  malthoff
 *	Disable Error Log Message when calling SkGeInit(level 2)
 *	more than once.
 *
 *	Revision 1.37  1998/12/07 12:18:25  gklug
 *	add: refinement of autosense mode: take into account the autoneg cap of LiPa
 *
 *	Revision 1.36  1998/12/07 07:10:39  gklug
 *	fix: init values of LinkBroken/ Capabilities for management
 *
 *	Revision 1.35  1998/12/02 10:56:20  gklug
 *	fix: do NOT init LoinkSync Counter.
 *
 *	Revision 1.34  1998/12/01 10:53:21  gklug
 *	add: init of additional Counters for workaround
 *
 *	Revision 1.33  1998/12/01 10:00:49  gklug
 *	add: init PIsave var in Port struct
 *
 *	Revision 1.32  1998/11/26 14:50:40  gklug
 *	chg: Default is autosensing with AUTOFULL mode
 *
 *	Revision 1.31  1998/11/25 15:36:16  gklug
 *	fix: do NOT stop LED Timer when port should be stopped
 *
 *	Revision 1.30  1998/11/24 13:15:28  gklug
 *	add: Init PCkeckPar struct member
 *
 *	Revision 1.29  1998/11/18 13:19:27  malthoff
 *	Disable packet arbiter timeouts on receive side.
 *	Use maximum timeout value for packet arbiter
 *	transmit timeouts.
 *	Add TestStopBit() function to handle stop RX/TX
 *	problem with active descriptor poll timers.
 *	Bug Fix: Descriptor Poll Timer not started, because
 *	GIPollTimerVal was initialized with 0.
 *
 *	Revision 1.28  1998/11/13 14:24:26  malthoff
 *	Bug Fix: SkGeStopPort() may hang if a Packet Arbiter Timout
 *	is pending or occurs while waiting for TX_STOP and RX_STOP.
 *	The PA timeout is cleared now while waiting for TX- or RX_STOP.
 *
 *	Revision 1.27  1998/11/02 11:04:36  malthoff
 *	fix the last fix
 *
 *	Revision 1.26  1998/11/02 10:37:03  malthoff
 *	Fix: SkGePollTxD() enables always the synchronounous poll timer.
 *
 *	Revision 1.25  1998/10/28 07:12:43  cgoos
 *	Fixed "LED_STOP" in SkGeLnkSyncCnt, "== SK_INIT_IO" in SkGeInit.
 *	Removed: Reset of RAM Interface in SkGeStopPort.
 *
 *	Revision 1.24  1998/10/27 08:13:12  malthoff
 *	Remove temporary code.
 *
 *	Revision 1.23  1998/10/26 07:45:03  malthoff
 *	Add Address Calculation Workaround: If the EPROM byte
 *	Id is 3, the address offset is 512 kB.
 *	Initialize default values for PLinkMode and PFlowCtrlMode.
 *
 *	Revision 1.22  1998/10/22 09:46:47  gklug
 *	fix SysKonnectFileId typo
 *
 *	Revision 1.21  1998/10/20 12:11:56  malthoff
 *	Don't dendy the Queue config if the size of the unused
 *	Rx qeueu is zero.
 *
 *	Revision 1.20  1998/10/19 07:27:58  malthoff
 *	SkGeInitRamIface() is public to be called by diagnostics.
 *
 *	Revision 1.19  1998/10/16 13:33:45  malthoff
 *	Fix: enabling descriptor polling is not allowed until
 *	the descriptor addresses are set. Descriptor polling
 *	must be handled by the driver.
 *
 *	Revision 1.18  1998/10/16 10:58:27  malthoff
 *	Remove temp. code for Diag prototype.
 *	Remove lint warning for dummy reads.
 *	Call SkGeLoadLnkSyncCnt() during SkGeInitPort().
 *
 *	Revision 1.17  1998/10/14 09:16:06  malthoff
 *	Change parameter LimCount and programming of
 *	the limit counter in SkGeCfgSync().
 *
 *	Revision 1.16  1998/10/13 09:21:16  malthoff
 *	Don't set XM_RX_SELF_RX in RxCmd Reg, because it's
 *	like a Loopback Mode in half duplex.
 *
 *	Revision 1.15  1998/10/09 06:47:40  malthoff
 *	SkGeInitMacArb(): set recovery counters init value
 *	to zero although this counters are not uesd.
 *	Bug fix in Rx Upper/Lower Pause Threshold calculation.
 *	Add XM_RX_SELF_RX to RxCmd.
 *
 *	Revision 1.14  1998/10/06 15:15:53  malthoff
 *	Make sure no pending IRQ is cleared in SkGeLoadLnkSyncCnt().
 *
 *	Revision 1.13  1998/10/06 14:09:36  malthoff
 *	Add SkGeLoadLnkSyncCnt(). Modify
 *	the 'port stopped' condition according
 *	to the current problem report.
 *
 *	Revision 1.12  1998/10/05 08:17:21  malthoff
 *	Add functions: SkGePollRxD(), SkGePollTxD(),
 *	DoCalcAddr(), SkGeCheckQSize(),
 *	DoInitRamQueue(), and SkGeCfgSync().
 *	Add coding for SkGeInitMacArb(), SkGeInitPktArb(),
 *	SkGeInitMacFifo(), SkGeInitRamBufs(),
 *	SkGeInitRamIface(), and SkGeInitBmu().
 *
 *	Revision 1.11  1998/09/29 08:26:29  malthoff
 *	bug fix: SkGeInit0() 'i' should be increment.
 *
 *	Revision 1.10  1998/09/28 13:19:01  malthoff
 *	Coding time: Save the done work.
 *	Modify SkGeLinkLED(), add SkGeXmitLED(),
 *	define SkGeCheckQSize(), SkGeInitMacArb(),
 *	SkGeInitPktArb(), SkGeInitMacFifo(),
 *	SkGeInitRamBufs(), SkGeInitRamIface(),
 *	and SkGeInitBmu(). Do coding for SkGeStopPort(),
 *	SkGeInit1(), SkGeInit2(), and SkGeInit3().
 *	Do coding for SkGeDinit() and SkGeInitPort().
 *
 *	Revision 1.9  1998/09/16 14:29:05  malthoff
 *	Some minor changes.
 *
 *	Revision 1.8  1998/09/11 05:29:14  gklug
 *	add: init state of a port
 *
 *	Revision 1.7  1998/09/04 09:26:25  malthoff
 *	Short temporary modification.
 *
 *	Revision 1.6  1998/09/04 08:27:59  malthoff
 *	Remark the do-while in StopPort() because it never ends
 *	without a GE adapter.
 *
 *	Revision 1.5  1998/09/03 14:05:45  malthoff
 *	Change comment for SkGeInitPort(). Do not
 *	repair the queue sizes if invalid.
 *
 *	Revision 1.4  1998/09/03 10:03:19  malthoff
 *	Implement the new interface according to the
 *	reviewed interface specification.
 *
 *	Revision 1.3  1998/08/19 09:11:25  gklug
 *	fix: struct are removed from c-source (see CCC)
 *
 *	Revision 1.2  1998/07/28 12:33:58  malthoff
 *	Add 'IoC' parameter in function declaration and SK IO macros.
 *
 *	Revision 1.1  1998/07/23 09:48:57  malthoff
 *	Creation. First dummy 'C' file.
 *	SkGeInit(Level 0) is card_start for GE.
 *	SkGeDeInit() is card_stop for GE.
 *
 *
 ******************************************************************************/

#include <config.h>

#ifdef CONFIG_SK98

#include "h/skdrv1st.h"
#include "h/skdrv2nd.h"

/* global variables ***********************************************************/

/* local variables ************************************************************/

static const char SysKonnectFileId[] =
	"@(#)$Id: skgeinit.c,v 1.2 2010/05/26 07:20:33 jackey Exp $ (C) SK ";

struct s_QOffTab {
	int	RxQOff;		/* Receive Queue Address Offset */
	int	XsQOff;		/* Sync Tx Queue Address Offset */
	int	XaQOff;		/* Async Tx Queue Address Offset */
};
static struct s_QOffTab QOffTab[] = {
	{Q_R1, Q_XS1, Q_XA1}, {Q_R2, Q_XS2, Q_XA2}
};


/******************************************************************************
 *
 *	SkGePollRxD() - Enable / Disable Descriptor Polling of RxD Ring
 *
 * Description:
 *	Enable or disable the descriptor polling of the receive descriptor
 *	ring (RxD) for port 'Port'.
 *	The new configuration is *not* saved over any SkGeStopPort() and
 *	SkGeInitPort() calls.
 *
 * Returns:
 *	nothing
 */
void SkGePollRxD(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port,		/* Port Index (MAC_1 + n) */
SK_BOOL PollRxD)	/* SK_TRUE (enable pol.), SK_FALSE (disable pol.) */
{
	SK_GEPORT *pPrt;

	pPrt = &pAC->GIni.GP[Port];

	SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_CSR), (PollRxD) ?
		CSR_ENA_POL : CSR_DIS_POL);
}	/* SkGePollRxD */


/******************************************************************************
 *
 *	SkGePollTxD() - Enable / Disable Descriptor Polling of TxD Rings
 *
 * Description:
 *	Enable or disable the descriptor polling of the transmit descriptor
 *	ring(s) (TxD) for port 'Port'.
 *	The new configuration is *not* saved over any SkGeStopPort() and
 *	SkGeInitPort() calls.
 *
 * Returns:
 *	nothing
 */
void SkGePollTxD(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port,		/* Port Index (MAC_1 + n) */
SK_BOOL PollTxD)	/* SK_TRUE (enable pol.), SK_FALSE (disable pol.) */
{
	SK_GEPORT *pPrt;
	SK_U32	DWord;

	pPrt = &pAC->GIni.GP[Port];

	DWord = (PollTxD) ? CSR_ENA_POL : CSR_DIS_POL;

	if (pPrt->PXSQSize != 0) {
		SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_CSR), DWord);
	}

	if (pPrt->PXAQSize != 0) {
		SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_CSR), DWord);
	}
}	/* SkGePollTxD */


/******************************************************************************
 *
 *	SkGeYellowLED() - Switch the yellow LED on or off.
 *
 * Description:
 *	Switch the yellow LED on or off.
 *
 * Note:
 *	This function may be called any time after SkGeInit(Level 1).
 *
 * Returns:
 *	nothing
 */
void SkGeYellowLED(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		State)		/* yellow LED state, 0 = OFF, 0 != ON */
{
	if (State == 0) {
		/* Switch yellow LED OFF */
		SK_OUT8(IoC, B0_LED, LED_STAT_OFF);
	}
	else {
		/* Switch yellow LED ON */
		SK_OUT8(IoC, B0_LED, LED_STAT_ON);
	}
}	/* SkGeYellowLED */


/******************************************************************************
 *
 *	SkGeXmitLED() - Modify the Operational Mode of a transmission LED.
 *
 * Description:
 *	The Rx or Tx LED which is specified by 'Led' will be
 *	enabled, disabled or switched on in test mode.
 *
 * Note:
 *	'Led' must contain the address offset of the LEDs INI register.
 *
 * Usage:
 *	SkGeXmitLED(pAC, IoC, MR_ADDR(Port, TX_LED_INI), SK_LED_ENA);
 *
 * Returns:
 *	nothing
 */
void SkGeXmitLED(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Led,		/* offset to the LED Init Value register */
int		Mode)		/* Mode may be SK_LED_DIS, SK_LED_ENA, SK_LED_TST */
{
	SK_U32	LedIni;

	switch (Mode) {
	case SK_LED_ENA:
		LedIni = SK_XMIT_DUR * (SK_U32)pAC->GIni.GIHstClkFact / 100;
		SK_OUT32(IoC, Led + XMIT_LED_INI, LedIni);
		SK_OUT8(IoC, Led + XMIT_LED_CTRL, LED_START);
		break;
	case SK_LED_TST:
		SK_OUT8(IoC, Led + XMIT_LED_TST, LED_T_ON);
		SK_OUT32(IoC, Led + XMIT_LED_CNT, 100);
		SK_OUT8(IoC, Led + XMIT_LED_CTRL, LED_START);
		break;
	case SK_LED_DIS:
	default:
		/*
		 * Do NOT stop the LED Timer here. The LED might be
		 * in on state. But it needs to go off.
		 */
		SK_OUT32(IoC, Led + XMIT_LED_CNT, 0);
		SK_OUT8(IoC, Led + XMIT_LED_TST, LED_T_OFF);
		break;
	}

	/*
	 * 1000BT: The Transmit LED is driven by the PHY.
	 * But the default LED configuration is used for
	 * Level One and Broadcom PHYs.
	 * (Broadcom: It may be that PHY_B_PEC_EN_LTR has to be set.)
	 * (In this case it has to be added here. But we will see. XXX)
	 */
}	/* SkGeXmitLED */


/******************************************************************************
 *
 *	DoCalcAddr() - Calculates the start and the end address of a queue.
 *
 * Description:
 *	This function calculates the start and the end address of a queue.
 *  Afterwards the 'StartVal' is incremented to the next start position.
 *	If the port is already initialized the calculated values
 *	will be checked against the configured values and an
 *	error will be returned, if they are not equal.
 *	If the port is not initialized the values will be written to
 *	*StartAdr and *EndAddr.
 *
 * Returns:
 *	0:	success
 *	1:	configuration error
 */
static int DoCalcAddr(
SK_AC		*pAC, 			/* adapter context */
SK_GEPORT	*pPrt,			/* port index */
int			QuSize,			/* size of the queue to configure in kB */
SK_U32		*StartVal,		/* start value for address calculation */
SK_U32		*QuStartAddr,	/* start addr to calculate */
SK_U32		*QuEndAddr)		/* end address to calculate */
{
	SK_U32	EndVal;
	SK_U32	NextStart;
	int		Rtv;

	Rtv = 0;
	if (QuSize == 0) {
		EndVal = *StartVal;
		NextStart = EndVal;
	}
	else {
		EndVal = *StartVal + ((SK_U32)QuSize * 1024) - 1;
		NextStart = EndVal + 1;
	}

	if (pPrt->PState >= SK_PRT_INIT) {
		if (*StartVal != *QuStartAddr || EndVal != *QuEndAddr) {
			Rtv = 1;
		}
	}
	else {
		*QuStartAddr = *StartVal;
		*QuEndAddr = EndVal;
	}

	*StartVal = NextStart;
	return(Rtv);
}	/* DoCalcAddr */

/******************************************************************************
 *
 *	SkGeInitAssignRamToQueues() - allocate default queue sizes
 *
 * Description:
 *	This function assigns the memory to the different queues and ports.
 *	When DualNet is set to SK_TRUE all ports get the same amount of memory.
 *  Otherwise the first port gets most of the memory and all the
 *	other ports just the required minimum.
 *	This function can only be called when pAC->GIni.GIRamSize and
 *	pAC->GIni.GIMacsFound have been initialized, usually this happens
 *	at init level 1
 *
 * Returns:
 *	0 - ok
 *	1 - invalid input values
 *	2 - not enough memory
 */

int SkGeInitAssignRamToQueues(
SK_AC	*pAC,			/* Adapter context */
int		ActivePort,		/* Active Port in RLMT mode */
SK_BOOL	DualNet)		/* adapter context */
{
	int	i;
	int	UsedKilobytes;			/* memory already assigned */
	int	ActivePortKilobytes;	/* memory available for active port */
	SK_GEPORT *pGePort;

	UsedKilobytes = 0;

	if (ActivePort >= pAC->GIni.GIMacsFound) {
		SK_DBG_MSG(pAC, SK_DBGMOD_HWM, SK_DBGCAT_INIT,
			("SkGeInitAssignRamToQueues: ActivePort (%d) invalid\n",
			ActivePort));
		return(1);
	}
	if (((pAC->GIni.GIMacsFound * (SK_MIN_RXQ_SIZE + SK_MIN_TXQ_SIZE)) +
		((RAM_QUOTA_SYNC == 0) ? 0 : SK_MIN_TXQ_SIZE)) > pAC->GIni.GIRamSize) {
		SK_DBG_MSG(pAC, SK_DBGMOD_HWM, SK_DBGCAT_INIT,
			("SkGeInitAssignRamToQueues: Not enough memory (%d)\n",
			 pAC->GIni.GIRamSize));
		return(2);
	}


	if (DualNet) {
		/* every port gets the same amount of memory */
		ActivePortKilobytes = pAC->GIni.GIRamSize / pAC->GIni.GIMacsFound;
		for (i = 0; i < pAC->GIni.GIMacsFound; i++) {

			pGePort = &pAC->GIni.GP[i];

			/* take away the minimum memory for active queues */
			ActivePortKilobytes -= (SK_MIN_RXQ_SIZE + SK_MIN_TXQ_SIZE);

			/* receive queue gets the minimum + 80% of the rest */
			pGePort->PRxQSize = (int) (ROUND_QUEUE_SIZE_KB((
				ActivePortKilobytes * (unsigned long) RAM_QUOTA_RX) / 100))
				+ SK_MIN_RXQ_SIZE;

			ActivePortKilobytes -= (pGePort->PRxQSize - SK_MIN_RXQ_SIZE);

			/* synchronous transmit queue */
			pGePort->PXSQSize = 0;

			/* asynchronous transmit queue */
			pGePort->PXAQSize = (int) ROUND_QUEUE_SIZE_KB(ActivePortKilobytes +
				SK_MIN_TXQ_SIZE);
		}
	}
	else {
		/* Rlmt Mode or single link adapter */

		/* Set standby queue size defaults for all standby ports */
		for (i = 0; i < pAC->GIni.GIMacsFound; i++) {

			if (i != ActivePort) {
				pGePort = &pAC->GIni.GP[i];

				pGePort->PRxQSize = SK_MIN_RXQ_SIZE;
				pGePort->PXAQSize = SK_MIN_TXQ_SIZE;
				pGePort->PXSQSize = 0;

				/* Count used RAM */
				UsedKilobytes += pGePort->PRxQSize + pGePort->PXAQSize;
			}
		}
		/* what's left? */
		ActivePortKilobytes = pAC->GIni.GIRamSize - UsedKilobytes;

		/* assign it to the active port */
		/* first take away the minimum memory */
		ActivePortKilobytes -= (SK_MIN_RXQ_SIZE + SK_MIN_TXQ_SIZE);
		pGePort = &pAC->GIni.GP[ActivePort];

		/* receive queue get's the minimum + 80% of the rest */
		pGePort->PRxQSize = (int) (ROUND_QUEUE_SIZE_KB((ActivePortKilobytes *
			(unsigned long) RAM_QUOTA_RX) / 100)) + SK_MIN_RXQ_SIZE;

		ActivePortKilobytes -= (pGePort->PRxQSize - SK_MIN_RXQ_SIZE);

		/* synchronous transmit queue */
		pGePort->PXSQSize = 0;

		/* asynchronous transmit queue */
		pGePort->PXAQSize = (int) ROUND_QUEUE_SIZE_KB(ActivePortKilobytes) +
			SK_MIN_TXQ_SIZE;
	}
#ifdef VCPU
	VCPUprintf(0, "PRxQSize=%u, PXSQSize=%u, PXAQSize=%u\n",
		pGePort->PRxQSize, pGePort->PXSQSize, pGePort->PXAQSize);
#endif /* VCPU */

	return(0);
}	/* SkGeInitAssignRamToQueues */

/******************************************************************************
 *
 *	SkGeCheckQSize() - Checks the Adapters Queue Size Configuration
 *
 * Description:
 *	This function verifies the Queue Size Configuration specified
 *	in the variables PRxQSize, PXSQSize, and PXAQSize of all
 *	used ports.
 *	This requirements must be fullfilled to have a valid configuration:
 *		- The size of all queues must not exceed GIRamSize.
 *		- The queue sizes must be specified in units of 8 kB.
 *		- The size of Rx queues of available ports must not be
 *		  smaller than 16 kB.
 *		- The size of at least one Tx queue (synch. or asynch.)
 *        of available ports must not be smaller than 16 kB
 *        when Jumbo Frames are used.
 *		- The RAM start and end addresses must not be changed
 *		  for ports which are already initialized.
 *	Furthermore SkGeCheckQSize() defines the Start and End Addresses
 *  of all ports and stores them into the HWAC port	structure.
 *
 * Returns:
 *	0:	Queue Size Configuration valid
 *	1:	Queue Size Configuration invalid
 */
static int SkGeCheckQSize(
SK_AC	 *pAC,		/* adapter context */
int		 Port)		/* port index */
{
	SK_GEPORT *pPrt;
	int	UsedMem;	/* total memory used (max. found ports) */
	int	i;
	int	Rtv;
	int	Rtv2;
	SK_U32	StartAddr;

	UsedMem = 0;
	Rtv = 0;
	for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
		pPrt = &pAC->GIni.GP[i];

		if ((pPrt->PRxQSize & QZ_UNITS) != 0 ||
			(pPrt->PXSQSize & QZ_UNITS) != 0 ||
			(pPrt->PXAQSize & QZ_UNITS) != 0) {

			SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E012, SKERR_HWI_E012MSG);
			return(1);
		}

		if (i == Port && pPrt->PRxQSize < SK_MIN_RXQ_SIZE) {
			SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E011, SKERR_HWI_E011MSG);
			return(1);
		}

		/*
		 * the size of at least one Tx queue (synch. or asynch.) has to be > 0.
		 * if Jumbo Frames are used, this size has to be >= 16 kB.
		 */
		if ((i == Port && pPrt->PXSQSize == 0 && pPrt->PXAQSize == 0) ||
			(pAC->GIni.GIPortUsage == SK_JUMBO_LINK &&
	    ((pPrt->PXSQSize > 0 && pPrt->PXSQSize < SK_MIN_TXQ_SIZE) ||
			 (pPrt->PXAQSize > 0 && pPrt->PXAQSize < SK_MIN_TXQ_SIZE)))) {
				SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E023, SKERR_HWI_E023MSG);
				return(1);
		}

		UsedMem += pPrt->PRxQSize + pPrt->PXSQSize + pPrt->PXAQSize;
	}

	if (UsedMem > pAC->GIni.GIRamSize) {
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E012, SKERR_HWI_E012MSG);
		return(1);
	}

	/* Now start address calculation */
	StartAddr = pAC->GIni.GIRamOffs;
	for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
		pPrt = &pAC->GIni.GP[i];

		/* Calculate/Check values for the receive queue */
		Rtv2 = DoCalcAddr(pAC, pPrt, pPrt->PRxQSize, &StartAddr,
			&pPrt->PRxQRamStart, &pPrt->PRxQRamEnd);
		Rtv |= Rtv2;

		/* Calculate/Check values for the synchronous Tx queue */
		Rtv2 = DoCalcAddr(pAC, pPrt, pPrt->PXSQSize, &StartAddr,
			&pPrt->PXsQRamStart, &pPrt->PXsQRamEnd);
		Rtv |= Rtv2;

		/* Calculate/Check values for the asynchronous Tx queue */
		Rtv2 = DoCalcAddr(pAC, pPrt, pPrt->PXAQSize, &StartAddr,
			&pPrt->PXaQRamStart, &pPrt->PXaQRamEnd);
		Rtv |= Rtv2;

		if (Rtv) {
			SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E013, SKERR_HWI_E013MSG);
			return(1);
		}
	}

	return(0);
}	/* SkGeCheckQSize */


/******************************************************************************
 *
 *	SkGeInitMacArb() - Initialize the MAC Arbiter
 *
 * Description:
 *	This function initializes the MAC Arbiter.
 *	It must not be called if there is still an
 *	initialized or active port.
 *
 * Returns:
 *	nothing
 */
static void SkGeInitMacArb(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	/* release local reset */
	SK_OUT16(IoC, B3_MA_TO_CTRL, MA_RST_CLR);

	/* configure timeout values */
	SK_OUT8(IoC, B3_MA_TOINI_RX1, SK_MAC_TO_53);
	SK_OUT8(IoC, B3_MA_TOINI_RX2, SK_MAC_TO_53);
	SK_OUT8(IoC, B3_MA_TOINI_TX1, SK_MAC_TO_53);
	SK_OUT8(IoC, B3_MA_TOINI_TX2, SK_MAC_TO_53);

	SK_OUT8(IoC, B3_MA_RCINI_RX1, 0);
	SK_OUT8(IoC, B3_MA_RCINI_RX2, 0);
	SK_OUT8(IoC, B3_MA_RCINI_TX1, 0);
	SK_OUT8(IoC, B3_MA_RCINI_TX2, 0);

	/* recovery values are needed for XMAC II Rev. B2 only */
	/* Fast Output Enable Mode was intended to use with Rev. B2, but now? */

	/*
	 * There is no start or enable button to push, therefore
	 * the MAC arbiter is configured and enabled now.
	 */
}	/* SkGeInitMacArb */


/******************************************************************************
 *
 *	SkGeInitPktArb() - Initialize the Packet Arbiter
 *
 * Description:
 *	This function initializes the Packet Arbiter.
 *	It must not be called if there is still an
 *	initialized or active port.
 *
 * Returns:
 *	nothing
 */
static void SkGeInitPktArb(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	/* release local reset */
	SK_OUT16(IoC, B3_PA_CTRL, PA_RST_CLR);

	/* configure timeout values */
	SK_OUT16(IoC, B3_PA_TOINI_RX1, SK_PKT_TO_MAX);
	SK_OUT16(IoC, B3_PA_TOINI_RX2, SK_PKT_TO_MAX);
	SK_OUT16(IoC, B3_PA_TOINI_TX1, SK_PKT_TO_MAX);
	SK_OUT16(IoC, B3_PA_TOINI_TX2, SK_PKT_TO_MAX);

	/*
	 * enable timeout timers if jumbo frames not used
	 * NOTE: the packet arbiter timeout interrupt is needed for
	 * half duplex hangup workaround
	 */
	if (pAC->GIni.GIPortUsage != SK_JUMBO_LINK) {
		if (pAC->GIni.GIMacsFound == 1) {
			SK_OUT16(IoC, B3_PA_CTRL, PA_ENA_TO_TX1);
		}
		else {
			SK_OUT16(IoC, B3_PA_CTRL, PA_ENA_TO_TX1 | PA_ENA_TO_TX2);
		}
	}
}	/* SkGeInitPktArb */


/******************************************************************************
 *
 *	SkGeInitMacFifo() - Initialize the MAC FIFOs
 *
 * Description:
 *	Initialize all MAC FIFOs of the specified port
 *
 * Returns:
 *	nothing
 */
static void SkGeInitMacFifo(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port)		/* Port Index (MAC_1 + n) */
{
	SK_U16	Word;
#ifdef VCPU
	SK_U32	DWord;
#endif /* VCPU */
	/*
	 * For each FIFO:
	 *	- release local reset
	 *	- use default value for MAC FIFO size
	 *	- setup defaults for the control register
	 *	- enable the FIFO
	 */

	Word = GMF_RX_CTRL_DEF;

	if (pAC->GIni.GIGenesis) {
		/* Configure Rx MAC FIFO */
		SK_OUT8(IoC, MR_ADDR(Port, RX_MFF_CTRL2), MFF_RST_CLR);
		SK_OUT16(IoC, MR_ADDR(Port, RX_MFF_CTRL1), MFF_RX_CTRL_DEF);
		SK_OUT8(IoC, MR_ADDR(Port, RX_MFF_CTRL2), MFF_ENA_OP_MD);

		/* Configure Tx MAC FIFO */
		SK_OUT8(IoC, MR_ADDR(Port, TX_MFF_CTRL2), MFF_RST_CLR);
		SK_OUT16(IoC, MR_ADDR(Port, TX_MFF_CTRL1), MFF_TX_CTRL_DEF);
		SK_OUT8(IoC, MR_ADDR(Port, TX_MFF_CTRL2), MFF_ENA_OP_MD);

		/* Enable frame flushing if jumbo frames used */
		if (pAC->GIni.GIPortUsage == SK_JUMBO_LINK) {
			SK_OUT16(IoC, MR_ADDR(Port, RX_MFF_CTRL1), MFF_ENA_FLUSH);
		}
	}
	else {
		/* set Rx GMAC FIFO Flush Mask */
		SK_OUT16(IoC, MR_ADDR(Port, RX_GMF_FL_MSK), (SK_U16)RX_FF_FL_DEF_MSK);

		if (pAC->GIni.GIYukonLite && pAC->GIni.GIChipId == CHIP_ID_YUKON) {

			Word &= ~GMF_RX_F_FL_ON;
		}

		/* Configure Rx MAC FIFO */
		SK_OUT8(IoC, MR_ADDR(Port, RX_GMF_CTRL_T), (SK_U8)GMF_RST_CLR);
		SK_OUT16(IoC, MR_ADDR(Port, RX_GMF_CTRL_T), Word);

		/* set Rx GMAC FIFO Flush Threshold (default: 0x0a -> 56 bytes) */
		SK_OUT16(IoC, MR_ADDR(Port, RX_GMF_FL_THR), RX_GMF_FL_THR_DEF);

		/* Configure Tx MAC FIFO */
		SK_OUT8(IoC, MR_ADDR(Port, TX_GMF_CTRL_T), (SK_U8)GMF_RST_CLR);
		SK_OUT16(IoC, MR_ADDR(Port, TX_GMF_CTRL_T), (SK_U16)GMF_TX_CTRL_DEF);

#ifdef VCPU
		SK_IN32(IoC, MR_ADDR(Port, RX_GMF_AF_THR), &DWord);
		SK_IN32(IoC, MR_ADDR(Port, TX_GMF_AE_THR), &DWord);
#endif /* VCPU */

		/* set Tx GMAC FIFO Almost Empty Threshold */
/*		SK_OUT32(IoC, MR_ADDR(Port, TX_GMF_AE_THR), 0); */
	}
}	/* SkGeInitMacFifo */


/******************************************************************************
 *
 *	SkGeLoadLnkSyncCnt() - Load the Link Sync Counter and starts counting
 *
 * Description:
 *	This function starts the Link Sync Counter of the specified
 *	port and enables the generation of an Link Sync IRQ.
 *	The Link Sync Counter may be used to detect an active link,
 *	if autonegotiation is not used.
 *
 * Note:
 *	o To ensure receiving the Link Sync Event the LinkSyncCounter
 *	  should be initialized BEFORE clearing the XMAC's reset!
 *	o Enable IS_LNK_SYNC_M1 and IS_LNK_SYNC_M2 after calling this
 *	  function.
 *
 * Returns:
 *	nothing
 */
void SkGeLoadLnkSyncCnt(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port,		/* Port Index (MAC_1 + n) */
SK_U32	CntVal)		/* Counter value */
{
	SK_U32	OrgIMsk;
	SK_U32	NewIMsk;
	SK_U32	ISrc;
	SK_BOOL	IrqPend;

	/* stop counter */
	SK_OUT8(IoC, MR_ADDR(Port, LNK_SYNC_CTRL), LED_STOP);

	/*
	 * ASIC problem:
	 * Each time starting the Link Sync Counter an IRQ is generated
	 * by the adapter. See problem report entry from 21.07.98
	 *
	 * Workaround:	Disable Link Sync IRQ and clear the unexpeced IRQ
	 *		if no IRQ is already pending.
	 */
	IrqPend = SK_FALSE;
	SK_IN32(IoC, B0_ISRC, &ISrc);
	SK_IN32(IoC, B0_IMSK, &OrgIMsk);
	if (Port == MAC_1) {
		NewIMsk = OrgIMsk & ~IS_LNK_SYNC_M1;
		if ((ISrc & IS_LNK_SYNC_M1) != 0) {
			IrqPend = SK_TRUE;
		}
	}
	else {
		NewIMsk = OrgIMsk & ~IS_LNK_SYNC_M2;
		if ((ISrc & IS_LNK_SYNC_M2) != 0) {
			IrqPend = SK_TRUE;
		}
	}
	if (!IrqPend) {
		SK_OUT32(IoC, B0_IMSK, NewIMsk);
	}

	/* load counter */
	SK_OUT32(IoC, MR_ADDR(Port, LNK_SYNC_INI), CntVal);

	/* start counter */
	SK_OUT8(IoC, MR_ADDR(Port, LNK_SYNC_CTRL), LED_START);

	if (!IrqPend) {
		/* clear the unexpected IRQ, and restore the interrupt mask */
		SK_OUT8(IoC, MR_ADDR(Port, LNK_SYNC_CTRL), LED_CLR_IRQ);
		SK_OUT32(IoC, B0_IMSK, OrgIMsk);
	}
}	/* SkGeLoadLnkSyncCnt*/


/******************************************************************************
 *
 *	SkGeCfgSync() - Configure synchronous bandwidth for this port.
 *
 * Description:
 *	This function may be used to configure synchronous bandwidth
 *	to the specified port. This may be done any time after
 *	initializing the port. The configuration values are NOT saved
 *	in the HWAC port structure and will be overwritten any
 *	time when stopping and starting the port.
 *	Any values for the synchronous configuration will be ignored
 *	if the size of the synchronous queue is zero!
 *
 *	The default configuration for the synchronous service is
 *	TXA_ENA_FSYNC. This means if the size of
 *	the synchronous queue is unequal zero but no specific
 *	synchronous bandwidth is configured, the synchronous queue
 *	will always have the 'unlimited' transmit priority!
 *
 *	This mode will be restored if the synchronous bandwidth is
 *	deallocated ('IntTime' = 0 and 'LimCount' = 0).
 *
 * Returns:
 *	0:	success
 *	1:	parameter configuration error
 *	2:	try to configure quality of service although no
 *		synchronous queue is configured
 */
int SkGeCfgSync(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port,		/* Port Index (MAC_1 + n) */
SK_U32	IntTime,	/* Interval Timer Value in units of 8ns */
SK_U32	LimCount,	/* Number of bytes to transfer during IntTime */
int		SyncMode)	/* Sync Mode: TXA_ENA_ALLOC | TXA_DIS_ALLOC | 0 */
{
	int Rtv;

	Rtv = 0;

	/* check the parameters */
	if (LimCount > IntTime ||
		(LimCount == 0 && IntTime != 0) ||
		(LimCount != 0 && IntTime == 0)) {

		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E010, SKERR_HWI_E010MSG);
		return(1);
	}

	if (pAC->GIni.GP[Port].PXSQSize == 0) {
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E009, SKERR_HWI_E009MSG);
		return(2);
	}

	/* calculate register values */
	IntTime = (IntTime / 2) * pAC->GIni.GIHstClkFact / 100;
	LimCount = LimCount / 8;

	if (IntTime > TXA_MAX_VAL || LimCount > TXA_MAX_VAL) {
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E010, SKERR_HWI_E010MSG);
		return(1);
	}

	/*
	 * - Enable 'Force Sync' to ensure the synchronous queue
	 *   has the priority while configuring the new values.
	 * - Also 'disable alloc' to ensure the settings complies
	 *   to the SyncMode parameter.
	 * - Disable 'Rate Control' to configure the new values.
	 * - write IntTime and LimCount
	 * - start 'Rate Control' and disable 'Force Sync'
	 *   if Interval Timer or Limit Counter not zero.
	 */
	SK_OUT8(IoC, MR_ADDR(Port, TXA_CTRL),
		TXA_ENA_FSYNC | TXA_DIS_ALLOC | TXA_STOP_RC);

	SK_OUT32(IoC, MR_ADDR(Port, TXA_ITI_INI), IntTime);
	SK_OUT32(IoC, MR_ADDR(Port, TXA_LIM_INI), LimCount);

	SK_OUT8(IoC, MR_ADDR(Port, TXA_CTRL),
		(SK_U8)(SyncMode & (TXA_ENA_ALLOC | TXA_DIS_ALLOC)));

	if (IntTime != 0 || LimCount != 0) {
		SK_OUT8(IoC, MR_ADDR(Port, TXA_CTRL), TXA_DIS_FSYNC | TXA_START_RC);
	}

	return(0);
}	/* SkGeCfgSync */


/******************************************************************************
 *
 *	DoInitRamQueue() - Initialize the RAM Buffer Address of a single Queue
 *
 * Desccription:
 *	If the queue is used, enable and initialize it.
 *	Make sure the queue is still reset, if it is not used.
 *
 * Returns:
 *	nothing
 */
static void DoInitRamQueue(
SK_AC	*pAC,			/* adapter context */
SK_IOC	IoC,			/* IO context */
int		QuIoOffs,		/* Queue IO Address Offset */
SK_U32	QuStartAddr,	/* Queue Start Address */
SK_U32	QuEndAddr,		/* Queue End Address */
int		QuType)			/* Queue Type (SK_RX_SRAM_Q|SK_RX_BRAM_Q|SK_TX_RAM_Q) */
{
	SK_U32	RxUpThresVal;
	SK_U32	RxLoThresVal;

	if (QuStartAddr != QuEndAddr) {
		/* calculate thresholds, assume we have a big Rx queue */
		RxUpThresVal = (QuEndAddr + 1 - QuStartAddr - SK_RB_ULPP) / 8;
		RxLoThresVal = (QuEndAddr + 1 - QuStartAddr - SK_RB_LLPP_B)/8;

		/* build HW address format */
		QuStartAddr = QuStartAddr / 8;
		QuEndAddr = QuEndAddr / 8;

		/* release local reset */
		SK_OUT8(IoC, RB_ADDR(QuIoOffs, RB_CTRL), RB_RST_CLR);

		/* configure addresses */
		SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_START), QuStartAddr);
		SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_END), QuEndAddr);
		SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_WP), QuStartAddr);
		SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_RP), QuStartAddr);

		switch (QuType) {
		case SK_RX_SRAM_Q:
			/* configure threshold for small Rx Queue */
			RxLoThresVal += (SK_RB_LLPP_B - SK_RB_LLPP_S) / 8;

			/* continue with SK_RX_BRAM_Q */
		case SK_RX_BRAM_Q:
			/* write threshold for Rx Queue */

			SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_RX_UTPP), RxUpThresVal);
			SK_OUT32(IoC, RB_ADDR(QuIoOffs, RB_RX_LTPP), RxLoThresVal);

			/* the high priority threshold not used */
			break;
		case SK_TX_RAM_Q:
			/*
			 * Do NOT use Store & Forward under normal operation due to
			 * performance optimization (GENESIS only).
			 * But if Jumbo Frames are configured (XMAC Tx FIFO is only 4 kB)
			 * or YUKON is used ((GMAC Tx FIFO is only 1 kB)
			 * we NEED Store & Forward of the RAM buffer.
			 */
			if (pAC->GIni.GIPortUsage == SK_JUMBO_LINK ||
				!pAC->GIni.GIGenesis) {
				/* enable Store & Forward Mode for the Tx Side */
				SK_OUT8(IoC, RB_ADDR(QuIoOffs, RB_CTRL), RB_ENA_STFWD);
			}
			break;
		}

		/* set queue operational */
		SK_OUT8(IoC, RB_ADDR(QuIoOffs, RB_CTRL), RB_ENA_OP_MD);
	}
	else {
		/* ensure the queue is still disabled */
		SK_OUT8(IoC, RB_ADDR(QuIoOffs, RB_CTRL), RB_RST_SET);
	}
}	/* DoInitRamQueue */


/******************************************************************************
 *
 *	SkGeInitRamBufs() - Initialize the RAM Buffer Queues
 *
 * Description:
 *	Initialize all RAM Buffer Queues of the specified port
 *
 * Returns:
 *	nothing
 */
static void SkGeInitRamBufs(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port)		/* Port Index (MAC_1 + n) */
{
	SK_GEPORT *pPrt;
	int RxQType;

	pPrt = &pAC->GIni.GP[Port];

	if (pPrt->PRxQSize == SK_MIN_RXQ_SIZE) {
		RxQType = SK_RX_SRAM_Q; 	/* small Rx Queue */
	}
	else {
		RxQType = SK_RX_BRAM_Q;		/* big Rx Queue */
	}

	DoInitRamQueue(pAC, IoC, pPrt->PRxQOff, pPrt->PRxQRamStart,
		pPrt->PRxQRamEnd, RxQType);

	DoInitRamQueue(pAC, IoC, pPrt->PXsQOff, pPrt->PXsQRamStart,
		pPrt->PXsQRamEnd, SK_TX_RAM_Q);

	DoInitRamQueue(pAC, IoC, pPrt->PXaQOff, pPrt->PXaQRamStart,
		pPrt->PXaQRamEnd, SK_TX_RAM_Q);

}	/* SkGeInitRamBufs */


/******************************************************************************
 *
 *	SkGeInitRamIface() - Initialize the RAM Interface
 *
 * Description:
 *	This function initializes the Adapters RAM Interface.
 *
 * Note:
 *	This function is used in the diagnostics.
 *
 * Returns:
 *	nothing
 */
void SkGeInitRamIface(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	/* release local reset */
	SK_OUT16(IoC, B3_RI_CTRL, RI_RST_CLR);

	/* configure timeout values */
	SK_OUT8(IoC, B3_RI_WTO_R1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_WTO_XA1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_WTO_XS1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_R1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_XA1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_XS1, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_WTO_R2, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_WTO_XA2, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_WTO_XS2, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_R2, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_XA2, SK_RI_TO_53);
	SK_OUT8(IoC, B3_RI_RTO_XS2, SK_RI_TO_53);

}	/* SkGeInitRamIface */


/******************************************************************************
 *
 *	SkGeInitBmu() - Initialize the BMU state machines
 *
 * Description:
 *	Initialize all BMU state machines of the specified port
 *
 * Returns:
 *	nothing
 */
static void SkGeInitBmu(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port)		/* Port Index (MAC_1 + n) */
{
	SK_GEPORT	*pPrt;
	SK_U32		RxWm;
	SK_U32		TxWm;

	pPrt = &pAC->GIni.GP[Port];

	RxWm = SK_BMU_RX_WM;
	TxWm = SK_BMU_TX_WM;

	if (!pAC->GIni.GIPciSlot64 && !pAC->GIni.GIPciClock66) {
		/* for better performance */
		RxWm /= 2;
		TxWm /= 2;
	}

	/* Rx Queue: Release all local resets and set the watermark */
	SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_CSR), CSR_CLR_RESET);
	SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_F), RxWm);

	/*
	 * Tx Queue: Release all local resets if the queue is used !
	 * 		set watermark
	 */
	if (pPrt->PXSQSize != 0) {
		SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_CSR), CSR_CLR_RESET);
		SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_F), TxWm);
	}

	if (pPrt->PXAQSize != 0) {
		SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_CSR), CSR_CLR_RESET);
		SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_F), TxWm);
	}
	/*
	 * Do NOT enable the descriptor poll timers here, because
	 * the descriptor addresses are not specified yet.
	 */
}	/* SkGeInitBmu */


/******************************************************************************
 *
 *	TestStopBit() -	Test the stop bit of the queue
 *
 * Description:
 *	Stopping a queue is not as simple as it seems to be.
 *	If descriptor polling is enabled, it may happen
 *	that RX/TX stop is done and SV idle is NOT set.
 *	In this case we have to issue another stop command.
 *
 * Returns:
 *	The queues control status register
 */
static SK_U32 TestStopBit(
SK_AC	*pAC,		/* Adapter Context */
SK_IOC	IoC,		/* IO Context */
int		QuIoOffs)	/* Queue IO Address Offset */
{
	SK_U32	QuCsr;	/* CSR contents */

	SK_IN32(IoC, Q_ADDR(QuIoOffs, Q_CSR), &QuCsr);

	if ((QuCsr & (CSR_STOP | CSR_SV_IDLE)) == 0) {
		/* Stop Descriptor overridden by start command */
		SK_OUT32(IoC, Q_ADDR(QuIoOffs, Q_CSR), CSR_STOP);

		SK_IN32(IoC, Q_ADDR(QuIoOffs, Q_CSR), &QuCsr);
	}

	return(QuCsr);
}	/* TestStopBit */


/******************************************************************************
 *
 *	SkGeStopPort() - Stop the Rx/Tx activity of the port 'Port'.
 *
 * Description:
 *	After calling this function the descriptor rings and Rx and Tx
 *	queues of this port may be reconfigured.
 *
 *	It is possible to stop the receive and transmit path separate or
 *	both together.
 *
 *	Dir =	SK_STOP_TX 	Stops the transmit path only and resets the MAC.
 *				The receive queue is still active and
 *				the pending Rx frames may be still transferred
 *				into the RxD.
 *		SK_STOP_RX	Stop the receive path. The tansmit path
 *				has to be stopped once before.
 *		SK_STOP_ALL	SK_STOP_TX + SK_STOP_RX
 *
 *	RstMode = SK_SOFT_RST	Resets the MAC. The PHY is still alive.
 *			SK_HARD_RST	Resets the MAC and the PHY.
 *
 * Example:
 *	1) A Link Down event was signaled for a port. Therefore the activity
 *	of this port should be stopped and a hardware reset should be issued
 *	to enable the workaround of XMAC errata #2. But the received frames
 *	should not be discarded.
 *		...
 *		SkGeStopPort(pAC, IoC, Port, SK_STOP_TX, SK_HARD_RST);
 *		(transfer all pending Rx frames)
 *		SkGeStopPort(pAC, IoC, Port, SK_STOP_RX, SK_HARD_RST);
 *		...
 *
 *	2) An event was issued which request the driver to switch
 *	the 'virtual active' link to an other already active port
 *	as soon as possible. The frames in the receive queue of this
 *	port may be lost. But the PHY must not be reset during this
 *	event.
 *		...
 *		SkGeStopPort(pAC, IoC, Port, SK_STOP_ALL, SK_SOFT_RST);
 *		...
 *
 * Extended Description:
 *	If SK_STOP_TX is set,
 *		o disable the MAC's receive and transmitter to prevent
 *		  from sending incomplete frames
 *		o stop the port's transmit queues before terminating the
 *		  BMUs to prevent from performing incomplete PCI cycles
 *		  on the PCI bus
 *		- The network Rx and Tx activity and PCI Tx transfer is
 *		  disabled now.
 *		o reset the MAC depending on the RstMode
 *		o Stop Interval Timer and Limit Counter of Tx Arbiter,
 *		  also disable Force Sync bit and Enable Alloc bit.
 *		o perform a local reset of the port's Tx path
 *			- reset the PCI FIFO of the async Tx queue
 *			- reset the PCI FIFO of the sync Tx queue
 *			- reset the RAM Buffer async Tx queue
 *			- reset the RAM Buffer sync Tx queue
 *			- reset the MAC Tx FIFO
 *		o switch Link and Tx LED off, stop the LED counters
 *
 *	If SK_STOP_RX is set,
 *		o stop the port's receive queue
 *		- The path data transfer activity is fully stopped now.
 *		o perform a local reset of the port's Rx path
 *			- reset the PCI FIFO of the Rx queue
 *			- reset the RAM Buffer receive queue
 *			- reset the MAC Rx FIFO
 *		o switch Rx LED off, stop the LED counter
 *
 *	If all ports are stopped,
 *		o reset the RAM Interface.
 *
 * Notes:
 *	o This function may be called during the driver states RESET_PORT and
 *	  SWITCH_PORT.
 */
void SkGeStopPort(
SK_AC	*pAC,	/* adapter context */
SK_IOC	IoC,	/* I/O context */
int		Port,	/* port to stop (MAC_1 + n) */
int		Dir,	/* Direction to Stop (SK_STOP_RX, SK_STOP_TX, SK_STOP_ALL) */
int		RstMode)/* Reset Mode (SK_SOFT_RST, SK_HARD_RST) */
{
#ifndef SK_DIAG
	SK_EVPARA Para;
#endif /* !SK_DIAG */
	SK_GEPORT *pPrt;
	SK_U32	DWord;
	SK_U32	XsCsr;
	SK_U32	XaCsr;
	SK_U64	ToutStart;
	int		i;
	int		ToutCnt;

	pPrt = &pAC->GIni.GP[Port];

	if ((Dir & SK_STOP_TX) != 0) {
		/* disable receiver and transmitter */
		SkMacRxTxDisable(pAC, IoC, Port);

		/* stop both transmit queues */
		/*
		 * If the BMU is in the reset state CSR_STOP will terminate
		 * immediately.
		 */
		SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_CSR), CSR_STOP);
		SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_CSR), CSR_STOP);

		ToutStart = SkOsGetTime(pAC);
		ToutCnt = 0;
		do {
			/*
			 * Clear packet arbiter timeout to make sure
			 * this loop will terminate.
			 */
			SK_OUT16(IoC, B3_PA_CTRL, (Port == MAC_1) ? PA_CLR_TO_TX1 :
				PA_CLR_TO_TX2);

			/*
			 * If the transfer stucks at the MAC the STOP command will not
			 * terminate if we don't flush the XMAC's transmit FIFO !
			 */
			SkMacFlushTxFifo(pAC, IoC, Port);

			XsCsr = TestStopBit(pAC, IoC, pPrt->PXsQOff);
			XaCsr = TestStopBit(pAC, IoC, pPrt->PXaQOff);

			if (SkOsGetTime(pAC) - ToutStart > (SK_TICKS_PER_SEC / 18)) {
				/*
				 * Timeout of 1/18 second reached.
				 * This needs to be checked at 1/18 sec only.
				 */
				ToutCnt++;
				if (ToutCnt > 1) {
					/* Might be a problem when the driver event handler
					 * calls StopPort again. XXX.
					 */

					/* Fatal Error, Loop aborted */
					SK_ERR_LOG(pAC, SK_ERRCL_HW, SKERR_HWI_E018,
						SKERR_HWI_E018MSG);
#ifndef SK_DIAG
					Para.Para64 = Port;
					SkEventQueue(pAC, SKGE_DRV, SK_DRV_PORT_FAIL, Para);
#endif /* !SK_DIAG */
					return;
				}
				/*
				 * Cache incoherency workaround: Assume a start command
				 * has been lost while sending the frame.
				 */
				ToutStart = SkOsGetTime(pAC);

				if ((XsCsr & CSR_STOP) != 0) {
					SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_CSR), CSR_START);
				}
				if ((XaCsr & CSR_STOP) != 0) {
					SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_CSR), CSR_START);
				}
			}

			/*
			 * Because of the ASIC problem report entry from 21.08.1998 it is
			 * required to wait until CSR_STOP is reset and CSR_SV_IDLE is set.
			 */
		} while ((XsCsr & (CSR_STOP | CSR_SV_IDLE)) != CSR_SV_IDLE ||
				 (XaCsr & (CSR_STOP | CSR_SV_IDLE)) != CSR_SV_IDLE);

		/* Reset the MAC depending on the RstMode */
		if (RstMode == SK_SOFT_RST) {
			SkMacSoftRst(pAC, IoC, Port);
		}
		else {
			SkMacHardRst(pAC, IoC, Port);
		}

		/* Disable Force Sync bit and Enable Alloc bit */
		SK_OUT8(IoC, MR_ADDR(Port, TXA_CTRL),
			TXA_DIS_FSYNC | TXA_DIS_ALLOC | TXA_STOP_RC);

		/* Stop Interval Timer and Limit Counter of Tx Arbiter */
		SK_OUT32(IoC, MR_ADDR(Port, TXA_ITI_INI), 0L);
		SK_OUT32(IoC, MR_ADDR(Port, TXA_LIM_INI), 0L);

		/* Perform a local reset of the port's Tx path */

		/* Reset the PCI FIFO of the async Tx queue */
		SK_OUT32(IoC, Q_ADDR(pPrt->PXaQOff, Q_CSR), CSR_SET_RESET);
		/* Reset the PCI FIFO of the sync Tx queue */
		SK_OUT32(IoC, Q_ADDR(pPrt->PXsQOff, Q_CSR), CSR_SET_RESET);
		/* Reset the RAM Buffer async Tx queue */
		SK_OUT8(IoC, RB_ADDR(pPrt->PXaQOff, RB_CTRL), RB_RST_SET);
		/* Reset the RAM Buffer sync Tx queue */
		SK_OUT8(IoC, RB_ADDR(pPrt->PXsQOff, RB_CTRL), RB_RST_SET);

		/* Reset Tx MAC FIFO */
		if (pAC->GIni.GIGenesis) {
			/* Note: MFF_RST_SET does NOT reset the XMAC ! */
			SK_OUT8(IoC, MR_ADDR(Port, TX_MFF_CTRL2), MFF_RST_SET);

			/* switch Link and Tx LED off, stop the LED counters */
			/* Link LED is switched off by the RLMT and the Diag itself */
			SkGeXmitLED(pAC, IoC, MR_ADDR(Port, TX_LED_INI), SK_LED_DIS);
		}
		else {
			/* Reset TX MAC FIFO */
			SK_OUT8(IoC, MR_ADDR(Port, TX_GMF_CTRL_T), (SK_U8)GMF_RST_SET);
		}
	}

	if ((Dir & SK_STOP_RX) != 0) {
		/*
		 * The RX Stop Command will not terminate if no buffers
		 * are queued in the RxD ring. But it will always reach
		 * the Idle state. Therefore we can use this feature to
		 * stop the transfer of received packets.
		 */
		/* stop the port's receive queue */
		SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_CSR), CSR_STOP);

		i = 100;
		do {
			/*
			 * Clear packet arbiter timeout to make sure
			 * this loop will terminate
			 */
			SK_OUT16(IoC, B3_PA_CTRL, (Port == MAC_1) ? PA_CLR_TO_RX1 :
				PA_CLR_TO_RX2);

			DWord = TestStopBit(pAC, IoC, pPrt->PRxQOff);

			/* timeout if i==0 (bug fix for #10748) */
			if (--i == 0) {
				SK_ERR_LOG(pAC, SK_ERRCL_HW, SKERR_HWI_E024,
					SKERR_HWI_E024MSG);
				break;
			}
			/*
			 * because of the ASIC problem report entry from 21.08.98
			 * it is required to wait until CSR_STOP is reset and
			 * CSR_SV_IDLE is set.
			 */
		} while ((DWord & (CSR_STOP | CSR_SV_IDLE)) != CSR_SV_IDLE);

		/* The path data transfer activity is fully stopped now */

		/* Perform a local reset of the port's Rx path */

		 /*	Reset the PCI FIFO of the Rx queue */
		SK_OUT32(IoC, Q_ADDR(pPrt->PRxQOff, Q_CSR), CSR_SET_RESET);
		/* Reset the RAM Buffer receive queue */
		SK_OUT8(IoC, RB_ADDR(pPrt->PRxQOff, RB_CTRL), RB_RST_SET);

		/* Reset Rx MAC FIFO */
		if (pAC->GIni.GIGenesis) {

			SK_OUT8(IoC, MR_ADDR(Port, RX_MFF_CTRL2), MFF_RST_SET);

			/* switch Rx LED off, stop the LED counter */
			SkGeXmitLED(pAC, IoC, MR_ADDR(Port, RX_LED_INI), SK_LED_DIS);
		}
		else {
			/* Reset Rx MAC FIFO */
			SK_OUT8(IoC, MR_ADDR(Port, RX_GMF_CTRL_T), (SK_U8)GMF_RST_SET);
		}
	}
}	/* SkGeStopPort */


/******************************************************************************
 *
 *	SkGeInit0() - Level 0 Initialization
 *
 * Description:
 *	- Initialize the BMU address offsets
 *
 * Returns:
 *	nothing
 */
static void SkGeInit0(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	int i;
	SK_GEPORT *pPrt;

	for (i = 0; i < SK_MAX_MACS; i++) {
		pPrt = &pAC->GIni.GP[i];

		pPrt->PState = SK_PRT_RESET;
		pPrt->PRxQOff = QOffTab[i].RxQOff;
		pPrt->PXsQOff = QOffTab[i].XsQOff;
		pPrt->PXaQOff = QOffTab[i].XaQOff;
		pPrt->PCheckPar = SK_FALSE;
		pPrt->PIsave = 0;
		pPrt->PPrevShorts = 0;
		pPrt->PLinkResCt = 0;
		pPrt->PAutoNegTOCt = 0;
		pPrt->PPrevRx = 0;
		pPrt->PPrevFcs = 0;
		pPrt->PRxLim = SK_DEF_RX_WA_LIM;
		pPrt->PLinkMode = SK_LMODE_AUTOFULL;
		pPrt->PLinkSpeedCap = SK_LSPEED_CAP_1000MBPS;
		pPrt->PLinkSpeed = SK_LSPEED_1000MBPS;
		pPrt->PLinkSpeedUsed = SK_LSPEED_STAT_UNKNOWN;
		pPrt->PLinkModeConf = SK_LMODE_AUTOSENSE;
		pPrt->PFlowCtrlMode = SK_FLOW_MODE_SYM_OR_REM;
		pPrt->PLinkBroken = SK_TRUE; /* See WA code */
		pPrt->PLinkCap = (SK_LMODE_CAP_HALF | SK_LMODE_CAP_FULL |
				SK_LMODE_CAP_AUTOHALF | SK_LMODE_CAP_AUTOFULL);
		pPrt->PLinkModeStatus = SK_LMODE_STAT_UNKNOWN;
		pPrt->PFlowCtrlCap = SK_FLOW_MODE_SYM_OR_REM;
		pPrt->PFlowCtrlStatus = SK_FLOW_STAT_NONE;
		pPrt->PMSCap = 0;
		pPrt->PMSMode = SK_MS_MODE_AUTO;
		pPrt->PMSStatus = SK_MS_STAT_UNSET;
		pPrt->PAutoNegFail = SK_FALSE;
		pPrt->PLipaAutoNeg = SK_LIPA_UNKNOWN;
		pPrt->PHWLinkUp = SK_FALSE;
	}

	pAC->GIni.GIPortUsage = SK_RED_LINK;

}	/* SkGeInit0*/

#ifdef SK_PCI_RESET

/******************************************************************************
 *
 *	SkGePciReset() - Reset PCI interface
 *
 * Description:
 *	o Read PCI configuration.
 *	o Change power state to 3.
 *	o Change power state to 0.
 *	o Restore PCI configuration.
 *
 * Returns:
 *	0:	Success.
 *	1:	Power state could not be changed to 3.
 */
static int SkGePciReset(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	int		i;
	SK_U16	PmCtlSts;
	SK_U32	Bp1;
	SK_U32	Bp2;
	SK_U16	PciCmd;
	SK_U8	Cls;
	SK_U8	Lat;
	SK_U8	ConfigSpace[PCI_CFG_SIZE];

	/*
	 * Note: Switching to D3 state is like a software reset.
	 *		 Switching from D3 to D0 is a hardware reset.
	 *		 We have to save and restore the configuration space.
	 */
	for (i = 0; i < PCI_CFG_SIZE; i++) {
		SkPciReadCfgDWord(pAC, i*4, &ConfigSpace[i]);
	}

	/* We know the RAM Interface Arbiter is enabled. */
	SkPciWriteCfgWord(pAC, PCI_PM_CTL_STS, PCI_PM_STATE_D3);
	SkPciReadCfgWord(pAC, PCI_PM_CTL_STS, &PmCtlSts);

	if ((PmCtlSts & PCI_PM_STATE_MSK) != PCI_PM_STATE_D3) {
		return(1);
	}

	/* Return to D0 state. */
	SkPciWriteCfgWord(pAC, PCI_PM_CTL_STS, PCI_PM_STATE_D0);

	/* Check for D0 state. */
	SkPciReadCfgWord(pAC, PCI_PM_CTL_STS, &PmCtlSts);

	if ((PmCtlSts & PCI_PM_STATE_MSK) != PCI_PM_STATE_D0) {
		return(1);
	}

	/* Check PCI Config Registers. */
	SkPciReadCfgWord(pAC, PCI_COMMAND, &PciCmd);
	SkPciReadCfgByte(pAC, PCI_CACHE_LSZ, &Cls);
	SkPciReadCfgDWord(pAC, PCI_BASE_1ST, &Bp1);
	SkPciReadCfgDWord(pAC, PCI_BASE_2ND, &Bp2);
	SkPciReadCfgByte(pAC, PCI_LAT_TIM, &Lat);

	if (PciCmd != 0 || Cls != 0 || (Bp1 & 0xfffffff0L) != 0 || Bp2 != 1 ||
		Lat != 0) {
		return(1);
	}

	/* Restore PCI Config Space. */
	for (i = 0; i < PCI_CFG_SIZE; i++) {
		SkPciWriteCfgDWord(pAC, i*4, ConfigSpace[i]);
	}

	return(0);
}	/* SkGePciReset */

#endif /* SK_PCI_RESET */

/******************************************************************************
 *
 *	SkGeInit1() - Level 1 Initialization
 *
 * Description:
 *	o Do a software reset.
 *	o Clear all reset bits.
 *	o Verify that the detected hardware is present.
 *	  Return an error if not.
 *	o Get the hardware configuration
 *		+ Read the number of MACs/Ports.
 *		+ Read the RAM size.
 *		+ Read the PCI Revision Id.
 *		+ Find out the adapters host clock speed
 *		+ Read and check the PHY type
 *
 * Returns:
 *	0:	success
 *	5:	Unexpected PHY type detected
 *	6:	HW self test failed
 */
static int SkGeInit1(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	SK_U8	Byte;
	SK_U16	Word;
	SK_U16	CtrlStat;
	SK_U32	FlashAddr;
	int	RetVal;
	int	i;

	RetVal = 0;

	/* save CLK_RUN bits (YUKON-Lite) */
	SK_IN16(IoC, B0_CTST, &CtrlStat);

#ifdef SK_PCI_RESET
	(void)SkGePciReset(pAC, IoC);
#endif /* SK_PCI_RESET */

	/* do the SW-reset */
	SK_OUT8(IoC, B0_CTST, CS_RST_SET);

	/* release the SW-reset */
	SK_OUT8(IoC, B0_CTST, CS_RST_CLR);

	/* reset all error bits in the PCI STATUS register */
	/*
	 * Note: PCI Cfg cycles cannot be used, because they are not
	 *		 available on some platforms after 'boot time'.
	 */
	SK_IN16(IoC, PCI_C(PCI_STATUS), &Word);

	SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
	SK_OUT16(IoC, PCI_C(PCI_STATUS), Word | PCI_ERRBITS);
	SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);

	/* release Master Reset */
	SK_OUT8(IoC, B0_CTST, CS_MRST_CLR);

#ifdef CLK_RUN
	CtrlStat |= CS_CLK_RUN_ENA;
#endif /* CLK_RUN */

	/* restore CLK_RUN bits */
	SK_OUT16(IoC, B0_CTST, CtrlStat &
		(CS_CLK_RUN_HOT | CS_CLK_RUN_RST | CS_CLK_RUN_ENA));

	/* read Chip Identification Number */
	SK_IN8(IoC, B2_CHIP_ID, &Byte);
	pAC->GIni.GIChipId = Byte;

	/* read number of MACs */
	SK_IN8(IoC, B2_MAC_CFG, &Byte);
	pAC->GIni.GIMacsFound = (Byte & CFG_SNG_MAC) ? 1 : 2;

	/* get Chip Revision Number */
	pAC->GIni.GIChipRev = (SK_U8)((Byte & CFG_CHIP_R_MSK) >> 4);

	/* get diff. PCI parameters */
	SK_IN16(IoC, B0_CTST, &CtrlStat);

	/* read the adapters RAM size */
	SK_IN8(IoC, B2_E_0, &Byte);

	if (pAC->GIni.GIChipId == CHIP_ID_GENESIS) {

		pAC->GIni.GIGenesis = SK_TRUE;

		if (Byte == 3) {
			/* special case: 4 x 64k x 36, offset = 0x80000 */
			pAC->GIni.GIRamSize = 1024;
			pAC->GIni.GIRamOffs = (SK_U32)512 * 1024;
		}
		else {
			pAC->GIni.GIRamSize = (int)Byte * 512;
			pAC->GIni.GIRamOffs = 0;
		}
		/* all GE adapters work with 53.125 MHz host clock */
		pAC->GIni.GIHstClkFact = SK_FACT_53;

		/* set Descr. Poll Timer Init Value to 250 ms */
		pAC->GIni.GIPollTimerVal =
			SK_DPOLL_DEF * (SK_U32)pAC->GIni.GIHstClkFact / 100;
	}
	else {
		pAC->GIni.GIGenesis = SK_FALSE;

#ifndef VCPU
		pAC->GIni.GIRamSize = (Byte == 0) ? 128 : (int)Byte * 4;
#else
		pAC->GIni.GIRamSize = 128;
#endif
		pAC->GIni.GIRamOffs = 0;

		/* WA for chip Rev. A */
		pAC->GIni.GIWolOffs = (pAC->GIni.GIChipRev == 0) ? WOL_REG_OFFS : 0;

		/* get PM Capabilities of PCI config space */
		SK_IN16(IoC, PCI_C(PCI_PM_CAP_REG), &Word);

		/* check if VAUX is available */
		if (((CtrlStat & CS_VAUX_AVAIL) != 0) &&
			/* check also if PME from D3cold is set */
			((Word & PCI_PME_D3C_SUP) != 0)) {
			/* set entry in GE init struct */
			pAC->GIni.GIVauxAvail = SK_TRUE;
		}

		/* save Flash-Address Register */
		SK_IN32(IoC, B2_FAR, &FlashAddr);

		/* test Flash-Address Register */
		SK_OUT8(IoC, B2_FAR + 3, 0xff);
		SK_IN8(IoC, B2_FAR + 3, &Byte);

		pAC->GIni.GIYukonLite = (SK_BOOL)(Byte != 0);

		/* restore Flash-Address Register */
		SK_OUT32(IoC, B2_FAR, FlashAddr);

		for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
			/* set GMAC Link Control reset */
			SK_OUT16(IoC, MR_ADDR(i, GMAC_LINK_CTRL), GMLC_RST_SET);

			/* clear GMAC Link Control reset */
			SK_OUT16(IoC, MR_ADDR(i, GMAC_LINK_CTRL), GMLC_RST_CLR);
		}
		/* all YU chips work with 78.125 MHz host clock */
		pAC->GIni.GIHstClkFact = SK_FACT_78;

		pAC->GIni.GIPollTimerVal = SK_DPOLL_MAX;	/* 215 ms */
	}

	/* check if 64-bit PCI Slot is present */
	pAC->GIni.GIPciSlot64 = (SK_BOOL)((CtrlStat & CS_BUS_SLOT_SZ) != 0);

	/* check if 66 MHz PCI Clock is active */
	pAC->GIni.GIPciClock66 = (SK_BOOL)((CtrlStat & CS_BUS_CLOCK) != 0);

	/* read PCI HW Revision Id. */
	SK_IN8(IoC, PCI_C(PCI_REV_ID), &Byte);
	pAC->GIni.GIPciHwRev = Byte;

	/* read the PMD type */
	SK_IN8(IoC, B2_PMD_TYP, &Byte);
	pAC->GIni.GICopperType = (SK_U8)(Byte == 'T');

	/* read the PHY type */
	SK_IN8(IoC, B2_E_1, &Byte);

	Byte &= 0x0f;	/* the PHY type is stored in the lower nibble */
	for (i = 0; i < pAC->GIni.GIMacsFound; i++) {

		if (pAC->GIni.GIGenesis) {
			switch (Byte) {
			case SK_PHY_XMAC:
				pAC->GIni.GP[i].PhyAddr = PHY_ADDR_XMAC;
				break;
			case SK_PHY_BCOM:
				pAC->GIni.GP[i].PhyAddr = PHY_ADDR_BCOM;
				pAC->GIni.GP[i].PMSCap =
					SK_MS_CAP_AUTO | SK_MS_CAP_MASTER | SK_MS_CAP_SLAVE;
				break;
#ifdef OTHER_PHY
			case SK_PHY_LONE:
				pAC->GIni.GP[i].PhyAddr = PHY_ADDR_LONE;
				break;
			case SK_PHY_NAT:
				pAC->GIni.GP[i].PhyAddr = PHY_ADDR_NAT;
				break;
#endif /* OTHER_PHY */
			default:
				/* ERROR: unexpected PHY type detected */
				RetVal = 5;
				break;
			}
		}
		else {
			if (Byte == 0) {
				/* if this field is not initialized */
				Byte = SK_PHY_MARV_COPPER;
				pAC->GIni.GICopperType = SK_TRUE;
			}
			pAC->GIni.GP[i].PhyAddr = PHY_ADDR_MARV;

			if (pAC->GIni.GICopperType) {
				pAC->GIni.GP[i].PLinkSpeedCap = SK_LSPEED_CAP_AUTO |
					SK_LSPEED_CAP_10MBPS | SK_LSPEED_CAP_100MBPS |
					SK_LSPEED_CAP_1000MBPS;
				pAC->GIni.GP[i].PLinkSpeed = SK_LSPEED_AUTO;
				pAC->GIni.GP[i].PMSCap =
					SK_MS_CAP_AUTO | SK_MS_CAP_MASTER | SK_MS_CAP_SLAVE;
			}
			else {
				Byte = SK_PHY_MARV_FIBER;
			}
		}

		pAC->GIni.GP[i].PhyType = Byte;

		SK_DBG_MSG(pAC, SK_DBGMOD_HWM, SK_DBGCAT_INIT,
			("PHY type: %d  PHY addr: %04x\n", Byte,
			pAC->GIni.GP[i].PhyAddr));
	}

	/* get Mac Type & set function pointers dependent on */
	if (pAC->GIni.GIGenesis) {
		pAC->GIni.GIMacType = SK_MAC_XMAC;

		pAC->GIni.GIFunc.pFnMacUpdateStats	= SkXmUpdateStats;
		pAC->GIni.GIFunc.pFnMacStatistic	= SkXmMacStatistic;
		pAC->GIni.GIFunc.pFnMacResetCounter	= SkXmResetCounter;
		pAC->GIni.GIFunc.pFnMacOverflow		= SkXmOverflowStatus;
	}
	else {
		pAC->GIni.GIMacType = SK_MAC_GMAC;

		pAC->GIni.GIFunc.pFnMacUpdateStats	= SkGmUpdateStats;
		pAC->GIni.GIFunc.pFnMacStatistic	= SkGmMacStatistic;
		pAC->GIni.GIFunc.pFnMacResetCounter	= SkGmResetCounter;
		pAC->GIni.GIFunc.pFnMacOverflow		= SkGmOverflowStatus;

#ifdef SPECIAL_HANDLING
		if (pAC->GIni.GIChipId == CHIP_ID_YUKON) {
			/* check HW self test result */
			SK_IN8(IoC, B2_E_3, &Byte);
			if ((Byte & B2_E3_RES_MASK) != 0) {
				RetVal = 6;
			}
		}
#endif
	}
	return(RetVal);
}	/* SkGeInit1 */


/******************************************************************************
 *
 *	SkGeInit2() - Level 2 Initialization
 *
 * Description:
 *	- start the Blink Source Counter
 *	- start the Descriptor Poll Timer
 *	- configure the MAC-Arbiter
 *	- configure the Packet-Arbiter
 *	- enable the Tx Arbiters
 *	- enable the RAM Interface Arbiter
 *
 * Returns:
 *	nothing
 */
static void SkGeInit2(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	SK_U32	DWord;
	int		i;

	/* start the Descriptor Poll Timer */
	if (pAC->GIni.GIPollTimerVal != 0) {
		if (pAC->GIni.GIPollTimerVal > SK_DPOLL_MAX) {
			pAC->GIni.GIPollTimerVal = SK_DPOLL_MAX;

			SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E017, SKERR_HWI_E017MSG);
		}
		SK_OUT32(IoC, B28_DPT_INI, pAC->GIni.GIPollTimerVal);
		SK_OUT8(IoC, B28_DPT_CTRL, DPT_START);
	}

	if (pAC->GIni.GIGenesis) {
		/* start the Blink Source Counter */
		DWord = SK_BLK_DUR * (SK_U32)pAC->GIni.GIHstClkFact / 100;

		SK_OUT32(IoC, B2_BSC_INI, DWord);
		SK_OUT8(IoC, B2_BSC_CTRL, BSC_START);

		/*
		 * Configure the MAC Arbiter and the Packet Arbiter.
		 * They will be started once and never be stopped.
		 */
		SkGeInitMacArb(pAC, IoC);

		SkGeInitPktArb(pAC, IoC);
	}
	else {
		/* start Time Stamp Timer */
		SK_OUT8(IoC, GMAC_TI_ST_CTRL, (SK_U8)GMT_ST_START);
	}

	/* enable the Tx Arbiters */
	for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
		SK_OUT8(IoC, MR_ADDR(i, TXA_CTRL), TXA_ENA_ARB);
	}

	/* enable the RAM Interface Arbiter */
	SkGeInitRamIface(pAC, IoC);

}	/* SkGeInit2 */

/******************************************************************************
 *
 *	SkGeInit() - Initialize the GE Adapter with the specified level.
 *
 * Description:
 *	Level	0:	Initialize the Module structures.
 *	Level	1:	Generic Hardware Initialization. The IOP/MemBase pointer has
 *				to be set before calling this level.
 *
 *			o Do a software reset.
 *			o Clear all reset bits.
 *			o Verify that the detected hardware is present.
 *			  Return an error if not.
 *			o Get the hardware configuration
 *				+ Set GIMacsFound with the number of MACs.
 *				+ Store the RAM size in GIRamSize.
 *				+ Save the PCI Revision ID in GIPciHwRev.
 *			o return an error
 *				if Number of MACs > SK_MAX_MACS
 *
 *			After returning from Level 0 the adapter
 *			may be accessed with IO operations.
 *
 *	Level	2:	start the Blink Source Counter
 *
 * Returns:
 *	0:	success
 *	1:	Number of MACs exceeds SK_MAX_MACS	(after level 1)
 *	2:	Adapter not present or not accessible
 *	3:	Illegal initialization level
 *	4:	Initialization Level 1 Call missing
 *	5:	Unexpected PHY type detected
 *	6:	HW self test failed
 */
int	SkGeInit(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Level)		/* initialization level */
{
	int		RetVal;		/* return value */
	SK_U32	DWord;

	RetVal = 0;
	SK_DBG_MSG(pAC, SK_DBGMOD_HWM, SK_DBGCAT_INIT,
		("SkGeInit(Level %d)\n", Level));

	switch (Level) {
	case SK_INIT_DATA:
		/* Initialization Level 0 */
		SkGeInit0(pAC, IoC);
		pAC->GIni.GILevel = SK_INIT_DATA;
		break;

	case SK_INIT_IO:
		/* Initialization Level 1 */
		RetVal = SkGeInit1(pAC, IoC);
		if (RetVal != 0) {
			break;
		}

		/* check if the adapter seems to be accessible */
		SK_OUT32(IoC, B2_IRQM_INI, 0x11335577L);
		SK_IN32(IoC, B2_IRQM_INI, &DWord);
		SK_OUT32(IoC, B2_IRQM_INI, 0L);

		if (DWord != 0x11335577L) {
			RetVal = 2;
			break;
		}

		/* check if the number of GIMacsFound matches SK_MAX_MACS */
		if (pAC->GIni.GIMacsFound > SK_MAX_MACS) {
			RetVal = 1;
			break;
		}

		/* Level 1 successfully passed */
		pAC->GIni.GILevel = SK_INIT_IO;
		break;

	case SK_INIT_RUN:
		/* Initialization Level 2 */
		if (pAC->GIni.GILevel != SK_INIT_IO) {
#ifndef SK_DIAG
			SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E002, SKERR_HWI_E002MSG);
#endif /* !SK_DIAG */
			RetVal = 4;
			break;
		}
		SkGeInit2(pAC, IoC);

		/* Level 2 successfully passed */
		pAC->GIni.GILevel = SK_INIT_RUN;
		break;

	default:
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E003, SKERR_HWI_E003MSG);
		RetVal = 3;
		break;
	}

	return(RetVal);
}	/* SkGeInit */


/******************************************************************************
 *
 *	SkGeDeInit() - Deinitialize the adapter
 *
 * Description:
 *	All ports of the adapter will be stopped if not already done.
 *	Do a software reset and switch off all LEDs.
 *
 * Returns:
 *	nothing
 */
void SkGeDeInit(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC)		/* IO context */
{
	int	i;
	SK_U16	Word;

#ifndef VCPU
	/* ensure I2C is ready */
	SkI2cWaitIrq(pAC, IoC);
#endif

	/* stop all current transfer activity */
	for (i = 0; i < pAC->GIni.GIMacsFound; i++) {
		if (pAC->GIni.GP[i].PState != SK_PRT_STOP &&
			pAC->GIni.GP[i].PState != SK_PRT_RESET) {

			SkGeStopPort(pAC, IoC, i, SK_STOP_ALL, SK_HARD_RST);
		}
	}

	/* Reset all bits in the PCI STATUS register */
	/*
	 * Note: PCI Cfg cycles cannot be used, because they are not
	 *	 available on some platforms after 'boot time'.
	 */
	SK_IN16(IoC, PCI_C(PCI_STATUS), &Word);

	SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_ON);
	SK_OUT16(IoC, PCI_C(PCI_STATUS), Word | PCI_ERRBITS);
	SK_OUT8(IoC, B2_TST_CTRL1, TST_CFG_WRITE_OFF);

	/* do the reset, all LEDs are switched off now */
	SK_OUT8(IoC, B0_CTST, CS_RST_SET);
}	/* SkGeDeInit */


/******************************************************************************
 *
 *	SkGeInitPort()	Initialize the specified port.
 *
 * Description:
 *	PRxQSize, PXSQSize, and PXAQSize has to be
 *	configured for the specified port before calling this function.
 *  The descriptor rings has to be initialized too.
 *
 *	o (Re)configure queues of the specified port.
 *	o configure the MAC of the specified port.
 *	o put ASIC and MAC(s) in operational mode.
 *	o initialize Rx/Tx and Sync LED
 *	o initialize RAM Buffers and MAC FIFOs
 *
 *	The port is ready to connect when returning.
 *
 * Note:
 *	The MAC's Rx and Tx state machine is still disabled when returning.
 *
 * Returns:
 *	0:	success
 *	1:	Queue size initialization error. The configured values
 *		for PRxQSize, PXSQSize, or PXAQSize are invalid for one
 *		or more queues. The specified port was NOT initialized.
 *		An error log entry was generated.
 *	2:	The port has to be stopped before it can be initialized again.
 */
int SkGeInitPort(
SK_AC	*pAC,		/* adapter context */
SK_IOC	IoC,		/* IO context */
int		Port)		/* Port to configure */
{
	SK_GEPORT *pPrt;

	pPrt = &pAC->GIni.GP[Port];

	if (SkGeCheckQSize(pAC, Port) != 0) {
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E004, SKERR_HWI_E004MSG);
		return(1);
	}

	if (pPrt->PState == SK_PRT_INIT || pPrt->PState == SK_PRT_RUN) {
		SK_ERR_LOG(pAC, SK_ERRCL_SW, SKERR_HWI_E005, SKERR_HWI_E005MSG);
		return(2);
	}

	/* configuration ok, initialize the Port now */

	if (pAC->GIni.GIGenesis) {
		/* initialize Rx, Tx and Link LED */
		/*
		 * If 1000BT Phy needs LED initialization than swap
		 * LED and XMAC initialization order
		 */
		SkGeXmitLED(pAC, IoC, MR_ADDR(Port, TX_LED_INI), SK_LED_ENA);
		SkGeXmitLED(pAC, IoC, MR_ADDR(Port, RX_LED_INI), SK_LED_ENA);
		/* The Link LED is initialized by RLMT or Diagnostics itself */

		SkXmInitMac(pAC, IoC, Port);
	}
	else {

		SkGmInitMac(pAC, IoC, Port);
	}

	/* do NOT initialize the Link Sync Counter */

	SkGeInitMacFifo(pAC, IoC, Port);

	SkGeInitRamBufs(pAC, IoC, Port);

	if (pPrt->PXSQSize != 0) {
		/* enable Force Sync bit if synchronous queue available */
		SK_OUT8(IoC, MR_ADDR(Port, TXA_CTRL), TXA_ENA_FSYNC);
	}

	SkGeInitBmu(pAC, IoC, Port);

	/* mark port as initialized */
	pPrt->PState = SK_PRT_INIT;

	return(0);
}	/* SkGeInitPort */

#endif /* CONFIG_SK98 */
