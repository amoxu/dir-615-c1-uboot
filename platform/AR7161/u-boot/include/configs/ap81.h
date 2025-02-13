/*
 * This file contains the configuration parameters for the dbau1x00 board.
 */

#ifndef __CONFIG_H
#define __CONFIG_H

#include <configs/ar7100.h>

/*-----------------------------------------------------------------------
 * FLASH and environment organization
 */
#define CFG_MAX_FLASH_BANKS     1	    /* max number of memory banks */
#define CFG_MAX_FLASH_SECT      64    /* max number of sectors on one chip */
#define CFG_FLASH_SECTOR_SIZE   (64*1024)
#define CFG_FLASH_SIZE          0x00800000 /* Total flash size */

#define CFG_FLASH_WORD_SIZE     unsigned short 

/* 
 * We boot from this flash
 */
#define CFG_FLASH_BASE		    0xbf000000

/* 
 * The following #defines are needed to get flash environment right 
 */
#define	CFG_MONITOR_BASE	TEXT_BASE
#define	CFG_MONITOR_LEN		(192 << 10)

#undef CONFIG_BOOTARGS
/* XXX - putting rootfs in last partition results in jffs errors */
#define	CONFIG_BOOTARGS     "console=ttyS0,115200 root=31:03 rootfstype=squashfs,jffs2 init=/sbin/init mtdparts=ar7100-nor0:128k(u-boot),64k(Config),1024k(vmlinux),6848k(rootfs),128k(ART)"

#define BOOT_IMG_UPPER_BOUND	128 * 1024 //for upgrade bootloader in backup mode

/* default mtd partition table */
#undef MTDPARTS_DEFAULT
#define MTDPARTS_DEFAULT    "mtdparts=ar7100-nor0:128k(u-boot),64k(Config),1024k(vmlinux),6848k(rootfs),128k(ART)"

#undef CFG_PLL_FREQ
#define CFG_PLL_FREQ	CFG_PLL_400_400_100

/* Atheros Header configuration */

#define CFG_ATHRS26_PHY  1
//#define CFG_ATHRHDR_REG 1 

#ifdef CFG_ATHRHDR_REG
#undef CFG_SWITCH_FREQ
#define CFG_ATHRHDR_EN 1
#define ATHRHDR_LEN   2
#define ATHRHDR_MAX_DATA  10
#endif

#undef CFG_HZ
/*
 * MIPS32 24K Processor Core Family Software User's Manual
 *
 * 6.2.9 Count Register (CP0 Register 9, Select 0)
 * The Count register acts as a timer, incrementing at a constant
 * rate, whether or not an instruction is executed, retired, or
 * any forward progress is made through the pipeline.  The counter
 * increments every other clock, if the DC bit in the Cause register
 * is 0.
 */
/* Since the count is incremented every other tick, divide by 2 */
/* XXX derive this from CFG_PLL_FREQ */
#if (CFG_PLL_FREQ == CFG_PLL_200_200_100)
#	define CFG_HZ          (200000000/2)
#elif (CFG_PLL_FREQ == CFG_PLL_300_300_150)
#	define CFG_HZ          (200000000/2)
#elif (CFG_PLL_FREQ == CFG_PLL_333_333_166)
#	define CFG_HZ          (333000000/2)
#elif (CFG_PLL_FREQ == CFG_PLL_266_266_133)
#	define CFG_HZ          (266000000/2)
#elif (CFG_PLL_FREQ == CFG_PLL_266_266_66)
#	define CFG_HZ          (266000000/2)
#elif (CFG_PLL_FREQ == CFG_PLL_400_400_200) || (CFG_PLL_FREQ == CFG_PLL_400_400_100)
#	define CFG_HZ          (400000000/2)
#endif


/* 
 * timeout values are in ticks 
 */
#define CFG_FLASH_ERASE_TOUT	(2 * CFG_HZ) /* Timeout for Flash Erase */
#define CFG_FLASH_WRITE_TOUT	(2 * CFG_HZ) /* Timeout for Flash Write */

/*
 * Cache lock for stack
 */
#define CFG_INIT_SP_OFFSET	0x1000

#define	CFG_ENV_IS_IN_FLASH    1
//#undef CFG_ENV_IS_NOWHERE  
#define  CFG_ENV_IS_NOWHERE

/* Address and size of Primary Environment Sector	*/
#define CFG_ENV_ADDR		0xbf080000
#define CFG_ENV_SIZE		0x10000

#define CONFIG_BOOTCOMMAND "bootm 0xbf030000"
//#define CONFIG_FLASH_16BIT

#define CONFIG_NR_DRAM_BANKS	2

#if (CFG_PLL_FREQ == CFG_PLL_200_200_100)
#define CFG_DDR_REFRESH_VAL     0x4c00
#define CFG_DDR_CONFIG_VAL      0x67bc8cd0
#define CFG_DDR_MODE_VAL_INIT   0x161
#define CFG_DDR_EXT_MODE_VAL    0x2
#define CFG_DDR_MODE_VAL        0x61
#elif (CFG_PLL_FREQ == CFG_PLL_400_400_200) || (CFG_PLL_FREQ == CFG_PLL_400_400_100)
#define CFG_DDR_REFRESH_VAL     0x5f00
#define CFG_DDR_CONFIG_VAL      0x77bc8cd0
#define CFG_DDR_MODE_VAL_INIT   0x131
#define CFG_DDR_EXT_MODE_VAL    0x0
#define CFG_DDR_MODE_VAL        0x31
#endif

#define CFG_DDR_TRTW_VAL        0x1f
#define CFG_DDR_TWTR_VAL        0x1e

#define CFG_DDR_CONFIG2_VAL			    0x83d1f6a2
#define CFG_DDR_RD_DATA_THIS_CYCLE_VAL  0xffff


#define CONFIG_NET_MULTI

#define CONFIG_MEMSIZE_IN_BYTES


/*-----------------------------------------------------------------------
 * Cache Configuration
 */
#if 0 
#define CONFIG_COMMANDS	(( CONFIG_CMD_DFL | CFG_CMD_DHCP | CFG_CMD_ELF | \
            CFG_CMD_MII | CFG_CMD_PING | CFG_CMD_NET | CFG_CMD_JFFS2 |\
   CFG_CMD_ENV | CFG_CMD_FLASH | CFG_CMD_LOADS | CFG_CMD_RUN | CFG_CMD_LOADB \
   | CFG_CMD_ELF ))
#else
#define CONFIG_COMMANDS	(( CONFIG_CMD_DFL & ~CFG_CMD_NFS | \
   CFG_CMD_ENV | CFG_CMD_FLASH | CFG_CMD_RUN \
   | CFG_CMD_PING \
   ))
#endif

#define CONFIG_IPADDR   192.168.0.1
#define CONFIG_SERVERIP 192.168.0.103
#define CONFIG_ETHADDR 0x00:0xaa:0xbb:0xcc:0xdd:0xee
#define CFG_FAULT_ECHO_LINK_DOWN    1
#define USING_HTTP_UID_BUF	1 /*NickChou add*/

#define CFG_PHY_ADDR 0 

#define CFG_GMII     0
#define CFG_MII0_RMII             1

#define CFG_BOOTM_LEN	(16 << 20) /* 16 MB */
#define DEBUG
//#define CFG_HUSH_PARSER
//#define CFG_PROMPT_HUSH_PS2 "hush>"

#include <cmd_confdefs.h>

#endif	/* __CONFIG_H */
