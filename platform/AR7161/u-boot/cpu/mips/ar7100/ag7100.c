#include <config.h>
#include <common.h>
#include <malloc.h>
#include <net.h>
#include <command.h>
#include <asm/io.h>
#include <asm/addrspace.h>
#include <asm/types.h>
#include "ar7100_soc.h"
#include "ag7100.h"
#include "ag7100_phy.h"

#if (CONFIG_COMMANDS & CFG_CMD_MII)
#include <miiphy.h>
#endif

#define DEBUG_MSG 
//#define DEBUG_MSG printf

#define ag7100_name2mac(name)	   (strcmp(name,"eth0") ? ag7100_unit2mac(1) : ag7100_unit2mac(0))

#define _1000BASET      1000
#define _100BASET	100
#define _10BASET	10
#define HALF		22
#define FULL		44

int ag7100_miiphy_read(char *devname, unsigned char phaddr,
	       unsigned char reg, unsigned short *value);
int ag7100_miiphy_write(char *devname, unsigned char phaddr,
	        unsigned char reg, unsigned short data);

ag7100_mac_t *ag7100_macs[CFG_AG7100_NMACS];


ag7100_mac_t *ag7100_unit2mac(int unit)
{
    return (unit ? ag7100_macs[1] : ag7100_macs[0]);
}

unsigned char __local_enet_addr[];

//using #define MIB_COUNTER 1 in board\ar7100\common\rtl8366sr_phy.h
//extern uint32_t rtl8366s_getMIBCounter(enum PORTID port,enum RTL8366S_MIBCOUNTER mibIdx,uint64_t* counter);

uint64_t sendcot;
static int
ag7100_send(struct eth_device *dev, volatile void *packet, int length)
{
    int i;
    ag7100_mac_t *mac = (ag7100_mac_t *)dev->priv;

    ag7100_desc_t *f = mac->fifo_tx[mac->next_tx];
    DEBUG_MSG("ag7100_send\n");
    
#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    uint8_t *pkt_buf;

    pkt_buf = (uint8_t *) packet;
    if ((pkt_buf[1] & 0xf) != 0x5) {
#if 0//#ifdef DUMP_PKT
        printf("ag7100_send: spkt dump\n");
        for (i = 0; i < length; i++) {
            printf("pkt[%d] %x ", i, pkt_buf[i]);
            for (j = 7; j >= 0; j--)
				printf("%d", ((pkt_buf[i] >> j) & 1));
            printf("\n");
        }
#endif//#ifdef DUMP_PKT
        length = length + ATHRHDR_LEN;
        pkt_buf = (uint8_t *) packet - ATHRHDR_LEN;
        pkt_buf[0] = 0x10;  /* broadcast = 0; from_cpu = 0; reserved = 1; port_num = 0 */
        pkt_buf[1] = 0x80;  /* reserved = 0b10; priority = 0; type = 0 (normal) */
    }
    f->pkt_size = length;
    f->pkt_start_addr = virt_to_phys(pkt_buf);
#else //defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
#if 0 //#ifdef DUMP_PKT 
	uint8_t *pkt_buf;
    pkt_buf = (uint8_t *) packet;
    printf("ag7100_send: spkt dump: length=%d\n", length);
    for (i = 0; i < length; i++) 
    {
        if(i%16 == 0)
        	printf("\n"); 
        printf("%02x-",pkt_buf[i]);          
    }
    printf("\n");
#endif //#ifdef DUMP_PKT   
    f->pkt_size = length;
    f->pkt_start_addr = virt_to_phys(packet);
#endif //defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    ag7100_tx_give_to_dma(f);
//    flush_cache((u32) packet, length);
    flush_cache((u32) packet, PKTSIZE_ALIGN);    
    ag7100_reg_wr(mac, AG7100_DMA_TX_DESC, virt_to_phys(f));
    ag7100_reg_wr(mac, AG7100_DMA_TX_CTRL, AG7100_TXE);

    for (i = 0; i < MAX_WAIT; i++) {
        udelay(10);
        if (!ag7100_tx_owned_by_dma(f))
            break;
    }
    if (i == MAX_WAIT)
        printf("Tx Timed out\n");

    f->pkt_start_addr = 0;
    f->pkt_size = 0;

    if (++mac->next_tx >= NO_OF_TX_FIFOS)
        mac->next_tx = 0;
        
	//rtl8366s_getMIBCounter(5,0,sendcot); //IfInOctets
	//rtl8366s_getMIBCounter(5,20,sendcot);//IfOutOctets
	//rtl8366s_getMIBCounter(3,0,sendcot);
    //rtl8366s_getMIBCounter(3,20,sendcot);
    return (0);
}

#ifdef USING_HTTP_UID_BUF
unsigned char uip_buf[];
extern volatile unsigned short uip_len;
extern int httpd_flag;
#endif

static int ag7100_recv(struct eth_device *dev)
{
    int length,i;
    ag7100_desc_t *f;
    ag7100_mac_t *mac;
 	
 	//DEBUG_MSG("ag7100_recv\n");
 	
    mac = (ag7100_mac_t *)dev->priv;

    for (;;) {
        f = mac->fifo_rx[mac->next_rx];
        if (ag7100_rx_owned_by_dma(f))
            break;

        length = f->pkt_size;
#ifdef USING_HTTP_UID_BUF
	if (!httpd_flag)
#endif
	{
        NetReceive(NetRxPackets[mac->next_rx] , length - 4);
	}
#ifdef USING_HTTP_UID_BUF
	else {
#ifdef CFG_BOOTP_FW_UPGRADE
	if (!mac->mac_unit)
	{
#endif
      	if (length > 0 ){
	  		//printf("ag7100_recv: f->pkt_size = %d \n",length);
	  		if(length > 18 ){
	  			memcpy(uip_buf, NetRxPackets[mac->next_rx], length-4);
	  			uip_len = length - 4;
	  		}
	  		else{
	  			memcpy(uip_buf, NetRxPackets[mac->next_rx], length);
	  			uip_len = length;
	  		}	
#if 0 //NickChou
			printf("ag7100_recv: rec pkt dump: uip_len=%d\n", uip_len);
        	for (i = 0; i < uip_len; i++) 
        	{
        		if(i%16 == 0)
        			printf("\n");  
        		printf("%02x-",uip_buf[i]);          	
       		}	
       		printf("\n");

#endif       		
			} 
#ifdef CFG_BOOTP_FW_UPGRADE
		}else
		{
           NetReceive(NetRxPackets[mac->next_rx] , length - 4);
		}
#endif
	}
#endif //http-uid_buf

        flush_cache((u32) NetRxPackets[mac->next_rx] , PKTSIZE_ALIGN);

        ag7100_rx_give_to_dma(f);

        if (++mac->next_rx >= NO_OF_RX_FIFOS)
            mac->next_rx = 0;
    }

    if (!(ag7100_reg_rd(mac, AG7100_DMA_RX_CTRL))) {
        ag7100_reg_wr(mac, AG7100_DMA_RX_DESC, virt_to_phys(f));
        ag7100_reg_wr(mac, AG7100_DMA_RX_CTRL, 1);
    }
    
    //rtl8366s_getMIBCounter(5,0,sendcot);
    //rtl8366s_getMIBCounter(5,20,sendcot);
    //rtl8366s_getMIBCounter(3,0,sendcot);
    //rtl8366s_getMIBCounter(3,20,sendcot);

    return (0);
}
#ifndef AR9100
#define ag7100_pll_shift(_mac)      (((_mac)->mac_unit) ? 19: 17)
#define ag7100_pll_offset(_mac)     \
    (((_mac)->mac_unit) ? 0xb8000000+0x00050000+0x14/*AR7100_USB_PLL_GE1_OFFSET*/ : \
                          0xb8000000+0x00050000+0x10/*AR7100_USB_PLL_GE0_OFFSET*/)
static void
ag7100_set_pll(ag7100_mac_t *mac, unsigned int pll)
{
#define ETH_PLL_CONFIG 0xb8000000+0x00050000+0x4//AR7100_USB_PLL_CONFIG //AR7100_USB_PLL_CONFIG = AR7100_PLL_BASE+0x4
											//AR7100_PLL_BASE = AR7100_APB_BASE+0x00050000	
											//#define AR7100_APB_BASE = 0x18000000  /* 384M */ 			
    uint32_t shift, reg, val;

    shift = ag7100_pll_shift(mac);
    reg   = ag7100_pll_offset(mac);

    val  = ar7100_reg_rd(ETH_PLL_CONFIG);
    val &= ~(3 << shift);
    val |=  (2 << shift);
    ar7100_reg_wr(ETH_PLL_CONFIG, val);
    udelay(100);

    ar7100_reg_wr(reg, pll);

    val |=  (3 << shift);
    ar7100_reg_wr(ETH_PLL_CONFIG, val);
    udelay(100);

    val &= ~(3 << shift);
    ar7100_reg_wr(ETH_PLL_CONFIG, val);
    udelay(100);

}
#endif

static void ag7100_hw_start(ag7100_mac_t *mac)
{
    u32 mii_ctrl_val, isXGMII = CFG_GMII;

#ifdef CFG_MII0_RGMII
    DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_RGMII\n ");
    mii_ctrl_val = 0x12;
#else
#ifdef CFG_MII0_MII
    DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_MII\n");
    mii_ctrl_val = 0x11;
#else
#ifdef CFG_MII0_RMII
    DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_RMII\n");
    mii_ctrl_val = 0x13;
#endif //CFG_MII0_RMII
#endif //CFG_MII0_MII
#endif //CFG_MII0_RGMII

    DEBUG_MSG("ag7100_hw_start: isXGMII=%x\n",isXGMII);
    
    /* ethernet mac0 setting enable tx and rx */
    ag7100_reg_wr(mac, AG7100_MAC_CFG1, (AG7100_MAC_CFG1_RX_EN |
		    AG7100_MAC_CFG1_TX_EN));//AR7100_GE0_BASE 0x19000000
		    
    /* ethernet mac0 setting fdx, enable crc and length check */ 
    ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, (AG7100_MAC_CFG2_PAD_CRC_EN |
		         AG7100_MAC_CFG2_LEN_CHECK));//AR7100_GE0_BASE 0x19000000

    /* ethernet mac0 setting interface mode MII/RMII or RGMII/GMII */ 
    //ag7100_set_mac_if(mac, isXGMII); // norp_d,
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_0, 0x1f00);  

    /* just mii 0 setting type and speed */
    if(mac->mac_unit == 0) {
    	ar7100_reg_wr(AR7100_MII0_CTRL, mii_ctrl_val);
//Albert add    	
        ag7100_set_mac_if(mac, 0);
        ag7100_set_mac_speed(mac, 1);
    	ag7100_set_pll(mac, 0x13000a44);     	
//add end    	
    } else {
    ag7100_set_mac_if(mac, 1); // norp_a,
    ag7100_set_pll(mac, 0x11110000); //  norp_a,
//    	ar7100_reg_wr(AR7100_MII1_CTRL, mii_ctrl_val); //norp_d, cause httpd response late??
    } 
    

    //ag7100_reg_wr(mac, AG7100_MAC_CFG1, 0x005);
    ag7100_reg_wr(mac, AG7100_MAC_MII_MGMT_CFG, AG7100_MGMT_CFG_CLK_DIV_20);

    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_1, 0xfff0000); //norp_a
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_2, 0x1fff); //norp_a
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x000001ff | ((2048-1536)/4)<<16); //norp_a
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_4, 0xffff); // norp_a
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_5, 0x7ffef); //norp_a


    //ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_4, 0x3ffff); //norp_d
    //ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_4, 0xffff);//NickChou add
    
    //ag7100_reg_rmw_clear(mac, AG7100_MAC_FIFO_CFG_5, (1 << 19)); //norp_d,
    ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_5, (1<<19)); // norp_a,
#ifdef AR9100
	DEBUG_MSG("ag7100_hw_start: AR9100\n");	
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x780008);
#else
	DEBUG_MSG("ag7100_hw_start: not AR9100\n");	
    //ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x400fff); //norp_d
    //ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x8001ff);//NickChou
#endif
    //ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_1, 0xfff0000); //norp_d
    //ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_2, 0x1fff); //norp_d,
	DEBUG_MSG(": cfg1 %#x cfg2 %#x\n", ag7100_reg_rd(mac, AG7100_MAC_CFG1),
        ag7100_reg_rd(mac, AG7100_MAC_CFG2));

}

static void ag7100_set_mac_from_link(ag7100_mac_t *mac, int speed, int fdx)
{
    int is1000 = (speed == _1000BASET);
    int is100 = (speed == _100BASET);

	DEBUG_MSG("ag7100_set_mac_from_link:speed=%d, fdx=%d\n", speed, fdx);
    mac->speed = speed;
    mac->duplex = fdx;
/*
*   Date: 2010-03-05
*   Name: Bing Chou
*   Reason: added to support AR8021 phy.
*   Notice :
*/
#if defined(CFG_ATHRF1_PHY) 
        if (speed==1000)
        {
                ag7100_set_pll(mac, 0x11110000);
                ar7100_reg_wr(AR7100_MII0_CTRL, 0x22);
        }
        else if (speed==100)
        {
                ag7100_set_pll(mac, 0x0001099);
                ar7100_reg_wr(AR7100_MII0_CTRL, 0x12);
        }
        else
        {
                ag7100_set_pll(mac, 0x00991099);
                ar7100_reg_wr(AR7100_MII0_CTRL, 0x02);
        }
#endif //defined(CFG_ATHRF1_PHY) 

    ag7100_set_mii_ctrl_speed(mac, speed);
    ag7100_set_mac_if(mac, is1000);
    ag7100_set_mac_duplex(mac, fdx);

    if (!is1000)
        ag7100_set_mac_speed(mac, is100);

#ifndef AR9100        
#ifdef CFG_MII0_RGMII //ken add
#ifndef CFG_ATHRF1_PHY
#ifdef CFG_SP1000 //Configure to GIGA switch
	if (mac->mac_unit)
	{
		if (is1000)
		*(volatile int *) 0xb8070004=0x20;	   	
		else
		*(volatile int *) 0xb8070004=0x10;   	
	}
	else
	    *(volatile int *) 0xb8070000=0x22;
#else	//#ifdef CFG_SP1000
	if (mac->mac_unit)
		*(volatile int *) 0xb8070004=0x10;		
	else
		*(volatile int *) 0xb8070000=0x12;

#endif
#endif	
#endif	        
#endif

    /*
     * XXX program PLL
     */
    mac->link = 1;
#ifdef AR9100
	DEBUG_MSG("ag7100_set_mac_from_link: eth0 clk pll=%x\n",*(volatile int *) 0xb8050014);	
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 mii=%x\n",*(volatile int *) 0xb8070000);	
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 cfg1=%x\n",*(volatile int *) 0xb9000000);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 cfg2=%x\n",*(volatile int *) 0xb9000004);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_0=%x\n", *(volatile int *) 0xb9050048);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_1=%x\n", *(volatile int *) 0xb905004c);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_2=%x\n", *(volatile int *) 0xb9050050);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_3=%x\n", *(volatile int *) 0xb9050054);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_4=%x\n", *(volatile int *) 0xb9050058);
    DEBUG_MSG("ag7100_set_mac_from_link: eth0 fcfg_5=%x\n", *(volatile int *) 0xb905005c);
#else   
    DEBUG_MSG("ag7100_set_mac_from_link: %s clk pll=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xb8050014:*(volatile int *) 0xb8050010);
    DEBUG_MSG("ag7100_set_mac_from_link: secondary PhaseLockLoop=%x\n",*(volatile int *) 0xb8050004);		
    DEBUG_MSG("ag7100_set_mac_from_link: %s mii=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xb8070004:*(volatile int *) 0xb8070000);	
    DEBUG_MSG("ag7100_set_mac_from_link: %s cfg1=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba000000:*(volatile int *) 0xb9000000);
    DEBUG_MSG("ag7100_set_mac_from_link: %s cfg2=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba000004:*(volatile int *) 0xb9000004);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_0=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba050048: *(volatile int *) 0xb9050048);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_1=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba05004c: *(volatile int *) 0xb905004c);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_2=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba050050: *(volatile int *) 0xb9050050);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_3=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba050054: *(volatile int *) 0xb9050054);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_4=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba050058: *(volatile int *) 0xb9050058);
    DEBUG_MSG("ag7100_set_mac_from_link: %s fcfg_5=%x\n",mac->dev->name, mac->mac_unit?*(volatile int *)0xba05005c: *(volatile int *) 0xb905005c);

#endif    
}

static int ag7100_check_link(ag7100_mac_t *mac)
{
    u32 link, duplex, speed, fdx, i;
    //printf("ag7100_check_link:\n");
#ifdef AR9100

#if !defined(CFG_ATHRS26_PHY) && !defined(CFG_ATHRHDR_EN)
    ag7100_phy_link(mac->mac_unit, link, duplex, speed);
    ag7100_phy_duplex(mac->mac_unit,duplex);
    ag7100_phy_speed(mac->mac_unit,speed);

    mac->link = link;
    if(!mac->link) {
        printf("%s link down\n",mac->dev->name);
        return 0;
    }
#else //#if !defined(CFG_ATHRS26_PHY) && !defined(CFG_ATHRHDR_EN)
#ifdef CFG_SP1000
    DEBUG_MSG("ag7100_check_link:CFG_SP1000\n");
    mac->link = 1;
    duplex = FULL;
    speed = _1000BASET;
#else     
     duplex = FULL;
     speed = _100BASET;
#endif //CFG_SP1000
#endif //#if !defined(CFG_ATHRS26_PHY) && !defined(CFG_ATHRHDR_EN)

      if (speed == _1000BASET) {
		DEBUG_MSG("ag7100_check_link: _1000BASET\n");
        uint32_t shift, reg, val;

        if(!mac->mac_unit){
            ar7100_reg_wr(AR7100_MII0_CTRL, 0x20);
		} else {
	    	ar7100_reg_wr(AR7100_MII1_CTRL, 0x22);
		}

        ag7100_reg_rmw_clear(mac, AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, 0x7215);
        ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x780fff);

#define ag7100_pll_shift(_mac)	(((_mac)->mac_unit) ? 22: 20)
#define ag7100_pll_offset(_mac)	(((_mac)->mac_unit) ? 0xb8050018 : 0xb8050014)
#define ETH_PLL_CONFIG		0xb8050004

		DEBUG_MSG("AR9100:\n");
		shift = ag7100_pll_shift(mac);
		reg = ag7100_pll_offset(mac);
	
		val  = ar7100_reg_rd(ETH_PLL_CONFIG);
		val &= ~(3 << shift);
		val |=  (2 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);
	
		if (mac->mac_unit) {
	        	*(volatile int *) 0xb8050018 = 0x1f000000;
		} else {
	        	*(volatile int *) 0xb8050014 = 0x1a000000;
		}

		val |=  (3 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);
	
		val &= ~(3 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);


        ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_5, (1 << 19));

        if(mac->mac_unit == 0) {
            miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1f, 0x1);
            miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1c, 0x3000);
            miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1f, 0x0);
       }
    } else if (speed == _100BASET) {
DEBUG_MSG("ag7100_check_link: _100BASET\n");
#define ag7100_pll_shift(_mac)	(((_mac)->mac_unit) ? 22: 20)
#define ag7100_pll_offset(_mac)	(((_mac)->mac_unit) ? 0xb8050018 : 0xb8050014)
#define ETH_PLL_CONFIG		0xb8050004
	uint32_t shift, reg, val;

		DEBUG_MSG("AR9100:\n");
		shift = ag7100_pll_shift(mac);
		reg = ag7100_pll_offset(mac);
	
		val  = ar7100_reg_rd(ETH_PLL_CONFIG);
		val &= ~(3 << shift);
		val |=  (2 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);
	
		if (mac->mac_unit) {
	        	*(volatile int *) 0xb8050018 = 0x1f000000;
		} else {
	        	*(volatile int *) 0xb8050014 = 0x13000a44;
		}

		val |=  (3 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);
	
		val &= ~(3 << shift);
		ar7100_reg_wr(ETH_PLL_CONFIG, val);
		udelay(100);

	//printf(": pll reg %#x: %#x  ", reg, ar7100_reg_rd(reg));

        ag7100_reg_rmw_clear(mac, AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, 0x7115);
    }

    if (mac->link && (duplex == mac->duplex) && (speed == mac->speed)){
    	DEBUG_MSG("same as dup %d speed %d\n", duplex, speed);
                    return 1;
    }    

    mac->duplex = duplex;
    mac->speed = speed;
    mac->link = 1;

    fdx = (duplex == FULL) ? 1 : 0;
    DEBUG_MSG("dup %d speed %d\n", fdx, speed);

    ag7100_set_mac_duplex(mac,fdx);

    if (speed == _100BASET)
        ag7100_set_mac_speed(mac, 1);
    else if (speed == _10BASET)
        ag7100_set_mac_speed(mac, 0);

    return 1;

#else //#ifdef AR9100
	DEBUG_MSG("ag7100_chekc_link: no define AR9100\n");
#ifdef CFG_MII0_RGMII //ken add
#ifdef CFG_SP1000 //Configure to GIGA switch
#ifdef CFG_BOOTP_FW_UPGRADE
    if (mac->mac_unit) {
			int regData;
        	rtl8366s_getAsicPHYRegs(4,0,MII_GIGA_STATUS,&regData);
			if (regData & 0x0c00)
			{
				ag7100_set_pll(mac, 0x11110000);	
	
				speed = _1000BASET;
				if (regData & 0x0800)
           			duplex = 1;
				else
					duplex = 0;

    			ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x000001ff | ((2048-1536)/4)<<16);
			}
			else
			{
				*(volatile int *) 0xb8050014 = 0x00441011;
 		        speed = _100BASET; 
				duplex = 1;
    			ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x0); 
			}
    }
	else
#endif //CFG_BOOTP_FW_UPGRADE
	{
		ag7100_set_pll(mac, 0x11110000);	
		speed = _1000BASET;
		duplex = 1;
		//ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x000001ff | ((2048-1536)/4)<<16);
    	ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x0); 
	}
#else	//#ifdef CFG_SP1000
	if (mac->mac_unit) {
		*(volatile int *) 0xb8070004=0x10;		
		*(volatile int *) 0xb8050014 = 0x00441011;
	} else {
		*(volatile int *) 0xb8070000=0x12;
		*(volatile int *) 0xb8050010 = 0x00441011;		
	}
	speed = _100BASET;
	duplex = 1;
#endif	//#ifdef CFG_SP1000
#endif	//#ifdef CFG_MII0_RGMII
	
    ag7100_set_mac_from_link(mac, speed, duplex); 
    return 1;
    
#endif //#ifdef AR9100

}

/*
 * For every command we re-setup the ring and start with clean h/w rx state
 */
static int ag7100_clean_rx(struct eth_device *dev, bd_t * bd)
{

    int i;
    ag7100_desc_t *fr;
    ag7100_mac_t *mac = (ag7100_mac_t*)dev->priv;

	DEBUG_MSG("ag7100_clean_rx\n");
    if (!ag7100_check_link(mac))
        return 0;

    mac->next_rx = 0;
    for (i = 0; i < NO_OF_RX_FIFOS; i++) {
        fr = mac->fifo_rx[i];
        fr->pkt_start_addr = virt_to_phys(NetRxPackets[i]);
        flush_cache((u32) NetRxPackets[i], PKTSIZE_ALIGN);
        ag7100_rx_give_to_dma(fr);
    }

    ag7100_reg_wr(mac, AG7100_DMA_RX_DESC, virt_to_phys(mac->fifo_rx[0]));
    ag7100_reg_wr(mac, AG7100_DMA_RX_CTRL, AG7100_RXE);	/* rx start */
    udelay(1000 * 1000);


    return 1;

}

static int ag7100_alloc_fifo(int ndesc, ag7100_desc_t ** fifo)
{
    int i;
    u32 size;
    uchar *p = NULL;

    size = sizeof(ag7100_desc_t) * ndesc;
    size += CFG_CACHELINE_SIZE - 1;

    if ((p = malloc(size)) == NULL) {
        printf("Cant allocate fifos\n");
        return -1;
    }

    p = (uchar *) (((u32) p + CFG_CACHELINE_SIZE - 1) &
	   ~(CFG_CACHELINE_SIZE - 1));
    p = UNCACHED_SDRAM(p);

    for (i = 0; i < ndesc; i++)
        fifo[i] = (ag7100_desc_t *) p + i;

    return 0;
}

static int ag7100_setup_fifos(ag7100_mac_t *mac)
{
    int i;

    if (ag7100_alloc_fifo(NO_OF_TX_FIFOS, mac->fifo_tx))
        return 1;

    for (i = 0; i < NO_OF_TX_FIFOS; i++) {
        mac->fifo_tx[i]->next_desc = (i == NO_OF_TX_FIFOS - 1) ?
            virt_to_phys(mac->fifo_tx[0]) : virt_to_phys(mac->fifo_tx[i + 1]);
        ag7100_tx_own(mac->fifo_tx[i]);
    }

    if (ag7100_alloc_fifo(NO_OF_RX_FIFOS, mac->fifo_rx))
        return 1;

    for (i = 0; i < NO_OF_RX_FIFOS; i++) {
        mac->fifo_rx[i]->next_desc = (i == NO_OF_RX_FIFOS - 1) ?
            virt_to_phys(mac->fifo_rx[0]) : virt_to_phys(mac->fifo_rx[i + 1]);
    }

    return (1);
}

static void ag7100_halt(struct eth_device *dev)
{
    ag7100_mac_t *mac = (ag7100_mac_t *)dev->priv;
    ag7100_reg_wr(mac, AG7100_DMA_RX_CTRL, 0);
    while (ag7100_reg_rd(mac, AG7100_DMA_RX_CTRL));
}

char trans2Hex(int c)
{
    char val;
    switch(c)
    {
    	case 10:
    		val = 0xa;
    	break;
    	case 11:
    		val = 0xb;
    	break;
    	case 12:
    		val = 0xc;
    	break;
    	case 13:
    		val = 0xd;
    	break;
    	case 14:
    		val = 0xe;
    	break;
    	case 15:
    		val = 0xf;
    	break;    	    	    	
    } 		
    return val;	
}

static char *parse_nvram_mac(char *mac_addr, int iface)
{
    char *buf;
    char *p;
    int i,j;
    static char lan_mac_str[]="lan_mac=";
    static char tmp[2];
    char *art_lan_mac;
	char lan_mac[20]={0};
    
    DEBUG_MSG("parse_nvram_mac start\n");
#if 0 // get LAN MAC from nvram block
    buf = (unsigned char*)(0xbf040000); //NickChou modify from 0xbf020000 to 0xbf040000
    
    if(*buf == 0xffff)
    {
       printf("parse_nvram_mac:*buf == 0xffff: return\n");
       return NULL;
	}	
    for(i=0; i<8; i++)
    {    	
    	if((p = strchr(buf, lan_mac_str[i])) != NULL)
	    	buf = p + 1;  
    }
#else //get LAN MAC from ART block 
	/*
	Creating 5 MTD partitions on "ar7100-nor0":
	0x00000000-0x00040000 : "uboot"
	0x00040000-0x00050000 : "Config"
	0x00050000-0x00150000 : "vmlinux"
	0x00150000-0x00660000 : "rootfs"
	0x00660000-0x00670000 : "caldata"
	
	we save hwversion,  lanmac, wanmac and domain at "0xbf670000-100" address
	
	struct hw_lan_wan_t {
		char hwversion[4];
		char lanmac[20];
		char wanmac[20];
		char domain[4];
		};
	*/
	
	art_lan_mac = (unsigned char*)(0xbf670000-100+4);
					
	memcpy(lan_mac, art_lan_mac, 20);
	if(lan_mac[0]==0xffffffff && lan_mac[1]==0xffffffff)
	{
		printf("lan_mac=NULL\n");
		return NULL;
	}	
	
	buf = lan_mac;
#endif    

    for(i=0; i< 5; i++)
    {
    	if((p = strchr(buf, ':')) == NULL)
    	  return NULL;

    	for(j = 0; j< 2; j++)  
    	{
		if(48 <= *(buf+j) && *(buf+j) <= 57)
		   tmp[j] = *(buf+j) - 48;		
		else if(65 <= *(buf+j) && *(buf+j) <= 70)
		   tmp[j] = trans2Hex(*(buf+j) - 55);
		else if(97 <= *(buf+j) && *(buf+j) <= 102)
		   tmp[j] = trans2Hex(*(buf+j) - 87);     
    	} 
    	mac_addr[i] = tmp[0]<<4 | tmp[1] ;
    	buf = p + 1;

    }	
    	
    for(j = 0; j< 2; j++)  
    {
	if(48 <= *(buf+j) && *(buf+j) <= 57)
	   tmp[j] = *(buf+j) - 48;		
	else if(65 <= *(buf+j) && *(buf+j) <= 70)
	   tmp[j] = trans2Hex(*(buf+j) - 55);
	else if(97 <= *(buf+j) && *(buf+j) <= 102)
	   tmp[j] = trans2Hex(*(buf+j) - 87);     
    } 
    
    mac_addr[5] = tmp[0]<<4 | tmp[1] ;
    
    DEBUG_MSG("parse_nvram_mac finished\n");

    return (char *)mac_addr;
}


unsigned char *
ag7100_mac_addr_loc(void)
{
	extern flash_info_t flash_info[];

#ifdef BOARDCAL
    /*
    ** BOARDCAL environmental variable has the address of the cal sector
    */
    
    return ((unsigned char *)BOARDCAL);
    
#else
	/* MAC address is store in the 2nd 4k of last sector */
	return ((unsigned char *)
		(KSEG1ADDR(AR7100_SPI_BASE) + (4 * 1024) +
		flash_info[0].size - (64 * 1024) /* sector_size */ ));
#endif

}

static void ag7100_get_ethaddr(struct eth_device *dev)
{
#if 0
    extern flash_info_t flash_info[];
    unsigned char *eeprom;
    unsigned char *mac = dev->enetaddr;

    eeprom = ag7100_mac_addr_loc();

    if (strcmp(dev->name, "eth0") == 0) {
        memcpy(mac, eeprom, 6);
    } else if (strcmp(dev->name, "eth1") == 0) {
        eeprom += 6;
        memcpy(mac, eeprom, 6);
    } else {
        printf("%s: unknown ethernet device %s\n", __func__, dev->name);
        return;
    }

    /* Use fixed address if the above address is invalid */
    if (mac[0] == 0xff && mac[5] == 0xff) {
        mac[0] = 0x00;
        mac[1] = 0x03;
        mac[2] = 0x7f;
        mac[3] = 0x09;
        mac[4] = 0x0b;
        mac[5] = 0xad;
        printf("No valid address in Flash. Using fixed address\n");
    } else {
        printf("Fetching MAC Address from 0x%p\n", __func__, eeprom);
    }
#else
    unsigned char *mac = dev->enetaddr; 
    if (strcmp(dev->name, "eth0") == 0) { 
    	parse_nvram_mac(mac, 0);
    	memcpy(__local_enet_addr, mac, 6);
    }else if (strcmp(dev->name, "eth1") == 0) {
    	parse_nvram_mac(mac, 1);
    }

#if 1 //NickChou    
    if (mac[0] == 0x00 && mac[5] == 0x00) {
        mac[0] = 0x00;
        mac[1] = 0x03;
        mac[2] = 0x7f;
        mac[3] = 0x09;
        mac[4] = 0x72;
        mac[5] = 0x10;
        printf("ar7100 : No valid address in Flash. Using fixed address\n");
        memcpy(__local_enet_addr, mac, 6);//NickChou add
    }
#endif //NickChou
#endif
}

#ifdef CONFIG_AR9100_MDIO_DEBUG
int
ag7100_dump_vsc_regs(ag7100_mac_t *mac)
{

	unsigned i;
	unsigned short v;
	char *fmt[] = {"\t", "\n"};

	printf("IEEE & Standard registers\n");
	for (i = 0; i < 0x20; i++) {
		v = 0;
		ag7100_miiphy_read(mac->dev->name, 0, i, &v);
		printf("0x%02x: 0x%04x%s", i, v, fmt[i & 1]);
	}

	printf("Extended registers\n");

	/* Enable extended register set access */
	ag7100_miiphy_write(mac->dev->name, 0, 0x1f,  0x1);
	for (i = 16; i <= 30; i++) {
		v = 0;
		ag7100_miiphy_read(mac->dev->name, 0, i, &v);
		printf("0x%02x: 0x%04x%s", i, v, fmt[i & 1]);
	}
	ag7100_miiphy_write(mac->dev->name, 0, 0x1f,  0x0);
	printf("\n");
}
#endif

int ag7100_enet_initialize(bd_t * bis)
{
    struct eth_device *dev[CFG_AG7100_NMACS];
    u32 mask, mac_h, mac_l;
    int i;
#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
    u32 pll_value;
#endif


#ifdef AR9100
   /* Workaround to bring the TX_EN to low */

     i = *(volatile int *) 0xb806001c ;
    *(volatile int *) 0xb806001c = (i | 0x3300);
    udelay(10 * 1000);
     i = *(volatile int *) 0xb806001c ;
    *(volatile int *) 0xb806001c = (i & 0xffffccff);
    udelay(10 * 1000);
    *(volatile int *) 0xb8070000 = 0x13;
    *(volatile int *) 0xb8070004 = 0x11;
    udelay(10 * 1000);
    /* ethernet 0/1 mac setting disable tx and rx then reset */
    *(volatile int *) 0xb9000000 = 0x0;
    *(volatile int *) 0xba000000 = 0x0;
     i = *(volatile int *) 0xb806001c ;
    *(volatile int *) 0xb806001c = (i | 0x3300);
    udelay(10 * 1000);
#endif

    for (i = 0;i < CFG_AG7100_NMACS;i++) {

    if ((dev[i] = (struct eth_device *) malloc(sizeof (struct eth_device))) == NULL) {
        puts("malloc failed\n");
        return 0;
    }
	
    if ((ag7100_macs[i] = (ag7100_mac_t *) malloc(sizeof (ag7100_mac_t))) == NULL) {
        puts("malloc failed\n");
        return 0;
    }

    memset(ag7100_macs[i], 0, sizeof(ag7100_macs[i]));
    memset(dev[i], 0, sizeof(dev[i]));

    sprintf(dev[i]->name, "eth%d", i);
    ag7100_get_ethaddr(dev[i]);
    
    ag7100_macs[i]->mac_unit = i;
    ag7100_macs[i]->mac_base = i ? AR7100_GE1_BASE : AR7100_GE0_BASE ;
    ag7100_macs[i]->dev = dev[i];

    dev[i]->iobase = 0;
    dev[i]->init = ag7100_clean_rx;
    dev[i]->halt = ag7100_halt;
    dev[i]->send = ag7100_send;
    dev[i]->recv = ag7100_recv;
    dev[i]->priv = (void *)ag7100_macs[i];	

    eth_register(dev[i]);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_ATHRHDR_EN\n");
    athrs26_reg_dev(dev[i]);
#endif

#if (CONFIG_COMMANDS & CFG_CMD_MII)
	DEBUG_MSG("CFG_CMD_MII\n");
    miiphy_register(dev[i]->name, ag7100_miiphy_read, ag7100_miiphy_write);
#endif
    /*
    ** This is the actual reset sequence
    */
        
    mask = i ?(AR7100_RESET_GE1_MAC | AR7100_RESET_GE1_PHY) :
              (AR7100_RESET_GE0_MAC | AR7100_RESET_GE0_PHY);

    ar7100_reg_rmw_set(AR7100_RESET, mask);
    udelay(1000 * 1000);

    ar7100_reg_rmw_clear(AR7100_RESET, mask);
    udelay(1000 * 1000);
    
    /* ethernet 0 mii and mac setting */
    ag7100_hw_start(ag7100_macs[i]);
    /* ethernet setting fifo desc */
    ag7100_setup_fifos(ag7100_macs[i]);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_SWITCH_FREQ\n");
    pll_value = ar7100_reg_rd(AR7100_CPU_PLL_CONFIG);
    mask = pll_value & ~(PLL_CONFIG_PLL_FB_MASK | PLL_CONFIG_REF_DIV_MASK);
    mask = mask | (0x64 << PLL_CONFIG_PLL_FB_SHIFT) |
        (0x5 << PLL_CONFIG_REF_DIV_SHIFT) | (1 << PLL_CONFIG_AHB_DIV_SHIFT);

    ar7100_reg_wr_nf(AR7100_CPU_PLL_CONFIG, mask);
    udelay(100 * 1000);
#endif

    ag7100_phy_setup(ag7100_macs[i]->mac_unit);
    udelay(100 * 1000);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_SWITCH_FREQ\n");
    ar7100_reg_wr_nf(AR7100_CPU_PLL_CONFIG, pll_value);
    udelay(100 * 1000);
#endif
    {
        int j;
        unsigned char *mac = dev[i]->enetaddr;
        
		for(j=0;j<6;j++) {
			if(mac[j]!=0){
				DEBUG_MSG("%d%02x",j, mac[j]);
				break;
			}		
		}		
		if(j==6){
			DEBUG_MSG("mac is null\n");
			mac[0] = 0x00;
			mac[1] = 0x01;
			mac[2] = 0x23;
			mac[3] = 0x45;
			mac[4] = 0x67;
			mac[5] = 0x89;
		if(i>0)
			mac[5] += 1;
		else	
			memcpy(__local_enet_addr, dev[i]->enetaddr, 6);
		}
		if (i>0)
		   mac[5] += 1;	
		   
        printf("ar7100.c: %s using default MAC: %02x:%02x:%02x:%02x:%02x:%02x\n", dev[i]->name,
               mac[0] & 0xff, mac[1] & 0xff, mac[2] & 0xff,
               mac[3] & 0xff, mac[4] & 0xff, mac[5] & 0xff);
    }
    
    mac_l = (dev[i]->enetaddr[4] << 8) | (dev[i]->enetaddr[5]);
    mac_h = (dev[i]->enetaddr[0] << 24) | (dev[i]->enetaddr[1] << 16) |
        (dev[i]->enetaddr[2] << 8) | (dev[i]->enetaddr[3] << 0);
	
	/* ethernet 0 mac addrs setting */
    ag7100_reg_wr(ag7100_macs[i], AG7100_GE_MAC_ADDR1, mac_l);
    ag7100_reg_wr(ag7100_macs[i], AG7100_GE_MAC_ADDR2, mac_h);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    /* if using header for register configuration, we have to     */
    /* configure s26 register after frame transmission is enabled */
    DEBUG_MSG("CFG_ATHRS26_PHY & CFG_ATHRHDR_EN2\n");
    	athrs26_reg_init();
#endif

    printf("%s up\n",dev[i]->name);
    }

#ifdef CONFIG_AR9100_MDIO_DEBUG
    ag7100_dump_vsc_regs(ag7100_macs[i]);
#endif

#ifdef AR9100
#ifdef CFG_MII0_RGMII	
#ifdef CFG_SP1000 
    /* set Pll */	
    udelay(100 * 1000);
    ag7100_check_link(ag7100_macs[0]);
#endif //CFG_SP1000 
#endif //CFG_MII0_RGMII
#else
#ifdef CFG_MII0_RGMII	
    /* set Pll */
	ag7100_check_link(ag7100_macs[0]);
	udelay(200 * 1000);
#ifdef CFG_BOOTP_FW_UPGRADE
	ag7100_check_link(ag7100_macs[1]);
    udelay(100 * 1000);
#endif
#endif //CFG_MII0_RGMII 
#endif

    DEBUG_MSG("ag7100_enet_initialize...\n");
    DEBUG_MSG("CFG_PLL_FREQ=%x\n", CFG_PLL_FREQ);
    DEBUG_MSG("CFG_HZ=%x\n", CFG_HZ); 
    DEBUG_MSG("cpu pll=%x\n",*(volatile int *) 0xb8050000);    
#ifdef AR9100	
	DEBUG_MSG("eth pll=%x\n",*(volatile int *) 0xb8050004);
    DEBUG_MSG("eth0 clk pll=%x\n",*(volatile int *) 0xb8050014);	
    DEBUG_MSG("eth0 mii=%x\n",*(volatile int *) 0xb8070000);	
    DEBUG_MSG("eth0 cfg1=%x\n",*(volatile int *) 0xb9000000);
    DEBUG_MSG("eth0 cfg2=%x\n",*(volatile int *) 0xb9000004);
    DEBUG_MSG("eth0 fcfg_0=%x\n", *(volatile int *) 0xb9050048);
    DEBUG_MSG("eth0 fcfg_1=%x\n", *(volatile int *) 0xb905004c);
    DEBUG_MSG("eth0 fcfg_2=%x\n", *(volatile int *) 0xb9050050);
    DEBUG_MSG("eth0 fcfg_3=%x\n", *(volatile int *) 0xb9050054);
    DEBUG_MSG("eth0 fcfg_4=%x\n", *(volatile int *) 0xb9050058);
    DEBUG_MSG("eth0 fcfg_5=%x\n", *(volatile int *) 0xb905005c);
    
    DEBUG_MSG("eth1 clk pll=%x\n",*(volatile int *) 0xb8050018); 	
    DEBUG_MSG("eth1 mii=%x\n",*(volatile int *) 0xb8070004);     
    DEBUG_MSG("eth1 cfg1=%x\n",*(volatile int *) 0xba000000);
    DEBUG_MSG("eth1 cfg2=%x\n",*(volatile int *) 0xba000004);    
    DEBUG_MSG("eth1 fcfg_0=%x\n", *(volatile int *) 0xba050048);
    DEBUG_MSG("eth1 fcfg_1=%x\n", *(volatile int *) 0xba05004c);
    DEBUG_MSG("eth1 fcfg_2=%x\n", *(volatile int *) 0xba050050);
    DEBUG_MSG("eth1 fcfg_3=%x\n", *(volatile int *) 0xba050054);
    DEBUG_MSG("eth1 fcfg_4=%x\n", *(volatile int *) 0xba050058);
    DEBUG_MSG("eth1 fcfg_5=%x\n", *(volatile int *) 0xba05005c);
#else
	DEBUG_MSG("eth pll=%x\n",*(volatile int *) 0xb8050004);
{
	int x;
	for (x=0;x<CFG_AG7100_NMACS;x++)
	{
	DEBUG_MSG("eth%d clk pll=%x\n",x, x?*(volatile int *)0xb8050014:*(volatile int *) 0xb8050010);
    DEBUG_MSG("eth%d mii=%x\n",x, x?*(volatile int *)0xb8070004:*(volatile int *) 0xb8070000);	
    DEBUG_MSG("eth%d cfg1=%x\n",x, x?*(volatile int *)0xba000000:*(volatile int *) 0xb9000000);
    DEBUG_MSG("eth%d cfg2=%x\n",x, x?*(volatile int *)0xba000004:*(volatile int *) 0xb9000004);
    DEBUG_MSG("eth%d fcfg_0=%x\n",x, x?*(volatile int *)0xba050048: *(volatile int *) 0xb9050048);
    DEBUG_MSG("eth%d fcfg_1=%x\n",x, x?*(volatile int *)0xba05004c: *(volatile int *) 0xb905004c);
    DEBUG_MSG("eth%d fcfg_2=%x\n",x, x?*(volatile int *)0xba050050: *(volatile int *) 0xb9050050);
    DEBUG_MSG("eth%d fcfg_3=%x\n",x, x?*(volatile int *)0xba050054: *(volatile int *) 0xb9050054);
    DEBUG_MSG("eth%d fcfg_4=%x\n",x, x?*(volatile int *)0xba050058: *(volatile int *) 0xb9050058);
    DEBUG_MSG("eth%d fcfg_5=%x\n",x, x?*(volatile int *)0xba05005c: *(volatile int *) 0xb905005c);
	}
}
#endif    	    
    DEBUG_MSG("ag7100_enet_initialize end\n");
    return 1;
}

#if (CONFIG_COMMANDS & CFG_CMD_MII)
int ag7100_miiphy_read(char *devname, unsigned char phaddr,
	       unsigned char reg, unsigned short *value)
{
    uint16_t addr = (phaddr << AG7100_ADDR_SHIFT) | reg;
    volatile int rddata;
    ag7100_mac_t *mac = ag7100_name2mac(devname);
    DEBUG_MSG("ag7100_miiphy_read\n");
    ag7100_reg_wr(mac, AG7100_MII_MGMT_CMD, 0x0);
    ag7100_reg_wr(mac, AG7100_MII_MGMT_ADDRESS, addr);
    ag7100_reg_wr(mac, AG7100_MII_MGMT_CMD, AG7100_MGMT_CMD_READ);

    rddata = ag7100_reg_rd(mac, AG7100_MII_MGMT_IND) & 0x1;
    while (rddata) {
        rddata = ag7100_reg_rd(mac, AG7100_MII_MGMT_IND) & 0x1;
    }

    *value = ag7100_reg_rd(mac, AG7100_MII_MGMT_STATUS);
    ag7100_reg_wr(mac, AG7100_MII_MGMT_CMD, 0x0);

    return 0;
}

int ag7100_miiphy_write(char *devname, unsigned char phaddr,
	        unsigned char reg, unsigned short data)
{
    uint16_t addr = (phaddr << AG7100_ADDR_SHIFT) | reg;
    volatile int rddata;
    ag7100_mac_t *mac = ag7100_name2mac(devname);
    DEBUG_MSG("ag7100_miiphy_write\n");
    ag7100_reg_wr(mac, AG7100_MII_MGMT_ADDRESS, addr);
    ag7100_reg_wr(mac, AG7100_MII_MGMT_CTRL, data);

    rddata = ag7100_reg_rd(mac, AG7100_MII_MGMT_IND) & 0x1;
    while (rddata) {
        rddata = ag7100_reg_rd(mac, AG7100_MII_MGMT_IND) & 0x1;
    }
    return 0;
}

#endif		/* CONFIG_COMMANDS & CFG_CMD_MII */
