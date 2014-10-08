/*
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Copyright © 2003 Atheros Communications, Inc.,  All Rights Reserved.
 */

/*
 * Manage the atheros ethernet PHY.
 *
 * All definitions in this file are operating system independent!
 */

#include <config.h>
#include <linux/types.h>
#include <common.h>
#include <miiphy.h>
#include "ar7100_soc.h"
#include "rtl8366sr_phy.h"

#define DEBUG_MSG 
//#define DEBUG_MSG printf

#define I2CMASTER_SDA_PIN 19//gpio 19
#define I2CMASTER_SCL_PIN 20//gpio 20
#define SWITCH_RESET 21//gpio 21

#define RTL8366RB 0x5937
#define RTL8366SR 0x6027
uint32_t IDregData=0;

/*
 * set_data_in()
 */
static inline void set_data_in(void)
{
	*(volatile int *)(0xb8040000) &= ~(1<<I2CMASTER_SDA_PIN);//change to input
}

/*
 * set_data_out()
 */
static inline void set_data_out(void)
{
	*(volatile int *)(0xb8040000) |= (1<<I2CMASTER_SDA_PIN);//change to output	
}

/*
 * set_clock_in()
 */
static inline void set_clock_in(void)
{
	*(volatile int *)(0xb8040000) &= ~(1<<I2CMASTER_SCL_PIN);//change to input	
}

/*
 * set_clock_out()
 */
static inline void set_clock_out(void)
{
	*(volatile int *)(0xb8040000) |= (1<<I2CMASTER_SCL_PIN);//change to output	
}

/*
 * set_data_pin()
 */
static inline void set_data_pin(uint32_t v)
{		
	if (v) {//high		
		*(volatile int *)(0xb8040008) |= 1<<I2CMASTER_SDA_PIN;
	} else {//low	
		*(volatile int *)(0xb8040008) &= ~(1<<I2CMASTER_SDA_PIN);	
		
	}
}

/*
 * get_data_pin()
 */
static inline uint32_t get_data_pin(void)
{	
	 if((*(volatile unsigned long *)0xb8040004) & (1<<I2CMASTER_SDA_PIN))
	 	return 1;
	 else
	 	return 0;			
}

/*
 * set_clock_pin()
 */
static inline void set_clock_pin(uint32_t v)
{	
	if (v) {//hifh		
		*(volatile int *)(0xb8040008) |= 1<<I2CMASTER_SCL_PIN;
	} else {//low		
		*(volatile int *)(0xb8040008) &= ~(1<<I2CMASTER_SCL_PIN);		
	}
}

#define DELAY 2//us
#define ack_timer					5
#define max_register				0x018A 

uint32_t smi_init(void)
{
	/* change GPIO pin to Input only */
	set_data_in();
	set_clock_in();	
	
	udelay(DELAY);		
	return 0;
}

void _smi_start(void)
{
	/* change GPIO pin to Output only */
	set_data_out();
	set_clock_out();	
	udelay(DELAY);
	/* Initial state: SCK:0,SDA:1 */
	set_clock_pin(0);
	set_data_pin(1);
	udelay(DELAY);

	/* SCK:0 -> 1 -> 0 */
	set_clock_pin(1);
	udelay(DELAY);
	set_clock_pin(0);
	udelay(DELAY);

	/* SCK:1,SDA:0->SCK:0,SDA:1 */
	set_clock_pin(1);
	udelay(DELAY);
	set_data_pin(0);
	udelay(DELAY);
	set_clock_pin(0);
	udelay(DELAY);
	set_data_pin(1);	
}

void _smi_stop(void)
{
	/* SCK:1,SDA:0->SCK:1,SDA:1->SCK:0->1 */
	udelay(DELAY);
	set_data_pin(0);	
	set_clock_pin(1);	
	udelay(DELAY);
	set_data_pin(1);	
	udelay(DELAY);
	set_clock_pin(1);
	udelay(DELAY);
	set_clock_pin(0);
	udelay(DELAY);
	set_clock_pin(1);

    /* SCK:0->1 */
	udelay(DELAY);
	set_clock_pin(0);
	udelay(DELAY);
	set_clock_pin(1);

	/* change GPIO pin to Output only */
	set_data_in();
	set_clock_in();

}


void _smi_writeBit(uint16_t signal, uint32_t bitLen)
{
	for( ; bitLen > 0; bitLen--)
	{
		udelay(DELAY);
		/* prepare data */
		if ( signal & (1<<(bitLen-1)) ) 
			set_data_pin(1);	
		else 
			set_data_pin(0);	
		udelay(DELAY);

		/* clocking */
		set_clock_pin(1);
		udelay(DELAY);
		set_clock_pin(0);
	}
}

void _smi_readBit(uint32_t bitLen, uint32_t *rData) 
{
	uint32_t u;

	/* change GPIO pin to Input only */
	set_data_in();
			
	for (*rData = 0; bitLen > 0; bitLen--)
	{
		udelay(DELAY);
		/* clocking */
		set_clock_pin(1);
		udelay(DELAY);		
		u = get_data_pin();
		//DEBUG_MSG("u=%x\n",u);
		set_clock_pin(0);
		*rData |= (u << (bitLen - 1));		
		//DEBUG_MSG("b=%d,*rData=%x\n",bitLen,*rData);		
	}

	/* change GPIO pin to Output only */
	set_data_out();
}

uint32_t smi_read(uint32_t mAddrs, uint32_t *rData)
{
	uint32_t rawData = 0, ACK;
	uint8_t  con;
	uint32_t ret = 0;
/*
	if ((mAddrs > max_register) || (rData == NULL))  return	1;
*/

	//DEBUG_MSG("smi read mAddrs=0x%x,rData=0x%x\n", mAddrs ,*rData);
	/*Disable CPU interrupt to ensure that the SMI operation is atomic. 
	  The API is based on RTL865X, rewrite the API if porting to other platform.*/
   	//rtlglue_drvMutexLock();

	_smi_start();								/* Start SMI */

	_smi_writeBit(0x0a, 4); 					/* CTRL code: 4'b1010 */

	_smi_writeBit(0x4, 3);						/* CTRL code: 3'b100 */

	_smi_writeBit(0x1, 1);						/* 1: issue READ command */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for issuing READ command*/
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		//DEBUG_MSG("CTRL read fail\n");
		ret = 1;
	}
	//DEBUG_MSG("LSB addrs=0x%x\n",(mAddrs&0xff));
	_smi_writeBit((mAddrs&0xff), 8); 			/* Set reg_addr[7:0] */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for setting reg_addr[7:0] */	
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		 //DEBUG_MSG("LSB addrs fail\n");
		 ret = 1;
	}	 
	//DEBUG_MSG("MSB addrs=0x%x\n",(mAddrs>>8));
	_smi_writeBit((mAddrs>>8), 8); 				/* Set reg_addr[15:8] */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK by RTL8369 */
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		 //DEBUG_MSG("MSB addrs fail\n");
		 ret = 1;
	}	 

	_smi_readBit(8, &rawData);					/* Read DATA [7:0] */
	//DEBUG_MSG("rLSB data=0x%x\n",rawData);
	*rData = rawData&0xff; 
	//DEBUG_MSG("*rData=0x%x\n",*rData);
	_smi_writeBit(0x00, 1);						/* ACK by CPU */

	_smi_readBit(8, &rawData);					/* Read DATA [15: 8] */
	//DEBUG_MSG("rMSB data=0x%x\n",rawData);
	_smi_writeBit(0x01, 1);						/* ACK by CPU */
	*rData |= (rawData<<8);
	//DEBUG_MSG("*rData=0x%x\n",*rData);

	_smi_stop();

	//rtlglue_drvMutexUnlock();/*enable CPU interrupt*/
	//DEBUG_MSG("*rData=0x%x\n",*rData);
	return ret;
}

uint32_t smi_write(uint32_t mAddrs, uint32_t rData)
{

	uint8_t con;
	uint32_t ACK;
	uint32_t ret = 0;	
	
/*
	if ((mAddrs > 0x018A) || (rData > 0xFFFF))  return	1;
*/
	//DEBUG_MSG("smi write mAddrs=0x%x,rData=0x%x\n", mAddrs ,rData);
	/*Disable CPU interrupt to ensure that the SMI operation is atomic. 
	  The API is based on RTL865X, rewrite the API if porting to other platform.*/
   	//rtlglue_drvMutexLock();

	_smi_start();								/* Start SMI */

	_smi_writeBit(0x0a, 4); 					/* CTRL code: 4'b1010 */

	_smi_writeBit(0x4, 3);						/* CTRL code: 3'b100 */

	_smi_writeBit(0x0, 1);						/* 0: issue WRITE command */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for issuing WRITE command*/
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){ 
		//DEBUG_MSG("CTRL write fail\n");
		ret = 1;
	}	
	//DEBUG_MSG("LSB addrs=0x%x\n",(mAddrs&0xff));
	_smi_writeBit((mAddrs&0xff), 8); 			/* Set reg_addr[7:0] */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for setting reg_addr[7:0] */
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		 //DEBUG_MSG("LSB addrs fail\n");
		 ret = 1;
	}	 
	//DEBUG_MSG("MSB addrs=0x%x\n",(mAddrs>>8));
	_smi_writeBit((mAddrs>>8), 8); 				/* Set reg_addr[15:8] */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for setting reg_addr[15:8] */
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		 //DEBUG_MSG("MSB addrs fail\n");
		 ret = 1;
	}
	//DEBUG_MSG("LSB data=0x%x\n",(rData&0xff));
	_smi_writeBit((rData&0xff), 8);				/* Write Data [7:0] out */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);					/* ACK for writting data [7:0] */
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		 //DEBUG_MSG("LSB data fail\n");
		 ret = 1;
	}	 
	//DEBUG_MSG("MSB data=0x%x\n",(rData>>8));
	_smi_writeBit((rData>>8), 8);					/* Write Data [15:8] out */

	con = 0;
	do {
		con++;
		_smi_readBit(1, &ACK);						/* ACK for writting data [15:8] */
	} while ((ACK != 0) && (con < ack_timer));
	if (ACK != 0){
		//DEBUG_MSG("MSB data fail\n");
		ret = 1;
	}	

	_smi_stop();	

	//rtlglue_drvMutexUnlock();/*enable CPU interrupt*/
	
	return ret;
}

/****************************************************************************/
/****************************************************************************/
uint32_t switch_reg_read(uint32_t reg,uint32_t *value)
{    
    uint32_t regData=0;
	uint32_t retVal;
	if(*value)
		*value=0;
	//DEBUG_MSG("sw read reg=0x%x,data=0x%x\n", reg ,*value);
	retVal = smi_read(reg, &regData);
	if (retVal != 0){
		DEBUG_MSG("smi_read fail\n");
		return 1;
	}	
	*value = regData;    
	//DEBUG_MSG("sw read reg=0x%x,data=0x%x\n", reg ,*value);
    return 0;
}

void switch_reg_write(uint32_t reg, uint32_t data)
{
    uint32_t retVal;
	//DEBUG_MSG("sw write reg=0x%x,data=0x%x\n", reg ,data);
	retVal = smi_write(reg, data);
	if (retVal != 0) 
		DEBUG_MSG("smi_write fail\n");		

}

/*=======================================================================
 * 1. Asic read/write driver through SMI
 *========================================================================*/
/*
@func int32 | rtl8366s_getAsicReg | Get content of register.
@parm uint32 | reg | Register's address.
@parm uint32* | value | Value of register.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@comm
 	Value 0x0000 will be returned for ASIC un-mapping address.
	
*/
static uint32_t rtl8366s_getAsicReg(uint32_t reg, uint32_t *value)
{
    if (value==NULL){ 
    	DEBUG_MSG("getAsicReg val null\n");	
    	return FAILED;
    }	
    
    if(switch_reg_read(reg,value)){
    	DEBUG_MSG("switch_reg_read fail\n");
    	return FAILED;
    }
    else{    	
    	return SUCCESS;
    }	    
}


/*
@func uint32_t | rtl8366s_setAsicRegBit | Set a bit value of a specified register.
@parm uint32_t | reg | Register's address.
@parm uint32_t | bit | Bit location. For 16-bits register only. Maximun value is 15 for MSB location.
@parm uint32_t | value | Value to set. It can be value 0 or 1.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue TBLDRV_EINVALIDINPUT | Invalid input parameter. 
@comm
	Set a bit of a specified register to 1 or 0. It is 16-bits system of RTL8366s chip.
	
*/
uint32_t rtl8366s_setAsicRegBit(uint32_t reg, uint32_t bit, uint32_t value)
{
	uint32_t regData;
	uint32_t retVal;
	
	if(bit>=16){
		DEBUG_MSG("rtl8366s_setAsicRegBit: bit fial\n");
		return 1;
	}	

	retVal = smi_read(reg, &regData);
	if (retVal != 0){
		DEBUG_MSG("rtl8366s_setAsicRegBit: smi_read fail\n");
		return 1;
	}	

	if (value) 
		regData = regData | (1<<bit);
	else
		regData = regData & (~(1<<bit));
	
	retVal = smi_write(reg, regData);
	if (retVal != 0){
		DEBUG_MSG("rtl8366s_setAsicRegBit: smi_write fail\n");
		return 1;
	}

	return SUCCESS;
}

/*
@func uint32_t | rtl8366s_setAsicRegBits | Set bits value of a specified register.
@parm uint32 | reg | Register's address.
@parm uint32 | bits | Bits mask for setting. 
@parm uint32 | value | Bits value for setting. Value of bits will be set with mapping mask bit is 1.   
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue TBLDRV_EINVALIDINPUT | Invalid input parameter. 
@comm
	Set bits of a specified register to value. Both bits and value are be treated as bit-mask.
	
*/
uint32_t rtl8366s_setAsicRegBits(uint32_t reg, uint32_t bits, uint32_t value)
{
	uint32_t regData;
	uint32_t retVal;
	
	if(bits>= (1<<16)){
		DEBUG_MSG("rtl8366s_setAsicRegBits: bit fial\n");
		return 1;
	}	

	retVal = smi_read(reg, &regData);
	if (retVal != 0){
		DEBUG_MSG("rtl8366s_setAsicRegBits: smi_read fail\n");
		return 1;
	}	

	regData = regData & (~bits);
	regData = regData | (value & bits);

	
	retVal = smi_write(reg, regData);
	if (retVal != 0){
		DEBUG_MSG("rtl8366s_setAsicRegBits: smi_write fail\n");
		return 1;
	}
		
	return SUCCESS;
}

/*
@func int32 | rtl8366s_setAsicReg | Set content of asic register.
@parm uint32 | reg | Register's address.
@parm uint32 | value | Value setting to register.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@comm
	The value will be set to ASIC mapping address only and it is always return SUCCESS while setting un-mapping address registers.
	
*/
static uint32_t rtl8366s_setAsicReg(uint32_t reg, uint32_t value)
{
    switch_reg_write(reg, value);
    return SUCCESS;
}

/*
@func uint32_t | rtl8366s_getAsicPHYReg | Set PHY registers .
@parm uint32_t | phyNo | PHY number (0~4).
@parm uint32_t | page | PHY page (0~7).
@parm uint32_t | addr | PHY address (0~32).
@parm uint32_t* | data | Read data.
@rvalue SUCCESS | 
@rvalue FAILED | invalid parameter
@comm
 */
uint32_t rtl8366s_getAsicPHYRegs( uint32_t phyNo, uint32_t page, uint32_t addr, uint32_t *data )
{
	uint32_t retVal,phySmiAddr;	
	
	if(phyNo > RTL8366S_PHY_NO_MAX){
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: phyNo fail\n");
		return FAILED;
	}	

	if(page > RTL8366S_PHY_PAGE_MAX){
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: page fail\n");
		return FAILED;
	}	

	if(addr > RTL8366S_PHY_ADDR_MAX){
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: addr fail\n");
		return FAILED;
	}	
	//DEBUG_MSG("rtl8366s_getAsicPHYRegs: phyNo=%x,page=%x ,addr=%x\n",phyNo,page,addr);
	retVal = rtl8366s_setAsicReg(RTL8366S_PHY_ACCESS_CTRL_REG, RTL8366S_PHY_CTRL_READ);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: rtl8366s_setAsicReg cma fail\n");
		return retVal;
	}	

	phySmiAddr = 0x8000 | (1<<(phyNo +RTL8366S_PHY_NO_OFFSET)) | 
			//(addr &RTL8366S_PHY_REG_MASK);
			((page <<RTL8366S_PHY_PAGE_OFFSET)&RTL8366S_PHY_PAGE_MASK) | (addr &RTL8366S_PHY_REG_MASK);
	
	retVal = rtl8366s_setAsicReg(phySmiAddr, 0);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: rtl8366s_setAsicReg addr fail\n");
		return retVal;
	}	
	
	retVal = rtl8366s_getAsicReg(RTL8366S_PHY_ACCESS_DATA_REG,data);
	if(retVal !=  SUCCESS){
		DEBUG_MSG("rtl8366s_getAsicPHYRegs: rtl8366s_getAsicReg fail\n");
		return retVal;
	}	

	return SUCCESS;	
}

/*
@func uint32_t | rtl8366s_setAsicPHYReg | Set PHY registers .
@parm uint32_t | phyNo | PHY number (0~4).
@parm uint32_t | page | PHY page (0~7).
@parm uint32_t | addr | PHY address (0~32).
@parm uint32_t | data | Writing data.
@rvalue SUCCESS | 
@rvalue FAILED | invalid parameter
@comm
 */
uint32_t rtl8366s_setAsicPHYRegs( uint32_t phyNo, uint32_t page, uint32_t addr, uint32_t data )
{
	uint32_t retVal,phySmiAddr;
		
	if(phyNo > RTL8366S_PHY_NO_MAX){
		DEBUG_MSG("rtl8366s_setAsicPHYRegs: phyNo fail\n");
		return FAILED;
	}	

	if(page > RTL8366S_PHY_PAGE_MAX){
		DEBUG_MSG("rtl8366s_setAsicPHYRegs: page fail\n");
		return FAILED;
	}	

	if(addr > RTL8366S_PHY_ADDR_MAX){
		DEBUG_MSG("rtl8366s_setAsicPHYRegs: addr fail\n");
		return FAILED;
	}	

	retVal = rtl8366s_setAsicReg(RTL8366S_PHY_ACCESS_CTRL_REG, RTL8366S_PHY_CTRL_WRITE);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_setAsicPHYRegs: rtl8366s_setAsicReg cmd fail\n");
		return retVal;
	}	

	phySmiAddr = 0x8000 | (1<<(phyNo +RTL8366S_PHY_NO_OFFSET)) | 
			//(addr &RTL8366S_PHY_REG_MASK);
			((page <<RTL8366S_PHY_PAGE_OFFSET)&RTL8366S_PHY_PAGE_MASK) | (addr &RTL8366S_PHY_REG_MASK);
	
	retVal = rtl8366s_setAsicReg(phySmiAddr, data);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_setAsicPHYRegs: rtl8366s_setAsicReg addr fail\n");
		return retVal;
	}	

	return SUCCESS;	
}

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getAsicPortLinkState | Get a specific port's link state.
@parm enum PORTID | port | Physical Port number.
@parm enum PORTLINKSPEED  * | speed | current link speed, 
	SPD_10M: 10Mbps,0 
	SPD_100M: 100Mbps,1
	SPD_1000M: 1000Mbps.2
@parm enum PORTLINKDUPLEXMODE * | duplex | current duplex status,
	FULL_DUPLEX: full duplex,1 
	HALF_DUPLEX: half duplex.0
@parm uint32_t  * | link | Link status, 1: link up, 0: link down.
@parm uint32_t  * | rxPause | The pause frame response ability, 1: active, 0: inactive.
@parm uint32_t  * | txPause | The pause frame transmit ability, 1: active, 0: inactive.
@parm uint32_t  * | nWay | N-way function, 1: enable, 0: disable.
@rvalue SUCCESS | Success.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	The API can get a specific port's link state information including link up/down, 
	link speed, auto negotiation enabled/disabled, Tx in active/inactive and Rx in 
	active/inactive. 
*/
uint32_t rtl8366s_getAsicPortLinkState(enum PORTID port, enum PORTLINKSPEED *speed, enum PORTLINKDUPLEXMODE *duplex,uint32_t *link, uint32_t *txPause,uint32_t *rxPause,uint32_t *nWay)
{
	uint32_t retVal;
	uint32_t RegData;
	
	if(port <PORT0 || port >=PORT_MAX){
		DEBUG_MSG("rtl8366s_getAsicPortLinkState: port fail\n");
		return FAILED;
	}	

	retVal = rtl8366s_getAsicReg(RTL8366S_PORT_LINK_STATUS_BASE + (port >>1),&RegData);
	if(SUCCESS != retVal){
		DEBUG_MSG("rtl8366s_getAsicPortLinkState: rtl8366s_getAsicReg fail\n");	
		return FAILED;
	}	
	
	if(port&0x1)
	{
		RegData = RegData >> 8;
	}

	*speed = (RegData & RTL8366S_PORT_STATUS_SPEED_MSK)>>RTL8366S_PORT_STATUS_SPEED_BIT;
	DEBUG_MSG("port%d: *speed=%d\n",port,*speed);
	*duplex = (RegData & RTL8366S_PORT_STATUS_DUPLEX_MSK)>>RTL8366S_PORT_STATUS_DUPLEX_BIT;
	DEBUG_MSG("*duplex=%d\n",*duplex);
	*link = (RegData & RTL8366S_PORT_STATUS_LINK_MSK)>>RTL8366S_PORT_STATUS_LINK_BIT;
	DEBUG_MSG("*link=%d\n",*link);
	*txPause = (RegData & RTL8366S_PORT_STATUS_TXPAUSE_MSK)>>RTL8366S_PORT_STATUS_TXPAUSE_BIT;
	DEBUG_MSG("*txPause=%d\n",*txPause);
	*rxPause = (RegData & RTL8366S_PORT_STATUS_RXPAUSE_MSK)>>RTL8366S_PORT_STATUS_RXPAUSE_BIT;
	DEBUG_MSG("*rxPause=%d\n",*rxPause);
	*nWay = (RegData & RTL8366S_PORT_STATUS_AN_MSK)>>RTL8366S_PORT_STATUS_AN_BIT;
	DEBUG_MSG("*nWay=%d\n",*nWay);
	return SUCCESS;
}
#endif

/*
@func uint32_t | rtl8366s_setAsicMacForceLink | Set mac force linking configuration.
@parm enum PORTID | port | Port/MAC number (0~5).
@parm enum MACLINKMODE | force | Mac link mode 1:force mode 0:normal
@parm enum PORTLINKSPEED | speed | Speed of the port 0b00-10M, 0b01-100M,0b10-1000M, 0b11 reserved.
@parm enum PORTLINKDUPLEXMODE | duplex | Deuplex mode 0b0-half duplex 0b1-full duplex.
@parm uint32_t | link | Link status 0b0-link down b1-link up.
@parm uint32_t | txPause | Pause frame transmit ability of the port 0b0-inactive 0b1-active.
@parm uint32_t | rxPause | Pause frame response ability of the port 0b0-inactive 0b1-active.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue FAILED | Invalid parameter.
@comm
  	This API can set Port/MAC force mode properties. 
 */
uint32_t rtl8366s_setAsicMacForceLink(enum PORTID port,enum MACLINKMODE force,enum PORTLINKSPEED speed,enum PORTLINKDUPLEXMODE duplex,uint32_t link,uint32_t txPause,uint32_t rxPause)
{
	uint32_t retVal;
	uint32_t macData;
	uint32_t regBits;
	uint32_t regAddr;
	uint32_t regData;
	
	/* Invalid input parameter */
	if(port >=PORT_MAX){
		DEBUG_MSG("rtl8366s_setAsicMacForceLink: port fail\n");
		return FAILED;
	}	

	/*not force mode*/
	if(MAC_NORMAL == force)
	{
		retVal = rtl8366s_getAsicReg(RTL8366S_MAC_FORCE_CTRL0_REG,&regData);
		if (retVal !=  SUCCESS){ 
			DEBUG_MSG("rtl8366s_setAsicMacForceLink: rtl8366s_getAsicReg fail\n");	
			return retVal;
		}	
		
		regData = regData & (~(1<<port));

		retVal = rtl8366s_setAsicReg(RTL8366S_MAC_FORCE_CTRL1_REG,regData);
		if (retVal !=  SUCCESS){ 
			DEBUG_MSG("rtl8366s_setAsicMacForceLink: rtl8366s_setAsicReg fail\n");	
			return retVal;
		}	

		return SUCCESS;
	}


	if(speed > SPD_1000M){
		DEBUG_MSG("rtl8366s_setAsicMacForceLink: spped fail\n");	
		return FAILED;
	}	

	/*prepare force status first*/
	macData = speed;

	if(duplex)
	{
		macData = macData | (duplex<<2);
	}

	if(link)
	{
		macData = macData | (link<<4);
	}

	if(txPause)
	{
		macData = macData | (txPause<<5);
	}
	
	if(rxPause)
	{
		macData = macData | (rxPause<<6);
	}
	
	regBits = 0xFF << (8*(port&0x01));
	macData = macData <<(8*(port&0x01));
	
	/* Set register value */
	regAddr = RTL8366S_PORT_ABILITY_BASE + (port>>1);


	retVal= rtl8366s_setAsicRegBits(regAddr,regBits,macData);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_setAsicMacForceLink: rtl8366s_setAsicRegBits fail\n");	
		return retVal;
	}	


	/* Get register value */
	retVal = rtl8366s_getAsicReg(RTL8366S_MAC_FORCE_CTRL0_REG,&regData);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_setAsicMacForceLink: rtl8366s_getAsicReg fail\n");
		return retVal;
	}	

	regData = regData | (1<<port);

	retVal = rtl8366s_setAsicReg(RTL8366S_MAC_FORCE_CTRL1_REG,regData);
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_setAsicMacForceLink: rtl8366s_setAsicRegBits fail\n");	
		return retVal;
	}	

	return SUCCESS;
}
	
/*
@func uint32_t | rtl8366s_setMac5ForceLink | Set Port/MAC 5 force linking configuration.
@parm enum PORTLINKSPEED | speed | Speed of the port 0b00-10M, 0b01-100M,0b10-1000M, 0b11 reserved.
@parm enum PORTLINKDUPLEXMODE | duplex | Deuplex mode 0b0-half duplex 0b1-full duplex.
@parm uint32_t | link | Link status 0b0-link down b1-link up.
@parm uint32_t | txPause | Pause frame transmit ability of the port 0b0-inactive 0b1-active.
@parm uint32_t | rxPause | Pause frame response ability of the port 0b0-inactive 0b1-active.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue FAILED | Invalid parameter.
@comm
  	This API can set Port/MAC 5 properties in force mode. 
 */
uint32_t rtl8366s_setMac5ForceLink(enum PORTLINKSPEED speed,enum PORTLINKDUPLEXMODE duplex,uint32_t link,uint32_t txPause,uint32_t rxPause)
{
	if(speed > SPD_1000M){
		DEBUG_MSG("rtl8366s_setMac5ForceLink: speed fail\n");	
		return FAILED;
	}	

	if(SUCCESS != rtl8366s_setAsicMacForceLink(PORT5,1,speed,duplex,link,txPause,rxPause)){
		DEBUG_MSG("rtl8366s_setAsicMacForceLink fail\n");	
		return FAILED;
	}	

	return SUCCESS;
}	

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getMac5ForceLink | Set Port/MAC 5 force linking configuration.
@parm enum PORTLINKSPEED* | speed | Speed of the port 0b00-10M, 0b01-100M,0b10-1000M, 0b11 reserved.
@parm enum PORTLINKDUPLEXMODE* | duplex | Deuplex mode 0b0-half duplex 0b1-full duplex.
@parm uint32_t* | link | Link status 0b0-link down b1-link up.
@parm uint32_t* | txPause | Pause frame transmit ability of the port 0b0-inactive 0b1-active.
@parm uint32_t* | rxPause | Pause frame response ability of the port 0b0-inactive 0b1-active.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue FAILED | Invalid parameter.
@comm
  	This API can set Port/MAC 5 properties in force mode. 
 */
uint32_t rtl8366s_getMac5ForceLink(enum PORTLINKSPEED* speed,enum PORTLINKDUPLEXMODE* duplex,uint32_t* link,uint32_t* txPause,uint32_t* rxPause)
{
	uint32_t autoNegotiation;
	if(SUCCESS != rtl8366s_getAsicPortLinkState(PORT5,speed,duplex,link,txPause,rxPause,&autoNegotiation)){
		DEBUG_MSG("rtl8366s_getAsicPortLinkState fail\n");
		return FAILED;
	}		

	return SUCCESS;
}
#endif
/*
@func uint32_t | rtl8366s_getPHYLinkStatus | Get ethernet PHY linking status
@parm uint32_t | phy | PHY number (0~4).
@parm uint32_t* | linkStatus | PHY link status 1:link up 0:link down
@rvalue SUCCESS | Success.
@rvalue FAILED | Failure. 
@comm
	Output link status of bit 2 in PHY register 1. API will return status is link up under both auto negotiation complete and link status are set to 1.  
*/
uint32_t rtl8366s_getPHYLinkStatus(uint32_t phy, uint32_t *linkStatus)
{
	uint32_t phyData;

	if(phy > RTL8366S_PHY_NO_MAX){
		DEBUG_MSG("rtl8366s_getPHYLinkStatus: phy fail\n");
		return FAILED;
	}	

	/*Get PHY status register*/
	if(SUCCESS != rtl8366s_getAsicPHYRegs(phy,0,MII_STATUS_REG,&phyData)){
		DEBUG_MSG("rtl8366s_getPHYLinkStatus: rtl8366s_getAsicPHYRegs fail\n");
		return FAILED;
	}	

	/*check link status*/
	if(phyData & (1<<2))
	{
		*linkStatus = 1;
	}
	else
	{
		*linkStatus = 0;	
	}

	return SUCCESS;
}

#ifdef CPU_PORT//*********************************************
/*
@func uint32_t | rtl8366s_setAsicCpuPortMask| Configure cpu port
@parm enum PORTID | port | Physical port number.
@parm uint32_t | enabled | 0:disable 1:enable
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid Port Number.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	The API can specify cpu port. All the frames send to cpu port will be
	inserted proprietary cpu tag 0x8899 if NOT disable insert CPU tag function.

*/
uint32_t rtl8366s_setAsicCpuPortMask(enum PORTID port, uint32_t enabled)
{
	uint32_t retVal;

	if(port >= PORT_MAX){
		DEBUG_MSG("rtl8366s_setAsicCpuPortMask: phy fail\n");
		return FAILED;
	}	

	retVal = rtl8366s_setAsicRegBit(RTL8366S_CPU_CTRL_REG,port,enabled);		

	return retVal;	
}

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getAsicCpuPortMask| Get cpu port
@parm enum PORTID | port | Physical port number.
@parm uint32_t* | enabled | 0:disable 1:enable
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid Port Number.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	The API can check if the specified port is a CPU port.

*/
uint32_t rtl8366s_getAsicCpuPortMask(enum PORTID port, uint32_t* enabled)
{
	uint32_t regData;
	uint32_t retVal;

	if(port >= PORT_MAX){
		DEBUG_MSG("rtl8366s_getAsicCpuPortMask: phy fail\n");
		return FAILED;
	}	

	retVal = rtl8366s_getAsicReg(RTL8366S_CPU_CTRL_REG, &regData);
	if(retVal !=  SUCCESS){
		DEBUG_MSG("rtl8366s_getAsicCpuPortMask: rtl8366s_getAsicReg fail\n");
		return retVal;
	}	

	if(regData & (1<<port))
		*enabled = 1;
	else
		*enabled = 0;

	return SUCCESS;
}
#endif
/*
@func uint32_t | rtl8366s_setAsicCpuDropUnda | Set CPU port drop unknown DA frame function
@parm uint32_t | enable | 0: disable, 1: enable.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	Enable the function to NOT FORWARD unknown DA frame to CPU port	or
	disable the function to FORWARD unknown DA frame to CPU port.	
	It can reduce CPU loading by not forwarding unknown DA frames to CPU port. 
	
*/
uint32_t rtl8366s_setAsicCpuDropUnda(uint32_t enable)
{
	uint32_t retVal;

	retVal = rtl8366s_setAsicRegBit(RTL8366S_CPU_CTRL_REG,RTL8366S_CPU_DRP_BIT,enable);

	return retVal;
}

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getAsicCpuDropUnda | Get setting of CPU port drop unknown DA frame function
@parm uint32_t* | enable | 0: disable, 1: enable.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	The API can get the setting of CPU port drop unknown DA frame function.
	
*/
uint32_t rtl8366s_getAsicCpuDropUnda(uint32_t* enable)
{
	uint32_t regData;
	uint32_t retVal;

	retVal = rtl8366s_getAsicReg(RTL8366S_CPU_CTRL_REG, &regData);
	if(retVal !=  SUCCESS){
		DEBUG_MSG("rtl8366s_getAsicCpuDropUnda: rtl8366s_getAsicReg fail\n");
		return retVal;
	}
	
	if(regData & RTL8366S_CPU_DRP_MSK)
		*enable = 1;
	else
		*enable = 0;
	
	return SUCCESS;
}
#endif
/*
@func uint32_t | rtl8366s_setAsicCpuDisableInsTag | Set CPU port DISABLE insert tag function
@parm uint32_t | enable | 0: disable, 1: enable. 
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	Enable the function to NOT insert proprietary CPU tag (Length/Type 0x8899) ahead vlan tag
	to the frame that transmitted to CPU port or disable the function to insert proprietary CPU tag.
	
*/
uint32_t rtl8366s_setAsicCpuDisableInsTag(uint32_t enable)
{
	uint32_t retVal;

	retVal = rtl8366s_setAsicRegBit(RTL8366S_CPU_CTRL_REG,RTL8366S_CPU_INSTAG_BIT,enable);

	return retVal;
}

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getAsicCpuDisableInsTag | Get setting of CPU port DISABLE insert tag function
@parm uint32_t* | enable | 0: disable, 1: enable. 
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@rvalue ERRNO_INVALIDINPUT | Invalid input parameter.
@comm
	The API can get the setting of CPU port DISABLE insert tag function.
	
*/
uint32_t rtl8366s_getAsicCpuDisableInsTag(uint32_t* enable)
{
	uint32_t regData;
	uint32_t retVal;

	retVal = rtl8366s_getAsicReg(RTL8366S_CPU_CTRL_REG, &regData);
	if(retVal !=  SUCCESS){
		DEBUG_MSG("rtl8366s_getAsicCpuDisableInsTag: rtl8366s_getAsicReg fail\n");
		return retVal;
	}	

	if(regData & RTL8366S_CPU_INSTAG_MSK)
		*enable = 1;
	else
		*enable = 0;
	
	return SUCCESS;
}
#endif
/*
@func uint32_t | rtl8366s_setCPUPort | Set CPU port with/without inserting CPU tag.
@parm enum PORTID | port | Port number to be set as CPU port (0~5).
@parm uint32_t | noTag | NOT insert Realtek proprietary tag (ethernet length/type 0x8899) to frame 1:not insert 0:insert.
@parm uint32_t | dropUnda | NOT forward unknown DMAC frame to CPU port 1:drop 0:forward.
@rvalue ERRNO_API_INVALIDPARAM | invalid input parameters.
@rvalue SUCCESS | Success.
@rvalue FAILED | Failure.
@comm
	The API can set CPU port and enable/disable inserting proprietary CPU tag (Length/Type 0x8899)
	to the frame that transmitting to CPU port. It also can enable/disable forwarding unknown
	destination MAC address frames to CPU port. User can reduce CPU loading by not forwarding
	unknown DA frames to CPU port.
*/
uint32_t rtl8366s_setCPUPort(enum PORTID port, uint32_t noTag, uint32_t dropUnda)
{
	uint32_t i;
	
	if(port >= PORT_MAX){
		DEBUG_MSG("rtl8366s_setCPUPort: phy fail\n");
		return FAILED;
	}	

	/* clean CPU port first */
	for(i=0; i<PORT_MAX; i++)
	{
		if(rtl8366s_setAsicCpuPortMask(i, FALSE) != SUCCESS){
			DEBUG_MSG("rtl8366s_setCPUPort: rtl8366s_setAsicCpuPortMask fail\n");
			return FAILED;	
		}	
	}

	if(rtl8366s_setAsicCpuPortMask(port, TRUE) != SUCCESS){
		DEBUG_MSG("rtl8366s_setCPUPort: rtl8366s_setAsicCpuPortMask fail\n");
		return FAILED;		
	}	

	if(rtl8366s_setAsicCpuDisableInsTag(noTag) != SUCCESS){
		DEBUG_MSG("rtl8366s_setCPUPort: rtl8366s_setAsicCpuDisableInsTag fail\n");
		return FAILED;	
	}	

	if(rtl8366s_setAsicCpuDropUnda(dropUnda) != SUCCESS){
		DEBUG_MSG("rtl8366s_setCPUPort: rtl8366s_setAsicCpuDropUnda fail\n");
		return FAILED;	
	}	

	return SUCCESS;
}

#ifdef GET_INFO
/*
@func uint32_t | rtl8366s_getCPUPort | Get CPU port and its setting.
@parm enum PORTID* | port | returned CPU port (0~5).
@parm uint32_t* | noTag | returned CPU port with insert tag ability 1:not insert 0:insert.
@parm uint32_t* | dropUnda | returned CPU port with forward unknown DMAC frame ability 1:drop 0:forward.
@rvalue ERRNO_API_INVALIDPARAM | invalid input parameters.
@rvalue ERRNO_API_CPUNOTSET | No CPU port speicifed.
@rvalue SUCCESS | Success.
@rvalue FAILED | Failure.
@comm
	The API can get configured CPU port and its setting.
	Return ERRNO_API_CPUNOTSET if CPU port is not speicifed.
*/
uint32_t rtl8366s_getCPUPort(enum PORTID *port, uint32_t *noTag, uint32_t *dropUnda)
{
	uint32_t i;
	uint32_t enable = FALSE;	
	
	if(port == NULL || noTag == NULL || dropUnda == NULL){
		DEBUG_MSG("rtl8366s_getCPUPort: NULL fail\n");
		return FAILED;
	}	

	/* get configured CPU port */
	for(i=0; i<PORT_MAX; i++)
	{
		if(rtl8366s_getAsicCpuPortMask(i, &enable) != SUCCESS){
			DEBUG_MSG("rtl8366s_getCPUPort: rtl8366s_getAsicCpuPortMask fail\n");
			return FAILED;	
		}	

		if(enable == TRUE)
		{
			*port = i;
			if(rtl8366s_getAsicCpuDisableInsTag(noTag) != SUCCESS){
				DEBUG_MSG("rtl8366s_getCPUPort: rtl8366s_getAsicCpuDisableInsTag fail\n");
				return FAILED;				
			}	
			if(rtl8366s_getAsicCpuDropUnda(dropUnda) != SUCCESS){
				DEBUG_MSG("rtl8366s_getCPUPort: rtl8366s_getAsicCpuDropUnda fail\n");
				return FAILED;				
			}	
			
			DEBUG_MSG("CPUport=%d,noTag=%d,dropUnda=%d\n",*port,*noTag,*dropUnda);
			
			return SUCCESS;
		}
	}

	return FAILED;
}
#endif
#endif//CPU_PORT//*********************************************

#ifdef MIB_COUNTER//*********************************************
/*
@func uint32_t | rtl8366s_getAsicMIBsCounter | Get MIBs counter.
@parm enum PORTID | port | Physical port number (0~5).
@num RTL8366S_MIBCOUNTER | mibIdx | MIB counter index.
@parm uint64_t* | counter | MIB retrived counter.
@rvalue SUCCESS | Success.
@rvalue ERRNO_MIB_INVALIDPORT | Invalid port number
@rvalue ERRNO_MIB_INVALIDIDX | Invalid MIBs index.
@rvalue ERRNO_MIB_BUSY | MIB is busy at retrieving
@rvalue ERRNO_MIB_RESET | MIB is resetting.
@comm
 	Before MIBs counter retrieving, writting accessing address to ASIC at first and check the MIB control register status. If busy bit of MIB control is set, that
 	mean MIB counter have been waiting for preparing, then software must wait atfer this busy flag reset by ASIC. This driver did not recycle reading user desired
 	counter. Software must use driver again to get MIB counter if return value is not SUCCESS.

*/
uint32_t rtl8366s_getAsicMIBsCounter(enum PORTID port,enum RTL8366S_MIBCOUNTER mibIdx,uint64_t* counter)
{
	uint32_t retVal;
	uint32_t regAddr;
	uint32_t regData;
	uint32_t regOff;

	/* address offset to MIBs counter */
	const uint16_t mibLength[RTL8366S_MIBS_NUMBER]= {4,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,2,2,2,2,2,2,2,2,2,2,2,2,2};

	uint32_t i;
	uint64_t mibCounter;


	if(port >=PORT_MAX){
		DEBUG_MSG("rtl8366s_getAsicMIBsCounter: port fail\n");
		return FAILED;
	}		

	if(mibIdx>= RTL8366S_MIBS_NUMBER){
		DEBUG_MSG("rtl8366s_getAsicMIBsCounter: mibIdx fail\n");
		return FAILED;
	}	

	if(mibIdx == Dot1dTpLearnEntryDiscardFlag)
	{
		regAddr = RTL8366S_MIB_DOT1DTPLEARNDISCARD;
	}
	else if(mibIdx < Dot1dTpPortInDiscards)
	{
		i = 0;
		regOff = RTL8366S_MIB_COUTER_PORT_OFFSET*(port);

		while(i<mibIdx)
		{
			regOff += mibLength[i];
			i++;
		}		
		
		regAddr = RTL8366S_MIB_COUTER_BASE + regOff;
	}
	else
	{
		i = Dot1dTpPortInDiscards;
		regOff = RTL8366S_MIB_COUTER2_PORT_OFFSET*(port);;
		while(i<mibIdx)
		{
		 	regOff += mibLength[i];
			i++;
		}		

		regAddr = RTL8366S_MIB_COUTER_2_BASE + regOff;
	}

	/*writing access counter address first*/
	/*then ASIC will prepare 64bits counter wait for being retrived*/
	regData = 0;/*writing data will be discard by ASIC*/
	retVal = rtl8366s_setAsicReg(regAddr,regData);


	/*read MIB control register*/
	retVal = rtl8366s_getAsicReg(RTL8366S_MIB_CTRL_REG,&regData);

	if(regData & RTL8366S_MIB_CTRL_BUSY_MSK){
		DEBUG_MSG("rtl8366s_getAsicMIBsCounter: MIB_BUSY fail\n");
		return FAILED;
	}	

	if(regData & RTL8366S_MIB_CTRL_RESET_MSK){
		DEBUG_MSG("rtl8366s_getAsicMIBsCounter: MIB_RESET fail\n");
		return FAILED;		
	}	

	mibCounter = 0;
	regAddr = regAddr + mibLength[mibIdx]-1;
	i = mibLength[mibIdx];
	while(i)
	{
		retVal = rtl8366s_getAsicReg(regAddr,&regData);
		if(retVal != SUCCESS){
			DEBUG_MSG("rtl8366s_getAsicMIBsCounter: rtl8366s_getAsicReg fail\n");
			return retVal;
		}	

		mibCounter = (mibCounter<<16) | (regData & 0xFFFF);

		regAddr --;
		i --;
		
	}
	
	*counter = mibCounter;
	
	return SUCCESS;
}

/*
@func uint32_t | rtl8366s_getMIBCounter | Get MIB counter
@parm enum PORTID | port | Physical port number (0~5).
@num RTL8366S_MIBCOUNTER | mibIdx | MIB counter index.
@parm uint64_t* | counter | MIB retrived counter.
@rvalue SUCCESS | Success.
@rvalue FAILED | Failure. 
@comm
	Get MIB counter by index definition as following description. There are per port MIB counters from index 0 to 32 while index 33 
	is a system-wide counter.
	index	MIB counter												
	0 		IfInOctets
	1		EtherStatsOctets
	2		EtherStatsUnderSizePkts
	3		EtherFregament
	4		EtherStatsPkts64Octets
	5		EtherStatsPkts65to127Octets
	6		EtherStatsPkts128to255Octets
	7		EtherStatsPkts256to511Octets
	8		EtherStatsPkts512to1023Octets
	9		EtherStatsPkts1024to1518Octets
	10		EtherOversizeStats
	11		EtherStatsJabbers
	12		IfInUcastPkts
	13		EtherStatsMulticastPkts
	14		EtherStatsBroadcastPkts
	15		EtherStatsDropEvents
	16		Dot3StatsFCSErrors
	17		Dot3StatsSymbolErrors
	18		Dot3InPauseFrames
	19		Dot3ControlInUnknownOpcodes
	20		IfOutOctets
	21		Dot3StatsSingleCollisionFrames
	22		Dot3StatMultipleCollisionFrames
	23		Dot3sDeferredTransmissions
	24		Dot3StatsLateCollisions
	25		EtherStatsCollisions
	26		Dot3StatsExcessiveCollisions
	27		Dot3OutPauseFrames
	28		Dot1dBasePortDelayExceededDiscards
	29		Dot1dTpPortInDiscards
	30		IfOutUcastPkts
	31		IfOutMulticastPkts
	32		IfOutBroadcastPkts
	33		Dot1dTpLearnEntryDiscardFlag	
*/
uint32_t rtl8366s_getMIBCounter(enum PORTID port,enum RTL8366S_MIBCOUNTER mibIdx,uint64_t* counter)
{
	if(SUCCESS != rtl8366s_getAsicMIBsCounter(port,mibIdx,counter))	{	
		DEBUG_MSG("rtl8366s_getAsicMIBsCounter fail\n");
		return FAILED;
	}	
	DEBUG_MSG("port%x:mibIdx=%x counter=%x\n",port,mibIdx,*counter);
	return SUCCESS;
}
#endif//MIB_COUNTER//*********************************************

#ifdef LED_SET//*********************************************
/*
@func uint32_t | rtl8366s_setAsicLedIndicateInfoConfig | Set Leds indicated information mode
@parm uint32_t | ledNo | LED group number. There are 1 to 1 led mapping to each port in each led group. 
@parm enum RTL8366S_LEDCONF | config | Support 16 types configuration.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@comm
	The API can set LED indicated information configuration for each LED group with 1 to 1 led mapping to each port.
	Definition		LED Statuses			Description
	0000		LED_Off				LED pin Tri-State.
	0001		Dup/Col				Collision, Full duplex Indicator. Blinking every 43ms when collision happens. Low for full duplex, and high for half duplex mode.
	0010		Link/Act				Link, Activity Indicator. Low for link established. Link/Act Blinks every 43ms when the corresponding port is transmitting or receiving.
	0011		Spd1000				1000Mb/s Speed Indicator. Low for 1000Mb/s.
	0100		Spd100				100Mb/s Speed Indicator. Low for 100Mb/s.
	0101		Spd10				10Mb/s Speed Indicator. Low for 10Mb/s.
	0110		Spd1000/Act			1000Mb/s Speed/Activity Indicator. Low for 1000Mb/s. Blinks every 43ms when the corresponding port is transmitting or receiving.
	0111		Spd100/Act			100Mb/s Speed/Activity Indicator. Low for 100Mb/s. Blinks every 43ms when the corresponding port is transmitting or receiving.
	1000		Spd10/Act			10Mb/s Speed/Activity Indicator. Low for 10Mb/s. Blinks every 43ms when the corresponding port is transmitting or receiving.
	1001		Spd100 (10)/Act		10/100Mb/s Speed/Activity Indicator. Low for 10/100Mb/s. Blinks every 43ms when the corresponding port is transmitting or receiving.
	1010		Fiber				Fiber link Indicator. Low for Fiber.
	1011		Fault	Auto-negotiation 	Fault Indicator. Low for Fault.
	1100		Link/Rx				Link, Activity Indicator. Low for link established. Link/Rx Blinks every 43ms when the corresponding port is transmitting.
	1101		Link/Tx				Link, Activity Indicator. Low for link established. Link/Tx Blinks every 43ms when the corresponding port is receiving.
	1110		Master				Link on Master Indicator. Low for link Master established.
	1111		LED_Force			Force LED output, LED output value reference 
 */
uint32_t rtl8366s_setAsicLedIndicateInfoConfig(uint32_t ledNo, enum RTL8366S_LEDCONF config)
{
	uint32_t retVal, regValue;

	if(ledNo >=RTL8366S_LED_GROUP_MAX){
		DEBUG_MSG("rtl8366s_setAsicLedIndicateInfoConfig: group fail\n");
		return FAILED;
	}	

	if(config > LEDCONF_LEDFORCE){	
		DEBUG_MSG("rtl8366s_setAsicLedIndicateInfoConfig: config fail\n");
		return FAILED;
	}	


	/* Get register value */
	retVal = rtl8366s_getAsicReg(RTL8366S_LED_INDICATED_CONF_REG, &regValue); 	
	if (retVal !=  SUCCESS){
		DEBUG_MSG("rtl8366s_setAsicLedIndicateInfoConfig: rtl8366s_getAsicReg fail\n");
		return retVal;
	}	

	regValue =  (regValue & (~(0xF<<(ledNo*4)))) | (config<<(ledNo*4));

	
	retVal = rtl8366s_setAsicReg(RTL8366S_LED_INDICATED_CONF_REG, regValue); 	

	return retVal;
}

/*
@func uint32_t | rtl8366s_getAsicLedIndicateInfoConfig | Get Leds indicated information mode
@parm uint32_t | ledNo | LED group number. There are 1 to 1 led mapping to each port in each led group. 
@parm enum RTL8366S_LEDCONF* | config | Support 16 types configuration.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@comm
	The API can get LED indicated information configuration for each LED group.
 */
uint32_t rtl8366s_getAsicLedIndicateInfoConfig(uint32_t ledNo, enum RTL8366S_LEDCONF* config)
{
	uint32_t retVal, regValue;

	if(ledNo >=RTL8366S_LED_GROUP_MAX){
		DEBUG_MSG("rtl8366s_getAsicLedIndicateInfoConfig: group fail\n");
		return FAILED;
	}	

	/* Get register value */
	retVal = rtl8366s_getAsicReg(RTL8366S_LED_INDICATED_CONF_REG, &regValue); 	
	if (retVal !=  SUCCESS) {
		DEBUG_MSG("rtl8366s_getAsicLedIndicateInfoConfig: rtl8366s_getAsicReg fail\n"); 
		return retVal;
	}
	
	*config = (regValue >> (ledNo*4)) & 0x000F;
		
	return SUCCESS;
}

/*
@func uint32_t | rtl8366s_setAsicForceLeds | Turn on/off Led of dedicated port
@parm uint32_t | ledG0Msk | Turn on or turn off Leds of group 0, 1:on 0:off.
@parm uint32_t | ledG1Msk | Turn on or turn off Leds of group 1, 1:on 0:off.
@parm uint32_t | ledG2Msk | Turn on or turn off Leds of group 2, 1:on 0:off.
@parm uint32_t | ledG3Msk | Turn on or turn off Leds of group 3, 1:on 0:off.
@rvalue SUCCESS | Success.
@rvalue ERRNO_SMIERROR | SMI access error.
@comm
	The API can turn on/off desired Led group of dedicated port while indicated information configuration of LED group is set to force mode.
 */
uint32_t rtl8366s_setAsicForceLeds(uint32_t ledG0Msk, uint32_t ledG1Msk, uint32_t ledG2Msk, uint32_t ledG3Msk)
{
	uint32_t retVal, regValue;

	regValue = (ledG0Msk & 0x3F) | (ledG1Msk&0x3F) << 6;

	retVal = rtl8366s_setAsicReg(RTL8366S_LED_0_1_FORCE_REG, regValue); 	
	if(retVal != SUCCESS){
		DEBUG_MSG("rtl8366s_setAsicForceLeds: rtl8366s_setAsicReg fail\n"); 
		return retVal;
	}	

	regValue = (ledG2Msk & 0x3F) | (ledG3Msk&0x3F) << 6;
	retVal = rtl8366s_setAsicReg(RTL8366S_LED_2_3_FORCE_REG, regValue); 	
	
	return retVal;
}
#endif//LED_SET//*********************************************

/*
@func uint32_t | rtl8366s_initChip | Set chip to default configuration enviroment
@rvalue SUCCESS | Success.
@rvalue FAILED | Failure.
@comm
	The API can set chip registers to default configuration for different release chip model.
*/
uint32_t rtl8366s_initChip(void)
{
	uint32_t index,phyUnit;
	uint32_t regData;
#ifdef LED_SET
	uint32_t ledGroup;
	enum RTL8366S_LEDCONF ledCfg[RTL8366S_LED_GROUP_MAX];
#endif	

	DEBUG_MSG("rtl8366s_initChip\n");
	
	const uint32_t chipB[][2] = {{0x0000,	0x0038},{0x8100,	0x1B37},{0xBE2E,	0x7B9F},{0xBE2B,	0xA4C8},
							{0xBE74,	0xAD14},{0xBE2C,	0xDC00},{0xBE69,	0xD20F},{0xBE3B,	0xB414},
							{0xBE24,	0x0000},{0xBE23,	0x00A1},{0xBE22,	0x0008},{0xBE21,	0x0120},
							{0xBE20,	0x1000},{0xBE24,	0x0800},{0xBE24,	0x0000},{0xBE24,	0xF000},
							{0xBE23,	0xDF01},{0xBE22,	0xDF20},{0xBE21,	0x101A},{0xBE20,	0xA0FF},
							{0xBE24,	0xF800},{0xBE24,	0xF000},{0x0242,	0x02BF},{0x0245,	0x02BF},
							{0x0248,	0x02BF},{0x024B,	0x02BF},{0x024E,	0x02BF},{0x0251,	0x02BF},
							{0x0230,	0x0A32},{0x0233,	0x0A32},{0x0236,	0x0A32},{0x0239,	0x0A32},
							{0x023C,	0x0A32},{0x023F,	0x0A32},{0x0254,	0x0A3F},{0x0255,	0x0064},
							{0x0256,	0x0A3F},{0x0257,	0x0064},{0x0258,	0x0A3F},{0x0259,	0x0064},
							{0x025A,	0x0A3F},{0x025B,	0x0064},{0x025C,	0x0A3F},{0x025D,	0x0064},
							{0x025E,	0x0A3F},{0x025F,	0x0064},{0x0260,	0x0178},{0x0261,	0x01F4},
							{0x0262,	0x0320},{0x0263,	0x0014},{0x021D,	0x9249},{0x021E,	0x0000},
							{0x0100,	0x0004},{0xBE4A,	0xA0B4},{0xBE40,	0x9C00},{0xBE41,	0x501D},
							{0xBE48,	0x3602},{0xBE47,	0x8051},{0xBE4C,	0x6465},{0x8000,	0x1F00},
							{0x8001,	0x000C},{0x8008,	0x0000},{0x8007,	0x0000},{0x800C,	0x00A5},
							{0x8101,	0x02BC},{0xBE53,	0x0005},{0x8E45,	0xAFE8},{0x8013,	0x0005},
							{0xBE4B,	0x6700},{0x800B,	0x7000},{0xBE09,	0x0E00},
							{0xFFFF, 0xABCD}};
	/* Sample code start (fix to port 2-4 link issue from Realtek) */		
	const uint32_t chipDefault[][2] = {{0x0242, 0x02BF},{0x0245, 0x02BF},{0x0248, 0x02BF},{0x024B, 0x02BF},
								{0x024E, 0x02BF},{0x0251, 0x02BF},
								{0x0254, 0x0A3F},{0x0256, 0x0A3F},{0x0258, 0x0A3F},{0x025A, 0x0A3F},
								{0x025C, 0x0A3F},{0x025E, 0x0A3F},
								{0x0263, 0x007C},{0x0100,	0x0004},									
								{0xBE5B, 0x3500},{0x800E, 0x200F},{0xBE1D, 0x0F00},{0x8001, 0x5011},
								{0x800A, 0xA2F4},{0x800B, 0x17A3},{0xBE4B, 0x17A3},{0xBE41, 0x5011},
								{0xBE17, 0x2100},{0x8000, 0x8304},{0xBE40, 0x8304},{0xBE4A, 0xA2F4},
								{0x800C, 0xA8D5},{0x8014, 0x5500},{0x8015, 0x0004},{0xBE4C, 0xA8D5},
								{0xBE59, 0x0008},{0xBE09, 0x0E00},{0xBE36, 0x1036},{0xBE37, 0x1036},
								{0x800D, 0x00FF},{0xBE4D, 0x00FF},
								{0xFFFF, 0xABCD}};	

#ifdef LED_SET
	for(ledGroup= 0;ledGroup<RTL8366S_LED_GROUP_MAX;ledGroup++)
	{
		if(SUCCESS != rtl8366s_getAsicLedIndicateInfoConfig(ledGroup,&ledCfg[ledGroup])){
			DEBUG_MSG("rtl8366s_getAsicLedIndicateInfoConfig fail\n");
			return FAILED;
		}	

		if(SUCCESS != rtl8366s_setAsicLedIndicateInfoConfig(ledGroup,LEDCONF_LEDFORCE)){
			DEBUG_MSG("rtl8366s_setAsicLedIndicateInfoConfig fail\n");
			return FAILED;
		}	
	}

	if(SUCCESS != rtl8366s_setAsicForceLeds(0x3F,0x3F,0x3F,0x3F)){
		DEBUG_MSG("rtl8366s_setAsicForceLeds fail\n"); 
		return FAILED;
	}	
#endif
	/*resivion*/
	if(SUCCESS != rtl8366s_getAsicReg(0x5C,&regData)){
		DEBUG_MSG("rtl8366s_getAsicReg fail\n"); 
		return FAILED;
	}	

	index = 0;
	switch(regData)
	{
 	 case 0x0000:	
		DEBUG_MSG("0x0000\n");
		while(chipB[index][0] != 0xFFFF && chipB[index][1] != 0xABCD)
		{	
			/*PHY registers setting*/	
			if(0xBE00 == (chipB[index][0] & 0xBE00))
			{
				if(SUCCESS != rtl8366s_setAsicReg(RTL8366S_PHY_ACCESS_CTRL_REG, RTL8366S_PHY_CTRL_WRITE)){
					DEBUG_MSG("rtl8366s_setAsicReg fail\n");
					return FAILED;
				}	
			}

			if(SUCCESS != rtl8366s_setAsicReg(chipB[index][0],chipB[index][1])){
				DEBUG_MSG("rtl8366s_setAsicReg2 fail\n");
				return FAILED;
			}	
			
			index ++;	
		}			
		break;
 	 case 0x6027:	
 	 	DEBUG_MSG("0x6027\n");
		while(chipDefault[index][0] != 0xFFFF && chipDefault[index][1] != 0xABCD)
		{	
			/*PHY registers setting*/	
			if(0xBE00 == (chipDefault[index][0] & 0xBE00))
			{
				if(SUCCESS != rtl8366s_setAsicReg(RTL8366S_PHY_ACCESS_CTRL_REG, RTL8366S_PHY_CTRL_WRITE)){
					DEBUG_MSG("rtl8366s_setAsicReg fail\n");
					return FAILED;
				}	

			}

			if(SUCCESS != rtl8366s_setAsicReg(chipDefault[index][0],chipDefault[index][1])){
				DEBUG_MSG("rtl8366s_setAsicReg2 fail\n");
				return FAILED;
			}	
			
			index ++;	
		}			
		break;
	 default:
	 	DEBUG_MSG("unknow\n");
		return FAILED;
		break;
	}
	
#if 0
	/* Setup all PHY */	
    for (phyUnit=0; phyUnit < 4; phyUnit++) {   
    	rtl8366s_setAsicPHYRegs(phyUnit,0, MII_CONTROL_REG, (1<<MII_CONTROL_RESET)|(1<<MII_CONTROL_AUTONEG)|(1<<MII_CONTROL_FULLDUPLEX));
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_CONTROL_REG,&regData);       
        while (regData & (1<<MII_CONTROL_RESET)) {}
        rtl8366s_setAsicPHYRegs(phyUnit,0, MII_CONTROL_REG, (1<<MII_CONTROL_AUTONEG)|(1<<MII_CONTROL_RENEG)|(1<<MII_CONTROL_FULLDUPLEX));     
        DEBUG_MSG("\nSW port[%d] init state:", phyUnit);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_CONTROL_REG,&regData);
        DEBUG_MSG("\nBasic Control: REG[0] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_STATUS_REG,&regData);
        DEBUG_MSG("\nBasic Status:  REG[1] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID0,&regData);
        DEBUG_MSG("\nPHY ID  :      REG[2] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID1,&regData);
        DEBUG_MSG("\n               REG[3] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_LOCAL_CAP,&regData);
        DEBUG_MSG("\nAutoNeg Local: REG[4] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_REMOTE_CAP,&regData);
        DEBUG_MSG("\n       Remote: REG[5] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_CONTROL,&regData);
        DEBUG_MSG("\nGiga Control:  REG[9] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_STATUS,&regData);
        DEBUG_MSG("\n     Status:   REG[A] = 0x%hx",regData);   
    } 
	DEBUG_MSG("\n\n");	
#endif	
	sysMsDelay(1000);

#ifdef LED_SET
	for(ledGroup= 0;ledGroup<RTL8366S_LED_GROUP_MAX;ledGroup++)
	{
		if(SUCCESS != rtl8366s_setAsicLedIndicateInfoConfig(ledGroup,ledCfg[ledGroup])){
			DEBUG_MSG("rtl8366s_setAsicLedIndicateInfoConfig2 fail\n");
			return FAILED;
		}	
			
	}
#endif
	return SUCCESS;
}

/****************************************************************************/
/******************************************************************************
*
* rtl8366sr_phy_is_link_alive - test to see if the specified link is alive
*
* RETURNS:
*    TRUE  --> link is alive
*    FALSE --> link is down
*/

BOOL rtl8366sr_phy_is_link_alive(int phyUnit)
{
    uint32_t regData;
    
	//DEBUG_MSG("rtl8366sr_phy_is_link_alive %d\n",phyUnit);
	if (IDregData == RTL8366SR)
	rtl8366s_getPHYLinkStatus(phyUnit,&regData);
	else 	
		rtl8366rb_getPHYLinkStatus(phyUnit,&regData);
    	
    if(regData)
    	return TRUE;
    else
    	return FALSE;
    	
}

BOOL rtl8366_phy_is_up(int ethUnit)
{
    uint32_t regData;
    int phyUnit,phyStart,phyEnd;
    int liveLinks = 0; 
    
	DEBUG_MSG("rtl8366sr_phy_is_link_up %d\n",ethUnit);
#if 1
	if(ethUnit){//wan
    	phyStart = 4;
    	phyEnd = REALTEK_MAX_PORT_ID;
    }	
    else{//lan
    	phyStart = 0;
    	phyEnd = REALTEK_MAX_PORT_ID-1;	 
    }
    
	for (phyUnit=phyStart; phyUnit < phyEnd; phyUnit++) {
        if (rtl8366sr_phy_is_link_alive(phyUnit)) {
        	DEBUG_MSG("phyUnit=%x is link\n",phyUnit);
            liveLinks++;  
        }  
    }     
    return (liveLinks > 0);	
#else
	return TRUE;
#endif    	
}


/******************************************************************************
*
* rtl8366sr_phy_setup - reset and setup the PHY associated with
* the specified MAC unit number.
*
* Resets the associated PHY port.
*
* RETURNS:
*    TRUE  --> associated PHY is alive
*    FALSE --> no LINKs on this ethernet unit
*/
int init_first=0;


BOOL
rtl8366_phy_setup(int ethUnit)
{
    int phyUnit,phyStart,phyEnd;
    int liveLinks = 0;    
    uint32_t regData=0;
    enum PORTLINKSPEED speed=0;
    enum PORTLINKDUPLEXMODE duplex=0;
    uint32_t link=0,txPause=0,rxPause=0,autoNegotiation=0; 
    uint32_t RxdelayReg;
    
    printf("rtl8366_phy_setup  ethUnit=%x\n", ethUnit);    
    
    if(!init_first){
    smi_init();
	switch_reg_read(RTL8366S_CHIP_ID_REG,&IDregData);
	switch_reg_read(RTL8366S_CHIP_ID_REG,&IDregData);
	printf("Realtek 8366 switch ID 0x%x %s\n", IDregData, (IDregData==RTL8366RB)?"RB":"SR");//0x8366
    
		if (IDregData == RTL8366SR)
		{
	rtl8366s_initChip();    
	sysMsDelay(4000);    
#ifdef CPU_PORT	
	/* Set port 5 noTag and don't dropUnda */	
	rtl8366s_setCPUPort(PORT5, 1, 0);	
#ifdef GET_INFO
	rtl8366s_getCPUPort(&speed,&duplex,&link);
#endif		
#endif		
	/* Enable CPU port - forced speed, full duplex and flow control */
#ifdef CFG_SP1000
	DEBUG_MSG("SP1000\n");
	rtl8366s_setMac5ForceLink(SPD_1000M,FULL_DUPLEX,1,1,1);
#ifdef GET_INFO
	rtl8366s_getMac5ForceLink(&speed,&duplex,&link,&txPause,&rxPause);	
#endif	
#else //100
	DEBUG_MSG("SP100\n");
	rtl8366s_setMac5ForceLink(SPD_100M,FULL_DUPLEX,1,1,1);
#ifdef GET_INFO
	rtl8366s_getMac5ForceLink(&speed,&duplex,&link,&txPause,&rxPause);	
#endif	
#endif	
		}else
		{
		   rtl8366rb_initChip();
		     sysMsDelay(4000); 
//		     switch_reg_read(0x0d,&RxdelayReg);
//		     DEBUG_MSG("before Rxdelay reg = 0x%x\n", RxdelayReg);
//		     RxdelayReg = 0x200;//0x280;//0x240;//0x200;
//		     switch_reg_write(0x0d,RxdelayReg);
//		     switch_reg_read(0x0d,&RxdelayReg);
//		     
//		     DEBUG_MSG("After Rxdelay reg = 0x%x\n", RxdelayReg);
#ifdef CPU_PORT	
		/* Set port 5 noTag and don't dropUnda */	
		rtl8366rb_setCPUPort(PORT5, 1);	
//#ifdef GET_INFO
//		rtl8366_getMac5ForceLink(&speed,&duplex,&link,&txPause,&rxPause);	
//#endif			
#endif	
#ifdef CFG_SP1000 
		DEBUG_MSG("RTL8366RB SP1000\n"); 
		rtl8366_setMac5ForceLink(SPD_1000M,FULL_DUPLEX,1,1,1); 
#else
		DEBUG_MSG("RTL8366RB SP100\n");
		rtl8366_setMac5ForceLink(SPD_100M,FULL_DUPLEX,1,1,1);	
#endif			

		}
		
		init_first = 1;
	}
	
	if(ethUnit){//wan
    	phyStart = 4;
    	phyEnd = REALTEK_MAX_PORT_ID;
    }	
    else{//lan
    	phyStart = 0;
    	phyEnd = REALTEK_MAX_PORT_ID-1;	 
    }

	for (phyUnit=phyStart; phyUnit < phyEnd; phyUnit++) {
#if 0//def GET_INFO	
	if (IDregData == RTL8366SR){
        rtl8366s_getAsicPortLinkState(phyUnit,&speed,&duplex,&link,&txPause,&rxPause,&autoNegotiation);
        DEBUG_MSG("\nSW port[%d] init state:", phyUnit);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_CONTROL_REG,&regData);
        DEBUG_MSG("\nBasic Control: REG[0] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_STATUS_REG,&regData);
        DEBUG_MSG("\nBasic Status:  REG[1] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID0,&regData);
        DEBUG_MSG("\nPHY ID  :      REG[2] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID1,&regData);
        DEBUG_MSG("\n               REG[3] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_LOCAL_CAP,&regData);
        DEBUG_MSG("\nAutoNeg Local: REG[4] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_REMOTE_CAP,&regData);
        DEBUG_MSG("\n       Remote: REG[5] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_CONTROL,&regData);
        DEBUG_MSG("\nGiga Control:  REG[9] = 0x%hx",regData);
        rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_STATUS,&regData);
        DEBUG_MSG("\n     Status:   REG[A] = 0x%hx\n",regData);   
        }	
        else{
        	rtl8368s_getAsicPortLinkState(phyUnit,&speed,&duplex,&link,&txPause,&rxPause,&autoNegotiation);	                	
	        DEBUG_MSG("\nSW port[%d] init state:", phyUnit);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_CONTROL_REG,&regData);
	        DEBUG_MSG("\nBasic Control: REG[0] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_STATUS_REG,&regData);
	        DEBUG_MSG("\nBasic Status:  REG[1] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID0,&regData);
	        DEBUG_MSG("\nPHY ID  :      REG[2] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_PHY_ID1,&regData);
	        DEBUG_MSG("\n               REG[3] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_LOCAL_CAP,&regData);
	        DEBUG_MSG("\nAutoNeg Local: REG[4] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_REMOTE_CAP,&regData);
	        DEBUG_MSG("\n       Remote: REG[5] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_GIGA_CONTROL,&regData);
	        DEBUG_MSG("\nGiga Control:  REG[9] = 0x%hx",regData);
	        rtl8368s_getAsicPHYRegs(phyUnit,0,MII_GIGA_STATUS,&regData);
	        DEBUG_MSG("\n     Status:   REG[A] = 0x%hx\n",regData);            	
        }	
        	
   
#endif
        if (rtl8366sr_phy_is_link_alive(phyUnit)) {
        	DEBUG_MSG("phyUnit=%x is link\n",phyUnit);
            liveLinks++;  
        }  
    }  
#if 0//GET_INFO
    switch_reg_read(0x60,&regData);
    DEBUG_MSG("0x60=0x%x\n", regData);
    switch_reg_read(0x61,&regData);
    DEBUG_MSG("0x61=0x%x\n", regData);
    switch_reg_read(0x62,&regData);
    DEBUG_MSG("0x62=0x%x\n", regData);
	
	switch_reg_read(RTL8366S_CHIP_ID_REG,&regData);	
	DEBUG_MSG("Realtek 8366SR switch ID 0x%x\n", regData);//0x8366
#endif 	
    return (liveLinks > 0);
}


/******************************************************************************
*
* rtl8366sr_phy_is_fdx - Determines whether the phy ports associated with the
* specified device are FULL or HALF duplex.
*
* RETURNS:
*    1  --> FULL
*    0 --> HALF
*/
int
rtl8366_phy_is_fdx(int ethUnit)
{
    int	phyUnit,phyStart,phyEnd;  	
    
    DEBUG_MSG("rtl8366sr_phy_is_fdx %d\n",ethUnit);
#if 1  	
    if(ethUnit){//wan
    	phyStart = 4;
    	phyEnd = REALTEK_MAX_PORT_ID;
    	DEBUG_MSG("wan\n");
    }	
    else{//lan
    	phyStart = 0;
    	phyEnd = REALTEK_MAX_PORT_ID-1;	 
		DEBUG_MSG("lan\n");
		return TRUE;
    }	 	
#ifdef GET_INFO    	
    for (phyUnit=phyStart; phyUnit < phyEnd; phyUnit++) {       
        if (rtl8366sr_phy_is_link_alive(phyUnit)) {
        	DEBUG_MSG("phyUnit=%x is link\n",phyUnit);
			uint32_t link_status_giga;
			uint32_t local_cap,remote_cap,common_cap;
			
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_STATUS,&link_status_giga);
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_LOCAL_CAP,&local_cap);
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_REMOTE_CAP,&remote_cap);
        	common_cap = (local_cap & remote_cap);
        	
        	if (link_status_giga & (1 << MII_GIGA_STATUS_FULL)) {//
            	return TRUE;
            	//link_speed = 1000;
        	} else if (link_status_giga & (1 << MII_GIGA_STATUS_HALF)) {
            	return FALSE;
            	//link_speed = 1000;
        	} else {
            	if (common_cap & (1 << MII_CAP_100BASE_TX_FULL)) {
                	return TRUE;
                	//link_speed = 100;
            	} else if (common_cap & (1 << MII_CAP_100BASE_TX)) {
                	return FALSE;
                	//link_speed = 100;
            	} else if (common_cap & (1 << MII_CAP_10BASE_TX_FULL)) {
                	return TRUE;
                	//link_speed = 10;
           	 	} else  {
                	return FALSE;
                	//link_speed = 10;
           		}
        	}
           
        }
        else{
        	DEBUG_MSG("phyUnit=%x is no link\n",phyUnit);
        }	
    }
#endif    
    return FALSE;
#else
	return TRUE;
#endif    
}


/******************************************************************************
*
* rtl8366sr_phy_speed - Determines the speed of phy ports associated with the
* specified device.
*
* RETURNS:
*               AG7100_PHY_SPEED_10T, AG7100_PHY_SPEED_100TX;
*               AG7100_PHY_SPEED_1000T;
*/

int
rtl8366_phy_speed(int ethUnit)
{
   int	phyUnit,phyStart,phyEnd;
   
   DEBUG_MSG("rtl8366sr_phy_speed %d\n",ethUnit);
#if 1  	
  	if(ethUnit){//wan
    	phyStart = 4;
    	phyEnd = REALTEK_MAX_PORT_ID;
    	DEBUG_MSG("wan\n");
    }	
    else{//lan
    	phyStart = 0;
    	phyEnd = REALTEK_MAX_PORT_ID-1;	 
#ifdef CFG_SP1000
		DEBUG_MSG("lan SP1000\n");
		return _1000BASET;
#else
		DEBUG_MSG("lan SP100\n");
		return _100BASET;
#endif	    	 
    }	 	
    	 	
#ifdef GET_INFO   	
    for (phyUnit=phyStart; phyUnit < phyEnd; phyUnit++) {       
        if (rtl8366sr_phy_is_link_alive(phyUnit)) {
        	DEBUG_MSG("phyUnit=%x is link\n",phyUnit);
			uint32_t link_status_giga;
			uint32_t local_cap,remote_cap,common_cap;
			
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_GIGA_STATUS,&link_status_giga);
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_LOCAL_CAP,&local_cap);
			rtl8366s_getAsicPHYRegs(phyUnit,0,MII_REMOTE_CAP,&remote_cap);
        	common_cap = (local_cap & remote_cap);
        	
        	if (link_status_giga & (1 << MII_GIGA_STATUS_FULL)) {//
            	//full_duplex = TRUE;
            	return _1000BASET;
        	} else if (link_status_giga & (1 << MII_GIGA_STATUS_HALF)) {
            	//full_duplex = FALSE;
            	return _1000BASET;
        	} else {
            	if (common_cap & (1 << MII_CAP_100BASE_TX_FULL)) {
                	//full_duplex = TRUE;
                	return _100BASET;
            	} else if (common_cap & (1 << MII_CAP_100BASE_TX)) {
                	//full_duplex = FALSE;
                	return _100BASET;
            	} else if (common_cap & (1 << MII_CAP_10BASE_TX_FULL)) {
                	//full_duplex = TRUE;
                	return _10BASET;
           	 	} else  {
                	//full_duplex = FALSE;
                	return _10BASET;
           		}
        	}
           
        }
        else{
        	DEBUG_MSG("phyUnit=%x is no link\n",phyUnit);
        }	
    }    
#endif    
    return _10BASET;
#else
#ifdef CFG_SP1000
	return _1000BASET;
#else
	return _100BASET;
#endif	
#endif    
}
