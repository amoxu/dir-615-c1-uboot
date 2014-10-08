/*
 * (C) Copyright 2000
 * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

/*
 * Boot support
 */

#include <command.h>
#include <common.h>
#include <net.h>

#ifdef AP99
#include "../httpd/bsp.h"
#include "../httpd/defaultConf.h"
#include "../httpd/uip.h"
#include "../httpd/uip_arp.h"
#include "../httpd/httpd.h"
#include "../httpd/uipopt.h"
#include "../board/ar7240/common/ar7240_s26_phy.h"
typedef struct timer {
   unsigned int start;
   unsigned int delay;
}timer_t;

typedef struct gpio_info {
     timer_t gtimer;
     int tgl;
     int setbit;
}led_t;

led_t statLed;
#else
#include "../httpd/bsp.h"
#define SWAP_16(X)    ((((X)&0xff)<<8) | (((X)&0xff00)>>8))
#endif

extern u8_t upgrade_firmware(void);
ulong timer=0;
#define BUF ((struct uip_eth_hdr *)&uip_buf[0])
int finishflag = 0;
int flashwrite = 0;

int flashflag = 0;
#ifdef AP99
int uip_flag = 0;

void led_blinking(led_t *led)
{
    if (get_ticks()/100000 - led->gtimer.start >= led->gtimer.delay){
        led->gtimer.start = get_ticks()/100000;
            if (led->tgl)
            {
                *(volatile int *)(0xb8040008) |=(1<<led->setbit);
            }
            else
            {
                *(volatile int *)(0xb8040008) &=~(1<<led->setbit);
            }
            led->tgl ^=1;
    }
}

void led_dark(led_t *led)
{
    *(volatile int *)(0xb8040008) &=~(1<<led->setbit);
}

void wan_led_on(void)
{
	*(volatile int *)(0xb8040008) &=~(1 << 17);
	*(volatile int *)(0xb8040008) |=(1 << 7);
}

void wan_led_off(void)
{
        *(volatile int *)(0xb8040008) &=~(1 << 7);
}

void lan_led_on(int port){
	int offset = 13 + port;
	*(volatile int *)(0xb8040008) &=~(1 << offset);
}

void lan_led_off(int port){
    int offset = 13 + port;
    *(volatile int *)(0xb8040008) |=(1 << offset);
}
#endif

int do_httpd (cmd_tbl_t *cmdtp, bd_t *bd, int flag, int argc, char *argv[])
{
	u8_t arptimer;
	int i=0,j=0,ret = 0;
	char *p_mac = NULL;
	unsigned short uip_addr;
#ifdef AP99
	int dup = 0;
	timer_init();
	statLed.tgl = 0;
	statLed.setbit = 1;
	statLed.gtimer.start = get_timer(0)/100000;//MS_TICKS();
        statLed.gtimer.delay = 2000;
#endif
	/* Take Network Environment Setting*/
	bd->bi_ip_addr = DEFAULT_IP_ADDRESS;
	p_mac = getenv("ethaddr");

	/* eth init */
	DEBUG_MSG("eth init");
	eth_halt();
	eth_init(bd);

	/* uip init*/
	DEBUG_MSG("uip init");
	uip_init();

	/* httpd init */
	DEBUG_MSG("http init");
	httpd_init();

	/* Set IP address and MAC address */
    while(1) {
		bd->bi_enetaddr[j] = ((p_mac[i] - 0x30) << 4) + (p_mac[i + 1] - 0x30);
		i = i + 3;
		j++;
		if(j > 5)
			break;
	}
	uip_addr = htons( (bd->bi_ip_addr >> 16) & 0xffff);
#ifdef AP99
	uip_hostaddr[0]=  uip_addr;
	uip_addr = htons( (bd->bi_ip_addr & 0x0000ffff));
	uip_hostaddr[1]=  uip_addr;

 	uip_ethaddr.addr[0] = ag7240_enet_mac[0];
	uip_ethaddr.addr[1] = ag7240_enet_mac[1];
	uip_ethaddr.addr[2] = ag7240_enet_mac[2];
	uip_ethaddr.addr[3] = ag7240_enet_mac[3];
	uip_ethaddr.addr[4] = ag7240_enet_mac[4];
	uip_ethaddr.addr[5] = ag7240_enet_mac[5];
#else
	uip_addr = SWAP_16(uip_addr);
	uip_hostaddr[1]=  uip_addr;
	uip_addr = htons( (bd->bi_ip_addr & 0x0000ffff));
	uip_addr = SWAP_16(uip_addr);	
	uip_hostaddr[0]=  uip_addr;

	for(i=0;i<6;i++) {
		uip_ethaddr.addr[i]=bd->bi_enetaddr[i];
		DEBUG_MSG("%c%02x", i ? ':' : ' ', bd->bi_enetaddr[i]);
	}
#endif
	uip_arp_netmask[0] = 0xffff;
	uip_arp_netmask[1] = htons(0xff00);

	arptimer = 0;
	uip_len=0;
	i=0;
#ifdef AP99
	printf("Backup Mode\n");
#endif
	while(1) {
#ifdef AP99
		if(athrs26_phy_is_link_alive(4))// WAN ID = 4
			wan_led_on();
		else
			wan_led_off();

		for(i=0;i<=4;i++){
			(athrs26_phy_is_link_alive(i))?lan_led_on(i):lan_led_off(i);				
		}

		if(!flashwrite)
                        led_blinking(&statLed);
#endif	

		uip_len=0;
		ret = eth_rx();
		// Abort if ctrl-c was pressed.
		if (ctrlc()) {
			eth_halt();
			printf("\nAbort\n");
			break;
		}
		if(finishflag) {
               /* Reset system */
	        printf("System Reset \n");
			break;
		}

		if(flashwrite) {
#ifdef AP99
			led_dark(&statLed);					
#endif	
			upgrade_firmware();
			finishflag = 1;
		}
#ifdef AP99
	    	if(ret) {
#else
		if(ret = 1) {
#endif
			if(uip_len == 0) {
				// Call the ARP timer function every 10 seconds. 
				if(++arptimer == 20) {
					uip_arp_timer();
					arptimer = 0;
				}
			} else  {
				if(BUF->type == htons(UIP_ETHTYPE_IP)) {
					uip_arp_ipin();
					uip_input();
					/* If the above function invocation resulted in data that
					* should be sent out on the network, the global variable
					* uip_len is set to a value > 0. */
					if(uip_len > 0) {
						uip_arp_out();
						NetSendPacket(uip_buf,uip_len);
					}
				} else if(BUF->type == htons(UIP_ETHTYPE_ARP)) {
					uip_arp_arpin();
					/* If the above function invocation resulted in data that
					* should be sent out on the network, the global variable
					* uip_len is set to a value > 0. */	
					if(uip_len > 0) {
						NetSendPacket(uip_buf,uip_len);
					}
				}

			}
		}
	}
	return 0;
}

#ifndef AP99
U_BOOT_CMD(
	httpd,	1,	1,	do_httpd,
	"httpd  - run http server \n",
	NULL
);
#endif
