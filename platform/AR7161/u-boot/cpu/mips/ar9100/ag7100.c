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
#ifdef USE_TWO_MII //two mii
#define ag7100_unit2mac(_unit)     ag7100_macs[(_unit)]
#define ag7100_name2mac(name)	   (strcmp(name,"eth0") ? ag7100_unit2mac(1) : ag7100_unit2mac(0))
#endif//#ifdef USE_TWO_MII

#define _1000BASET      1000
#define _100BASET		100
#define _10BASET		10
#define HALF			22
#define FULL			44

int ag7100_miiphy_read(char *devname, unsigned char phaddr,
	       unsigned char reg, unsigned short *value);
int ag7100_miiphy_write(char *devname, unsigned char phaddr,
	        unsigned char reg, unsigned short data);

#ifdef USE_TWO_MII//two mii
ag7100_mac_t *ag7100_macs[CFG_AG7100_NMACS];
#else//two mii
ag7100_mac_t mac;
#endif//#ifdef USE_TWO_MII
unsigned char __local_enet_addr[];

static int
ag7100_send(struct eth_device *dev, volatile void *packet, int length)
{
    int i, j;
#ifdef USE_TWO_MII//two mii
    ag7100_mac_t *mac = (ag7100_mac_t *)dev->priv;
    ag7100_desc_t *f = mac->fifo_tx[mac->next_tx];
	//DEBUG_MSG("ag7100_send\n");
#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    uint8_t *pkt_buf;
    pkt_buf = (uint8_t *) packet;
    if ((pkt_buf[1] & 0xf) != 0x5) {
#ifdef DUMP_PKT
        printf("spkt dump\n");
        for (i = 0; i < length; i++) {
            printf("pkt[%d] %x ", i, pkt_buf[i]);
            for (j = 7; j >= 0; j--)
				printf("%d", ((pkt_buf[i] >> j) & 1));
            printf("\n");
        }
#endif
        length = length + ATHRHDR_LEN;
        pkt_buf = (uint8_t *) packet - ATHRHDR_LEN;
        pkt_buf[0] = 0x10;  /* broadcast = 0; from_cpu = 0; reserved = 1; port_num = 0 */
        pkt_buf[1] = 0x80;  /* reserved = 0b10; priority = 0; type = 0 (normal) */
    }
    f->pkt_size = length;
    f->pkt_start_addr = virt_to_phys(pkt_buf);
#else  
#ifdef DUMP_PKT
	uint8_t *pkt_buf;
    pkt_buf = (uint8_t *) packet;
        printf("spkt dump\n");
        for (i = 0; i < length; i++) {
            printf("%x-",pkt_buf[i]);            
        }
        printf("\n");
#endif
    f->pkt_size = length;
    f->pkt_start_addr = virt_to_phys(packet);
#endif
    ag7100_tx_give_to_dma(f);
    flush_cache((u32) packet, length);
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
#else//two mii
    ag7100_desc_t *f = mac.fifo_tx[mac.next_tx];
	//DEBUG_MSG("ag7100_send\n");
#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    uint8_t *pkt_buf;
    pkt_buf = (uint8_t *) packet;
    if ((pkt_buf[1] & 0xf) == 0x5) {
        f->pkt_size = length;
#ifdef DUMP_PKT
        printf("spkt dump\n");
        for (i = 0; i < length; i++) {
            printf("pkt[%d] %x ", i, pkt_buf[i]);
            for (j = 7; j >= 0; j--)
				printf("%d", ((pkt_buf[i] >> j) & 1));
            printf("\n");
        }
#endif
    } else {
        f->pkt_size = length + ATHRHDR_LEN;
        pkt_buf = (uint8_t *) packet - ATHRHDR_LEN;
        pkt_buf[0] = 0x10;  /* broadcast = 0; from_cpu = 0; reserved = 1; port_num = 0 */
        pkt_buf[1] = 0x80;  /* reserved = 0b10; priority = 0; type = 0 (normal) */
    }
    f->pkt_start_addr = virt_to_phys(buf);
#else  
#ifdef DUMP_PKT
	uint8_t *pkt_buf;
    pkt_buf = (uint8_t *) packet;
        printf("sed pkt dump\n");
        for (i = 0; i < length; i++) {
            printf("%x-",pkt_buf[i]);            
        }
        printf("\n");
#endif
    f->pkt_size = length;
    f->pkt_start_addr = virt_to_phys(packet);
#endif//#ifdef USE_TWO_MII
    ag7100_tx_give_to_dma(f);
    flush_cache((u32) packet, PKTSIZE_ALIGN/*length*/);
    ag7100_reg_wr(AG7100_DMA_TX_DESC, virt_to_phys(f));
    ag7100_reg_wr(AG7100_DMA_TX_CTRL, AG7100_TXE);

    for (i = 0; i < MAX_WAIT; i++) {
        udelay(10);
        if (!ag7100_tx_owned_by_dma(f))
            break;
    }
    if (i == MAX_WAIT)
        printf("Tx Timed out\n");

    f->pkt_start_addr = 0;
    f->pkt_size = 0;

    if (++mac.next_tx >= NO_OF_TX_FIFOS)
        mac.next_tx = 0;
#endif

    return (0);
}

unsigned char uip_buf[];
extern volatile unsigned short uip_len;

static int ag7100_recv(struct eth_device *dev)
{
    int length,i;
    ag7100_desc_t *f;
#ifdef USE_TWO_MII//two mii
    ag7100_mac_t *mac;

    mac = (ag7100_mac_t *)dev->priv;
    for (;;) {
        f = mac->fifo_rx[mac->next_rx];
        if (ag7100_rx_owned_by_dma(f))
            break;

        length = f->pkt_size;
#if 1////http-uid_buf
      	if (length > 0 ){
	  		//DEBUG_MSG("uip_len length = %d \n",length);
	  		//if(length > 18 ){
	  			memcpy(uip_buf, NetRxPackets[mac->next_rx], 14);	  			
	  			memcpy(uip_buf+14, NetRxPackets[mac->next_rx]+14, length - 14 - 4 );
	  			uip_len = length - 4;
	  		//}
	  		//else{
	  			//memcpy(uip_buf, NetRxPackets[mac->next_rx], length);
	  			//uip_len = length;
	  		//}		  		
#ifdef DUMP_PKT
			printf("rec pkt dump\n");
        	for (i = 0; i < uip_len; i++) {
        		printf("%x-",uip_buf[i]);            	
       		}
       		printf("\n");

#endif       		
		} 
//http-uid_buf
#else     
        NetReceive(NetRxPackets[mac->next_rx] , length - 4);
#endif
        flush_cache((u32) NetRxPackets[mac->next_rx] , PKTSIZE_ALIGN);

        ag7100_rx_give_to_dma(f);

        if (++mac->next_rx >= NO_OF_RX_FIFOS)
            mac->next_rx = 0;
    }

    if (!(ag7100_reg_rd(mac, AG7100_DMA_RX_CTRL))) {
        ag7100_reg_wr(mac, AG7100_DMA_RX_DESC, virt_to_phys(f));
        ag7100_reg_wr(mac, AG7100_DMA_RX_CTRL, 1);
    }
#else//two mii
    for (;;) {
        f = mac.fifo_rx[mac.next_rx];
        if (ag7100_rx_owned_by_dma(f))
            break;            

        length = f->pkt_size;
#if 1////http-uid_buf
      	if (length > 0 ){
	  		//DEBUG_MSG("uip_len length = %d \n",length);
	  		//if(length > 18 ){
	  			memcpy(uip_buf, NetRxPackets[mac.next_rx], 14);	  			
	  			memcpy(uip_buf+14, NetRxPackets[mac.next_rx]+14, length - 14 - 4 );
	  			uip_len = length - 4;
	  		//}
	  		//else{
	  			//memcpy(uip_buf, NetRxPackets[mac.next_rx], length);
	  			//uip_len = length;
	  		//}	
#ifdef DUMP_PKT
			printf("rec pkt dump\n");
        	for (i = 0; i < uip_len; i++) {
        		printf("%x-",uip_buf[i]);            	
       		}
       		printf("\n");

#endif	  
		} 
//http-uid_buf
#else     
        NetReceive(NetRxPackets[mac.next_rx], length - 4);
#endif
        flush_cache((u32) NetRxPackets[mac.next_rx], PKTSIZE_ALIGN);
        ag7100_rx_give_to_dma(f);

        if (++mac.next_rx >= NO_OF_RX_FIFOS)
            mac.next_rx = 0;
    }

    if (!(ag7100_reg_rd(AG7100_DMA_RX_CTRL))) {
        ag7100_reg_wr(AG7100_DMA_RX_DESC, virt_to_phys(f));
        ag7100_reg_wr(AG7100_DMA_RX_CTRL, 1);
    }
#endif//#ifdef USE_TWO_MII

    return (0);
}

#ifdef USE_TWO_MII//two mii
static void ag7100_hw_start(ag7100_mac_t *mac)
#else//two mii
static void ag7100_hw_start()
#endif//#ifdef USE_TWO_MII
{
    u32 mii_ctrl_val, isXGMII = CFG_GMII;

#ifdef CFG_MII0_RGMII
	DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_RGMII ");
   mii_ctrl_val = 0x12;//100     
#else
#ifdef CFG_MII0_MII
	DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_MII\n");
   	mii_ctrl_val = 0x11;//100   	   	
#else
#ifdef CFG_MII0_RMII
	DEBUG_MSG("ag7100_hw_start: CFG_MII0/1_RMII\n");
   	mii_ctrl_val = 0x13;//100
#endif
#endif
#endif
	DEBUG_MSG("ag7100_hw_start: isXGMII=%x\n",isXGMII);
#ifdef USE_TWO_MII//two mii
	/* ethernet mac0 setting enable tx and rx */
    ag7100_reg_wr(mac, AG7100_MAC_CFG1, (AG7100_MAC_CFG1_RX_EN |
		    AG7100_MAC_CFG1_TX_EN));//AR7100_GE0_BASE 0x19000000
	/* ethernet mac0 setting fdx, enable crc and length check */    
	
    ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, (AG7100_MAC_CFG2_PAD_CRC_EN |
		         AG7100_MAC_CFG2_LEN_CHECK));//AR7100_GE0_BASE 0x19000000	


#if 1
    /* ethernet mac0 setting interface mode MII/RMII or RGMII/GMII */ 
    ag7100_set_mac_if(mac, isXGMII);
#endif

    //ag7100_reg_wr(mac, AG7100_MAC_CFG2, 0x7135);
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_0, 0x1f00);

#if 0
    ag7100_reg_wr(mac, AR7100_MII0_CTRL, ag7100_get_mii_if());
#else
	/* just mii 0 setting type and speed */
    if(mac->mac_unit == 0) {
        ar7100_reg_wr(AR7100_MII0_CTRL, mii_ctrl_val);
    } else {
        ar7100_reg_wr(AR7100_MII1_CTRL, mii_ctrl_val);
    }
#endif

    //ag7100_reg_wr(mac, AG7100_MAC_IFCTL, 0x10000);
    //ag7100_reg_wr(mac, AG7100_MAC_CFG1, 0x005);
    ag7100_reg_wr(mac, AG7100_MAC_MII_MGMT_CFG, AG7100_MGMT_CFG_CLK_DIV_20);

    ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_4, 0x3ffff);
    ag7100_reg_rmw_clear(mac, AG7100_MAC_FIFO_CFG_5, (1 << 19));
#ifdef AR9100
	DEBUG_MSG("AR9100\n");	
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x780008);
#else
	DEBUG_MSG("not AR9100\n");	
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x400fff);
#endif	
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_1, 0xfff0000);
    ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_2, 0x1fff);
	DEBUG_MSG(": cfg1 %#x cfg2 %#x\n", ag7100_reg_rd(mac, AG7100_MAC_CFG1),
        ag7100_reg_rd(mac, AG7100_MAC_CFG2));
#else//two mii
	/* ethernet mac0 setting enable tx and rx */
    ag7100_reg_wr(AG7100_MAC_CFG1, (AG7100_MAC_CFG1_RX_EN |
		    AG7100_MAC_CFG1_TX_EN));//AR7100_GE0_BASE 0x19000000
	/* ethernet mac0 setting fdx, enable crc and length check */    
	ag7100_reg_rmw_set(AG7100_MAC_CFG2, (AG7100_MAC_CFG2_PAD_CRC_EN |
		         AG7100_MAC_CFG2_LEN_CHECK));//AR7100_GE0_BASE 0x19000000	

    /* ethernet mac0 setting interface mode MII/RMII or RGMII/GMII */ 
    ag7100_set_mac_if(isXGMII);//AR7100_GE0_BASE 0x19000000,AG7100_MAC_CFG2

    //ag7100_reg_wr(AG7100_MAC_CFG2, 0x7135);
    ag7100_reg_wr(AG7100_MAC_FIFO_CFG_0, 0x1f00);//AR7100_GE0_BASE 0x19000000

#if 0
    ag7100_reg_wr(AR7100_MII0_CTRL, ag7100_get_mii_if());
#else
	/* just mii 0 setting type and speed */
    ar7100_reg_wr(AR7100_MII0_CTRL, mii_ctrl_val);    
#endif

    //ag7100_reg_wr(AG7100_MAC_IFCTL, 0x10000);
    //ag7100_reg_wr(AG7100_MAC_CFG1, 0x005);
    ag7100_reg_wr(AG7100_MAC_MII_MGMT_CFG, AG7100_MGMT_CFG_CLK_DIV_20);//AR7100_GE0_BASE 0x19000000

    ag7100_reg_rmw_set(AG7100_MAC_FIFO_CFG_4, 0x3ffff);
    ag7100_reg_rmw_clear(AG7100_MAC_FIFO_CFG_5, (1 << 19));
#ifdef AR9100
	DEBUG_MSG("AR9100\n");	
    ag7100_reg_wr(AG7100_MAC_FIFO_CFG_3, 0x780008);    
#else
	DEBUG_MSG("not AR9100\n");	
    ag7100_reg_wr(AG7100_MAC_FIFO_CFG_3, 0x400fff);
#endif	
    ag7100_reg_wr(AG7100_MAC_FIFO_CFG_1, 0xfff0000);
    ag7100_reg_wr(AG7100_MAC_FIFO_CFG_2, 0x1fff);
    
    DEBUG_MSG(": cfg1 %#x cfg2 %#x\n", ag7100_reg_rd(AG7100_MAC_CFG1),
        ag7100_reg_rd(AG7100_MAC_CFG2));
#endif//#ifdef USE_TWO_MII
    
}

#ifdef USE_TWO_MII//two mii
static void ag7100_set_mac_from_link(ag7100_mac_t *mac, int speed, int fdx)
{
    int is1000 = (speed == _1000BASET);
    int is100 = (speed == _100BASET);

	DEBUG_MSG("ag7100_set_mac_from_link:\n");
    mac->speed = speed;
    mac->duplex = fdx;

    ag7100_set_mii_ctrl_speed(mac, speed);
    ag7100_set_mac_if(mac, is1000);
    ag7100_set_mac_duplex(mac, fdx);

    if (!is1000)
        ag7100_set_mac_speed(mac, is100);
    /*
     * XXX program PLL
     */
    mac->link = 1;
}
#else//two mii
static void ag7100_set_mac_from_link(int speed, int fdx)
{
    int is1000 = (speed == _1000BASET);
    int is100 = (speed == _100BASET);
	
	DEBUG_MSG("ag7100_set_mac_from_link:\n");
    mac.speed = speed;
    mac.duplex = fdx;

    ag7100_set_mii_ctrl_speed(speed);
    ag7100_set_mac_if(is1000);
    ag7100_set_mac_duplex(fdx);

    if (!is1000)
        ag7100_set_mac_speed(is100);
    /*
     * XXX program PLL
     */
    mac.link = 1;
}
#endif//#ifdef USE_TWO_MII

#ifdef USE_TWO_MII//two mii
static int ag7100_check_link()
{
    u32 link, duplex, speed, fdx, i;
	printf("ag7100_check_link:\n");
#if !defined(CFG_ATHRS26_PHY) && !defined(CFG_ATHRHDR_EN)
#if 0
    ag7100_phy_link(mac->mac_unit, link, duplex, speed);
    ag7100_phy_duplex(mac->mac_unit,duplex);
    ag7100_phy_speed(mac->mac_unit,speed);
	if(duplex){
		 duplex = FULL;
		 printf("%s is duplex\n",mac->dev->name);
	}	 
    mac->link = link;
    if(!mac->link) {
        printf("%s link down\n",mac->dev->name);
        return 0;
    }
#else
#ifdef CFG_SP1000
	DEBUG_MSG("ag7100_set_mac_from_link:\n");("ag7100_check_link : RGMII\n");
    mac->link = 1;
    duplex = FULL;
    speed = _1000BASET;
#else
	DEBUG_MSG("ag7100_set_mac_from_link:\n");("ag7100_check_link: RMII\n");
    duplex = FULL;
    speed = _100BASET;
#endif      
#endif
#else
     duplex = FULL;
     speed = _100BASET;
#endif
      
    if (speed == _1000BASET) {
    	DEBUG_MSG("ag7100_check_link: _1000BASET\n");
#ifdef AR9100
	uint32_t shift, reg, val;
#endif

#ifndef AR9100
        i = *(volatile int *) 0xb8050004;
        i = i | (0x6 << 19);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
        /* eth into clock setting */
        *(volatile int *) 0xb8050014 = 0x1a000000;
        //*(volatile int *) 0xb8050014 = 0x0a000000;
        /* set eth0 pll setting */		
        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3b << 19));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
		/* reset eth0 pll setting */
        i = *(volatile int *) 0xb8050004;
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
		/* clear reset eth0 pll setting */
        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
#endif     
        if(!mac->mac_unit){
            ar7100_reg_wr(AR7100_MII0_CTRL, 0x22);
	} else {
	    ar7100_reg_wr(AR7100_MII1_CTRL, 0x22);
	}
        ag7100_reg_rmw_clear(mac, AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, 0x7215);
        ag7100_reg_wr(mac, AG7100_MAC_FIFO_CFG_3, 0x780fff);

#ifdef AR9100
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

	//printf("pll reg %#x: %#x  ", reg, ar7100_reg_rd(reg));
#endif
        ag7100_reg_rmw_set(mac, AG7100_MAC_FIFO_CFG_5, (1 << 19));

        if(mac->mac_unit == 0) {
            ag7100_miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1f, 0x1);
            ag7100_miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1c, 0x3000);
            ag7100_miiphy_write(mac->dev->name, CFG_PHY_ADDR, 0x1f, 0x0);
       }
    } else if (speed == _100BASET) {
		DEBUG_MSG("ag7100_check_link: _100BASET\n");
#ifdef AR9100
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

#else

        i = *(volatile int *) 0xb8050004;
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        *(volatile int *) 0xb8050014 = 0x13000a44;

        *(volatile int *) 0xb805001c = 0x00000909;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x1 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
#endif
        ag7100_reg_rmw_clear(mac, AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(mac, AG7100_MAC_CFG2, 0x7115);
    }

    if (mac->link && (duplex == mac->duplex) && (speed == mac->speed)){
    	printf("same as dup %d speed %d\n", duplex, speed);
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
}
#else//two mii
static int ag7100_check_link()
{
    u32 link, duplex, speed, fdx, i;
#if 0
    if (!(link = miiphy_link("eth0", CFG_PHY_ADDR))) {
        mac.link = 0;
        printf("link down\n");
        return 0;
    }
#endif
	printf("ag7100_check_link:\n");
//    duplex = miiphy_duplex("eth0", CFG_PHY_ADDR);
//    speed = miiphy_speed("eth0", CFG_PHY_ADDR);
#ifdef CFG_SP1000
	DEBUG_MSG("ag7100_check_link : RGMII\n");
    duplex = FULL;
    speed = _1000BASET;
#else
	DEBUG_MSG("ag7100_check_link: RMII\n");
    duplex = FULL;
    speed = _100BASET;
#endif      
      
    if (speed == _1000BASET) {
    	DEBUG_MSG("ag7100_check_link: _1000BASET\n");
    	/* eth pll setting */
    	/* reset eth0 pll setting */
        i = *(volatile int *) 0xb8050004;
        //DEBUG_MSG("ag7100_check_link: pll=0x%x\n",*(volatile int *) 0xb8050004);
        i = i | (0x6 << 19);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
        /* eth into clock setting */
        *(volatile int *) 0xb8050014 = 0x1a000000;
        //*(volatile int *) 0xb8050014 = 0x0a000000;
        /* set eth0 pll setting */		
        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3b << 19));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
		/* reset eth0 pll setting */
        i = *(volatile int *) 0xb8050004;
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
		/* clear reset eth0 pll setting */
        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        ar7100_reg_wr(AR7100_MII0_CTRL, 0x22);
        ag7100_reg_rmw_clear(AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(AG7100_MAC_CFG2, 0x7215);
        ag7100_reg_wr(AG7100_MAC_FIFO_CFG_3, 0x780fff);
#if 0        
        miiphy_write("eth0", CFG_PHY_ADDR, 0x1f, 0x1);
        miiphy_write("eth0", CFG_PHY_ADDR, 0x1c, 0x3000);
        miiphy_write("eth0", CFG_PHY_ADDR, 0x1f, 0x0);
#else
        ag7100_miiphy_write("eth0", CFG_PHY_ADDR/*0*/, 0x1f, 0x1);
        ag7100_miiphy_write("eth0", CFG_PHY_ADDR, 0x1c, 0x3000);
        ag7100_miiphy_write("eth0", CFG_PHY_ADDR, 0x1f, 0x0);
#endif        
    } else if (speed == _100BASET) {
		DEBUG_MSG("ag7100_check_link: _100BASET\n");
		/* pll setting */
        i = *(volatile int *) 0xb8050004;
        //DEBUG_MSG("ag7100_check_link: pll=0x%x\n",*(volatile int *) 0xb8050004);
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);
		/* eth into clock setting */
        *(volatile int *) 0xb8050014 = 0x13000a44;
        *(volatile int *) 0xb805001c = 0x00000909;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x1 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i | (0x3 << 20);
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        i = *(volatile int *) 0xb8050004;
        i = i & (~(0x3 << 20));
        *(volatile int *) 0xb8050004 = i;
        udelay(100);

        ag7100_reg_rmw_clear(AG7100_MAC_CFG2, 0xffff);
        ag7100_reg_rmw_set(AG7100_MAC_CFG2, 0x7115);
    }

    if (mac.link && (duplex == mac.duplex) && (speed == mac.speed)){
    	DEBUG_MSG("same as dup %d speed %d\n", duplex, speed);
        return 1;
    }    

    mac.duplex = duplex;
    mac.speed = speed;
    mac.link = 1;

    fdx = (duplex == FULL) ? 1 : 0;
    DEBUG_MSG("dup %d speed %d\n", fdx, speed);

    ag7100_set_mac_duplex(fdx);

    if (speed == _100BASET)
        ag7100_set_mac_speed(1);
    else if (speed == _10BASET)
        ag7100_set_mac_speed(0);

    return 1;
}
#endif//#ifdef USE_TWO_MII

#ifdef USE_TWO_MII//two mii
/*
 * For every command we re-setup the ring and start with clean h/w rx state
 */
static int ag7100_clean_rx(struct eth_device *dev, bd_t * bd)
{
#if defined(CFG_ATHRS26_PHY)
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

#endif
    return 1;

}
#else//two mii
static int ag7100_clean_rx(struct eth_device *dev, bd_t * bd)
{
#if defined(CFG_ATHRS26_PHY)
    int i;
    ag7100_desc_t *fr;
	DEBUG_MSG("ag7100_clean_rx\n");
    if (!ag7100_check_link()){
        return 0;
    }    

    mac.next_rx = 0;
    for (i = 0; i < NO_OF_RX_FIFOS; i++) {
        fr = mac.fifo_rx[i];
        fr->pkt_start_addr = virt_to_phys(NetRxPackets[i]);
        flush_cache((u32) NetRxPackets[i], PKTSIZE_ALIGN);
        ag7100_rx_give_to_dma(fr);
    }

    ag7100_reg_wr(AG7100_DMA_RX_DESC, virt_to_phys(mac.fifo_rx[0]));
    ag7100_reg_wr(AG7100_DMA_RX_CTRL, AG7100_RXE);	/* rx start */
    udelay(1000 * 1000);
#endif
    return 1;
}
#endif//#ifdef USE_TWO_MII

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

#ifdef USE_TWO_MII//two mii
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
#else//two mii
static int ag7100_setup_fifos()
{
    int i;

    if (ag7100_alloc_fifo(NO_OF_TX_FIFOS, mac.fifo_tx))
        return 1;

    for (i = 0; i < NO_OF_TX_FIFOS; i++) {
        mac.fifo_tx[i]->next_desc = (i == NO_OF_TX_FIFOS - 1) ?
            virt_to_phys(mac.fifo_tx[0]) : virt_to_phys(mac.fifo_tx[i + 1]);
        ag7100_tx_own(mac.fifo_tx[i]);
    }

    if (ag7100_alloc_fifo(NO_OF_RX_FIFOS, mac.fifo_rx))
        return 1;

    for (i = 0; i < NO_OF_RX_FIFOS; i++) {
        mac.fifo_rx[i]->next_desc = (i == NO_OF_RX_FIFOS - 1) ?
            virt_to_phys(mac.fifo_rx[0]) : virt_to_phys(mac.fifo_rx[i + 1]);
    }

    return (1);
}
#endif//#ifdef USE_TWO_MII

#ifdef USE_TWO_MII//two mii
static void ag7100_halt(struct eth_device *dev)
{
    ag7100_mac_t *mac = (ag7100_mac_t *)dev->priv;
    ag7100_reg_wr(mac, AG7100_DMA_RX_CTRL, 0);
    while (ag7100_reg_rd(mac, AG7100_DMA_RX_CTRL));
}
#else//two mii
static void ag7100_halt(struct eth_device *dev)
{
    ag7100_reg_wr(AG7100_DMA_RX_CTRL, 0);//AR7100_GE0_BASE 
    while (ag7100_reg_rd(AG7100_DMA_RX_CTRL));//AR7100_GE0_BASE
}
#endif//#ifdef USE_TWO_MII

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
    
    buf = (unsigned char*)(0xbf020000); 
    
    if(*buf == 0xffff)
       return NULL;

    for(i=0; i<8; i++)
    {    	
    	if((p = strchr(buf, lan_mac_str[i])) != NULL)
	    	buf = p + 1;  
    }

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

    return (char *)mac_addr;
}


static void ag7100_get_ethaddr(struct eth_device *dev)
{
#if 0
    extern flash_info_t flash_info[];
    unsigned char *eeprom;
    unsigned char *mac = dev->enetaddr;

    /* MAC address is store in the 2nd 4k of last sector */
    eeprom = (unsigned char *) (KSEG1ADDR(AR7100_SPI_BASE) + (4 * 1024) +
		flash_info[0].size -
		(64 * 1024) /* sector_size */ );
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
    if (mac[0] == 0xff && mac[5] == 0xff) {
        mac[0] = 0x00;
        mac[1] = 0x03;
        mac[2] = 0x7f;
        mac[3] = 0x09;
        mac[4] = 0x0b;
        mac[5] = 0xad;  
        printf("No valid address in Flash. Using fixed address\n");
    }    			   
#endif

}

#ifdef USE_TWO_MII//two mii
int ag7100_enet_initialize(bd_t * bis)
{
    struct eth_device *dev[CFG_AG7100_NMACS];
    u32 mask, mac_h, mac_l;
    int i;
#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
    u32 pll_value;
#endif

    DEBUG_MSG("ag7100_enet_initialize...\n");

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
        if(!i) {
	/* reset ethernet */
            mask = (AR7100_RESET_GE0_MAC | AR7100_RESET_GE0_PHY |
                    AR7100_RESET_GE1_MAC | AR7100_RESET_GE1_PHY);

            ar7100_reg_rmw_set(AR7100_RESET, mask);
            udelay(1000 * 100);

            ar7100_reg_rmw_clear(AR7100_RESET, mask);
            udelay(1000 * 100);

            udelay(10 * 1000);
        }
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
			memcpy(__local_enet_addr, dev[i]->enetaddr, 6);
		}	

            printf("%s: %02x:%02x:%02x:%02x:%02x:%02x\n", dev[i]->name,
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
        DEBUG_MSG("%s up\n",dev[i]->name);
    }

#ifdef CONFIG_AR9100_MDIO_DEBUG
    ag7100_dump_vsc_regs(ag7100_macs[i]);
#endif

#ifdef CFG_MII0_RGMII	
#ifdef CFG_SP1000 
  	/* set Pll */	
    udelay(100 * 1000);
	ag7100_check_link(ag7100_macs[0]);

	DEBUG_MSG("CFG_PLL_FREQ=%x\n", CFG_PLL_FREQ);
    DEBUG_MSG("CFG_HZ=%x\n", CFG_HZ); 
	DEBUG_MSG("cpu pll=%x\n",*(volatile int *) 0xb8050000);
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
	DEBUG_MSG("ag7100_enet_initialize end\n");
#endif
#endif
    return 1;
}
#else//two mii
int ag7100_enet_initialize(bd_t * bis)
{
    struct eth_device *dev;
    u32 mask, mac_h, mac_l;
    int i;
#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
    u32 pll_value;
#endif
	/* Workaround to bring the TX_EN to low */
	/* reset ethernet 0/1 */
    mask = (AR7100_RESET_GE0_MAC | AR7100_RESET_GE0_PHY |
            AR7100_RESET_GE1_MAC | AR7100_RESET_GE1_PHY);

    ar7100_reg_rmw_set(AR7100_RESET, mask);//AR7100_RESET_BASE 0xb8060000
    udelay(1000 * 100);

    ar7100_reg_rmw_clear(AR7100_RESET, mask);
    udelay(1000 * 100);
    
    /* mii 0/1 setting type and speed */
    *(volatile int *) 0xb8070000 = 0x13;
    *(volatile int *) 0xb8070004 = 0x11;

    udelay(10 * 1000);
    /* ethernet 0/1 mac setting disable tx and rx then reset */
    *(volatile int *) 0xb9000000 = 0x0;
    *(volatile int *) 0xba000000 = 0x0;
    
    ar7100_reg_rmw_set(AR7100_RESET, mask);//AR7100_RESET_BASE 0xb8060000
    udelay(1000 * 100);

    //i = *(volatile int *) 0xb806001c ;
    //*(volatile int *) 0xb806001c = (i | 0x3300);
    //udelay(10 * 1000);


    if ((dev = (struct eth_device *) malloc(sizeof *dev)) == NULL) {
        puts("malloc failed\n");
        return 0;
    }
    memset(&mac, 0, sizeof(mac));
    memset(dev, 0, sizeof *dev);

    sprintf(dev->name, "eth0");
    ag7100_get_ethaddr(dev);

    dev->iobase = 0;
    dev->priv = 0;
    dev->init = ag7100_clean_rx;
    dev->halt = ag7100_halt;
    dev->send = ag7100_send;
    dev->recv = ag7100_recv;

    eth_register(dev);
#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_ATHRHDR_EN\n");
    athrs26_reg_dev(dev);
#endif
#if (CONFIG_COMMANDS & CFG_CMD_MII)
	DEBUG_MSG("CFG_CMD_MII\n");
    miiphy_register(dev->name, ag7100_miiphy_read, ag7100_miiphy_write);
#endif

	/* reset ethernet */
    mask = (AR7100_RESET_GE0_MAC | AR7100_RESET_GE0_PHY |
            AR7100_RESET_GE1_MAC | AR7100_RESET_GE1_PHY);

    ar7100_reg_rmw_set(AR7100_RESET, mask);//AR7100_RESET_BASE 0xb8060000
    udelay(1000 * 100);

    ar7100_reg_rmw_clear(AR7100_RESET, mask);
    udelay(1000 * 100);

    udelay(10 * 1000);
    /* ethernet 0 mii and mac setting */
    ag7100_hw_start();
    /* ethernet setting fifo desc */
    ag7100_setup_fifos();

#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_SWITCH_FREQ\n");
    pll_value = ar7100_reg_rd(AR7100_CPU_PLL_CONFIG);
    mask = pll_value & ~(PLL_CONFIG_PLL_FB_MASK | PLL_CONFIG_REF_DIV_MASK);
    mask = mask | (0x64 << PLL_CONFIG_PLL_FB_SHIFT) |
        (0x5 << PLL_CONFIG_REF_DIV_SHIFT) | (1 << PLL_CONFIG_AHB_DIV_SHIFT);

    ar7100_reg_wr_nf(AR7100_CPU_PLL_CONFIG, mask);
    udelay(100 * 1000);
#endif

    ag7100_phy_setup(0);
    udelay(100 * 1000);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_SWITCH_FREQ)
	DEBUG_MSG("CFG_ATHRS26_PHY & CFG_SWITCH_FREQ\n");
    ar7100_reg_wr_nf(AR7100_CPU_PLL_CONFIG, pll_value);
    udelay(100 * 1000);
#endif
    {
        int j;
        unsigned char *mac = dev->enetaddr;
        
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
        	memcpy(__local_enet_addr, mac, 6);	
		}	

        printf("%s: %02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
               mac[0] & 0xff, mac[1] & 0xff, mac[2] & 0xff,
               mac[3] & 0xff, mac[4] & 0xff, mac[5] & 0xff);
    }
    mac_l = (dev->enetaddr[4] << 8) | (dev->enetaddr[5]);
    mac_h = (dev->enetaddr[0] << 24) | (dev->enetaddr[1] << 16) |
        (dev->enetaddr[2] << 8) | (dev->enetaddr[3] << 0);
	/* ethernet 0 mac addrs setting */
    ag7100_reg_wr(AG7100_GE_MAC_ADDR1, mac_l);
    ag7100_reg_wr(AG7100_GE_MAC_ADDR2, mac_h);

#if defined(CFG_ATHRS26_PHY) && defined(CFG_ATHRHDR_EN)
    /* if using header for register configuration, we have to     */
    /* configure s26 register after frame transmission is enabled */
    DEBUG_MSG("CFG_ATHRS26_PHY & CFG_ATHRHDR_EN2\n");
    athrs26_reg_init();
#endif
	
#ifdef CFG_MII0_RGMII	
#ifdef CFG_SP1000 
  	/* set Pll */	
    udelay(100 * 1000);
	ag7100_check_link();	      
#endif	
#endif
	DEBUG_MSG("CFG_PLL_FREQ=%x\n", CFG_PLL_FREQ);
    DEBUG_MSG("CFG_HZ=%x\n", CFG_HZ);
    DEBUG_MSG("cpu pll=%x\n",*(volatile int *) 0xb8050000);
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
    
    //DEBUG_MSG("eth1 clk pll=%x\n",*(volatile int *) 0xb8050018); 	
    //DEBUG_MSG("eth1 mii=%x\n",*(volatile int *) 0xb8070004);     
    //DEBUG_MSG("eth1 cfg1=%x\n",*(volatile int *) 0xba000000);
    //DEBUG_MSG("eth1 cfg2=%x\n",*(volatile int *) 0xba000004);    
    //DEBUG_MSG("eth1 fcfg_0=%x\n", *(volatile int *) 0xba050048);
	//DEBUG_MSG("eth1 fcfg_1=%x\n", *(volatile int *) 0xba05004c);
    //DEBUG_MSG("eth1 fcfg_2=%x\n", *(volatile int *) 0xba050050);
    //DEBUG_MSG("eth1 fcfg_3=%x\n", *(volatile int *) 0xba050054);
    //DEBUG_MSG("eth1 fcfg_4=%x\n", *(volatile int *) 0xba050058);
    //DEBUG_MSG("eth1 fcfg_5=%x\n", *(volatile int *) 0xba05005c);  	    
	DEBUG_MSG("ag7100_enet_initialize end\n");
    return 1;
}
#endif//#ifdef USE_TWO_MII

//#if (CONFIG_COMMANDS & CFG_CMD_MII)
#ifdef USE_TWO_MII//two mii
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
#else//two mii
int ag7100_miiphy_read(char *devname, unsigned char phaddr,
	       unsigned char reg, unsigned short *value)
{
#if defined(CFG_ATHRS26_PHY)
    uint16_t addr = (phaddr << AG7100_ADDR_SHIFT) | reg;
    volatile int rddata;
	DEBUG_MSG("ag7100_miiphy_read\n");
    ag7100_reg_wr(AG7100_MII_MGMT_CMD, 0x0);
    ag7100_reg_wr(AG7100_MII_MGMT_ADDRESS, addr);
    ag7100_reg_wr(AG7100_MII_MGMT_CMD, AG7100_MGMT_CMD_READ);

    rddata = ag7100_reg_rd(AG7100_MII_MGMT_IND) & 0x1;
    while (rddata) {
        rddata = ag7100_reg_rd(AG7100_MII_MGMT_IND) & 0x1;
    }

    *value = ag7100_reg_rd(AG7100_MII_MGMT_STATUS);
    ag7100_reg_wr(AG7100_MII_MGMT_CMD, 0x0);
#endif
    return 0;
}

int ag7100_miiphy_write(char *devname, unsigned char phaddr,
	        unsigned char reg, unsigned short data)
{
#if defined(CFG_ATHRS26_PHY)    
    uint16_t addr = (phaddr << AG7100_ADDR_SHIFT) | reg;
    volatile int rddata;
	DEBUG_MSG("ag7100_miiphy_write\n");
    ag7100_reg_wr(AG7100_MII_MGMT_ADDRESS, addr);
    ag7100_reg_wr(AG7100_MII_MGMT_CTRL, data);

    rddata = ag7100_reg_rd(AG7100_MII_MGMT_IND) & 0x1;
    while (rddata) {
        rddata = ag7100_reg_rd(AG7100_MII_MGMT_IND) & 0x1;
    }
    return 0;
#endif    
}    
#endif//#ifdef USE_TWO_MII
//#endif		/* CONFIG_COMMANDS & CFG_CMD_MII */
