/*
 * This file contains the configuration parameters for the dbau1x00 board.
 */

#ifndef __CONFIG_H
#define __CONFIG_H


//#define DEBUG_MSG printf
#define DEBUG_MSG

#include <configs/ar7100.h>

/*-----------------------------------------------------------------------
 * FLASH and environment organization
 */
#define CFG_MAX_FLASH_BANKS     1       /* max number of memory banks */
#define CFG_MAX_FLASH_SECT      128    /* max number of sectors on one chip */
#define CFG_FLASH_SECTOR_SIZE   (64*1024)
#define CFG_FLASH_SIZE          0x00800000 /* Total flash size */

#define CFG_FLASH_WORD_SIZE     unsigned short 
#define CFG_FLASH_ADDR0         (0x5555)        
#define CFG_FLASH_ADDR1         (0x2AAA)

/* 
 * We boot from this flash
 */
#define CFG_FLASH_BASE          0xbf000000

#undef CONFIG_ROOTFS_RD
#undef CONFIG_ROOTFS_FLASH
#undef CONFIG_BOOTARGS_FL
#undef CONFIG_BOOTARGS_RD
#undef CONFIG_BOOTARGS
#undef  MTDPARTS_DEFAULT
#undef  MTDIDS_DEFAULT

#define CONFIG_ROOTFS_FLASH
#define CONFIG_BOOTARGS CONFIG_BOOTARGS_FL

//#define CONFIG_BOOTARGS_RD     "console=ttyS0,115200 root=01:00 rd_start=0x80600000 rd_size=5242880 init=/sbin/init mtdparts=ar9100-nor0:256k(u-boot),64k(u-boot-env),4096k(rootfs),2048k(uImage)"



/* 
 * The following #defines are needed to get flash environment right 
 */
#define CFG_MONITOR_BASE    TEXT_BASE
#define CFG_MONITOR_LEN     (192 << 10)

/* XXX - putting rootfs in last partition results in jffs errors */

//Ori#define CONFIG_BOOTARGS_FL     "console=ttyS0,115200 root=31:02 rootfstype=jffs2 init=/sbin/init mtdparts=ar7100-nor0:256k(uboot),128k(env),6144k(rootfs),64k(caldata),1024k(uImage)"
//NickChou
//#define CONFIG_BOOTARGS_FL     "console=ttyS0,115200 root=31:03 rootfstype=squashfs,jffs2 init=/sbin/init mtdparts=ar7100-nor0:256k(uboot),64k(Config),1024k(vmlinux),5184k(rootfs),128k(caldata)"
#define CONFIG_BOOTARGS_FL     "console=ttyS0,115200 root=31:03 mem=64M rootfstype=squashfs,jffs2 init=/sbin/init mtdparts=ar7100-nor0:256k(uboot),64k(Config),1024k(vmlinux),5184k(rootfs),64k(caldata)"

#define BOOT_IMG_UPPER_BOUND	256 * 1024 //for upgrade bootloader in backup mode

//Ori#define MTDPARTS_DEFAULT    "mtdparts=ar7100-nor0:256k(u-boot),128k(env),6144k(rootfs),64k(caldata),1024k(uImage)"
//NickChou
#define MTDPARTS_DEFAULT    "mtdparts=ar7100-nor0:256k(u-boot),64k(Config),1024k(uImage),5184(squashfs)"

#define MTDIDS_DEFAULT      "nor0=ar7100-nor0"

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
#define CFG_HZ	(680000000/2)

/* 
 * timeout values are in ticks 
 */
#define CFG_FLASH_ERASE_TOUT    (2 * CFG_HZ) /* Timeout for Flash Erase */
#define CFG_FLASH_WRITE_TOUT    (2 * CFG_HZ) /* Timeout for Flash Write */

/*
 * Cache lock for stack
 */
#define CFG_INIT_SP_OFFSET  0x1000

#define CFG_ENV_IS_IN_FLASH    1
//#undef CFG_ENV_IS_NOWHERE  
#define CFG_ENV_IS_NOWHERE

/* Address and size of Primary Environment Sector   */
#define CFG_ENV_ADDR        0xbf040000
#define CFG_ENV_SIZE        0x10000

//Ori#define CONFIG_BOOTCOMMAND "bootm 0xbf670000"
//NickChou => 256k(uboot) + 64k(Config)
#define CONFIG_BOOTCOMMAND "bootm 0xbf050000"

#define CONFIG_NR_DRAM_BANKS    		2

/*
** Parameters defining the location of the calibration/initialization
** information for the two Merlin devices.
** NOTE: **This will change with different flash configurations**
*/

#define MERLIN24CAL			0xbf661000
#define MERLIN50CAL			0xbf665000
#define BOARDCAL			0xbf660000
#define ATHEROS_PRODUCT_ID	136
#define CAL_SECTOR			102


#define CFG_PLL_FREQ	CFG_PLL_680_340_170
//#define CFG_PLL_FREQ	CFG_PLL_400_400_200
/*
** These values for DDR configuration came from the
** BDM configuration script
*/

#define CFG_DDR_REFRESH_VAL     		0x461b
//#define CFG_DDR_CONFIG_VAL      		0xefbc8cd0
//#define CFG_DDR_CONFIG2_VAL             0x8e7156a2
#define CFG_DDR_CONFIG_VAL      		0x77b8884e
#define CFG_DDR_CONFIG2_VAL             0x812cd6a8
#define CFG_DDR_MODE_VAL_INIT   		0x131
#define CFG_DDR_EXT_MODE_VAL    		0x0
//#define CFG_DDR_MODE_VAL        		0x61
#define CFG_DDR_MODE_VAL        		0x33
#define CFG_DDR_TRTW_VAL        		0x1f
#define CFG_DDR_TWTR_VAL        		0x1e
//#define CFG_DDR_RD_DATA_THIS_CYCLE_VAL  0xffff
#define CFG_DDR_RD_DATA_THIS_CYCLE_VAL  0xff


#define CONFIG_NET_MULTI
#define CONFIG_MEMSIZE_IN_BYTES
#define CONFIG_PCI


#define CONFIG_BOOTDELAY 1

/*-----------------------------------------------------------------------
 * Cache Configuration
 */
#if 1 //NickChou
//#define CONFIG_COMMANDS (( CONFIG_CMD_DFL | CFG_CMD_MII | CFG_CMD_PING \
   | CFG_CMD_NET | CFG_CMD_PCI     | CFG_CMD_ENV | CFG_CMD_FLASH | CFG_CMD_LOADS \
   | CFG_CMD_RUN | CFG_CMD_LOADB   | CFG_CMD_ELF | CFG_CMD_BSP))
/*
*   Date: 2010-03-05
*   Name: Bing Chou
*   Reason: added to support AR8021 phy.
*   Notice :
*/
#ifdef CFG_AR8021_PHY
#define CONFIG_COMMANDS (( CONFIG_CMD_DFL & ~CFG_CMD_NFS | CFG_CMD_NET | CFG_CMD_MII))
#else
#define CONFIG_COMMANDS (( CONFIG_CMD_DFL & ~CFG_CMD_NFS | CFG_CMD_NET))
#endif
#else
#define CONFIG_COMMANDS	(( CONFIG_CMD_DFL | \
   CFG_CMD_ENV | CFG_CMD_PING | CFG_CMD_FLASH | CFG_CMD_RUN \
   ))
#endif

/*
** Ethernet Configuration
** Set default values, and select the PHY to use
*/

#define CONFIG_IPADDR       		192.168.0.1
#define CONFIG_SERVERIP     		192.168.0.107
//#define CONFIG_ETHADDR      		00:03:7f:ff:ff:fe
#define CFG_FAULT_ECHO_LINK_DOWN    1

#define USING_HTTP_UID_BUF	1 /*NickChou add*/
//#define CFG_BOOTP_FW_UPGRADE	1 //norp add for Bootp/tftp fw upgrade

#ifdef CFG_RTL8366SR_PHY
#define CFG_PHY_ADDR		0  /* Port 4 */
#define CFG_AG7100_NMACS 	2
#define CFG_GMII     		0
#define CFG_MII0_RGMII      1
#define CFG_SP1000          1 /* Configure to GIGA switch*/
//#define CONFIG_PHY_GIGE     1 /* GbE speed/duplex detect */
#else//CFG_RTL8366SR_PHY
#ifdef CFG_AR8021_PHY

#define CFG_ATHRF1_PHY                          1
#define CFG_AG7100_NMACS                        1

#define CFG_PHY_ADDR                            0  /* Port 4 */
#define CFG_GMII 1
#define CFG_MII0_RGMII 0
#define CFG_AG7100_GE0_RGMII 1
#define CFG_AG7100_GE1_RGMII 1
#define CFG_SP1000          1 /* Configure to GIGA switch*/

#else//CFG_AR8021_PHY
#define CFG_ATHRS26_PHY  	1
#define CFG_PHY_ADDR		0  /* Port 4 */
#define CFG_AG7100_NMACS 	2
//#define CFG_ATHRHDR_REG 	1
//#define CFG_SWITCH_FREQ	1
//#define CFG_ATHRHDR_EN 	1
//#define ATHRHDR_LEN   	2
//#define ATHRHDR_MAX_DATA  10
#define CFG_GMII     		0
#define CFG_MII0_RMII		1
#define CFG_MII1_RMII		1
#define CONFIG_PHY_GIGE     0  /* GbE speed/duplex detect */
#endif//CFG_AR8021_PHY
#endif//CFG_RTL8366SR_PHY

/*
** Configure Parser
*/

#define CFG_BOOTM_LEN   (16 << 20) /* 16 MB */
#define DEBUG
#define CFG_HUSH_PARSER
#define CFG_PROMPT_HUSH_PS2 "hush>"

#include <cmd_confdefs.h>

#endif  /* __CONFIG_H */
