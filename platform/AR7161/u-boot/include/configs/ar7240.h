/*
 * This file contains the configuration parameters for the dbau1x00 board.
 */

#ifndef __AR7240_H
#define __AR7240_H

#define CONFIG_MIPS32		1  /* MIPS32 CPU core	*/
#ifdef AP99
#define CONFIG_BOOTDELAY	1	/* autoboot after 4 seconds	*/
#else
#define CONFIG_BOOTDELAY	4	/* autoboot after 4 seconds	*/
#endif
#define CONFIG_BAUDRATE		115200 
#define CFG_BAUDRATE_TABLE  { 	115200}
#ifdef AP99
#define	CONFIG_TIMESTAMP		/* Print image info with timestamp */
#endif
#define CONFIG_ROOTFS_RD

#define	CONFIG_BOOTARGS_RD     "console=ttyS0,115200 root=01:00 rd_start=0x80600000 rd_size=5242880 init=/sbin/init mtdparts=ar7240-nor0:256k(u-boot),64k(u-boot-env),4096k(rootfs),2048k(uImage)"

/* XXX - putting rootfs in last partition results in jffs errors */
#define	CONFIG_BOOTARGS_FL     "console=ttyS0,115200 root=31:02 rootfstype=jffs2 init=/sbin/init mtdparts=ar7240-nor0:256k(u-boot),64k(u-boot-env),5120k(rootfs),2048k(uImage)"

#ifdef CONFIG_ROOTFS_FLASH
#define CONFIG_BOOTARGS CONFIG_BOOTARGS_FL
#else
#define CONFIG_BOOTARGS ""
#endif

/*
 * Miscellaneous configurable options
 */
#define	CFG_LONGHELP				/* undef to save memory      */
#define	CFG_PROMPT		"ar7240> "	/* Monitor Command Prompt    */
#ifdef AP99
#define	CFG_CBSIZE		256		/* Console I/O Buffer Size   */
#else
#define	CFG_CBSIZE		512		/* Console I/O Buffer Size   */
#endif
#define	CFG_PBSIZE (CFG_CBSIZE+sizeof(CFG_PROMPT)+16)  /* Print Buffer Size */
#define	CFG_MAXARGS		16		/* max number of command args*/

#define CFG_MALLOC_LEN		128*1024

#define CFG_BOOTPARAMS_LEN	128*1024

#define CFG_SDRAM_BASE		0x80000000     /* Cached addr */
//#define CFG_SDRAM_BASE		0xa0000000     /* Cached addr */

#define	CFG_LOAD_ADDR		0x81000000     /* default load address	*/
//#define	CFG_LOAD_ADDR		0xa1000000     /* default load address	*/

#define CFG_MEMTEST_START	0x80100000
#undef CFG_MEMTEST_START
#define CFG_MEMTEST_START       0x80200000
#define CFG_MEMTEST_END		0x83800000

/*------------------------------------------------------------------------
 * *  * JFFS2
 */
#define CFG_JFFS_CUSTOM_PART            /* board defined part   */
#define CONFIG_JFFS2_CMDLINE
#define MTDIDS_DEFAULT      "nor0=ar7240-nor0"

/* default mtd partition table */
#define MTDPARTS_DEFAULT    "mtdparts=ar7240-nor0:256k(u-boot),"\
                            "384k(experi-jffs2)"

#define CONFIG_MEMSIZE_IN_BYTES

#ifdef CONFIG_HORNET_EMU_HARDI_WLAN
#define CFG_HZ          24000000
#else
#define CFG_HZ          40000000
#endif


#define CFG_RX_ETH_BUFFER   16

/*
** PLL Config for different CPU/DDR/AHB frequencies
*/
#ifdef AP99
#define CFG_PLL_200_200_100   0
#define CFG_PLL_300_300_150   1
#define CFG_PLL_320_320_160   2
#define CFG_PLL_340_340_170   3
#define CFG_PLL_350_350_175   4
#define CFG_PLL_360_360_180   5
#define CFG_PLL_400_400_200   6
#define CFG_PLL_300_300_75    7
#define CFG_PLL_400_400_100   8
#define CFG_PLL_320_320_80    9
#define CFG_PLL_240_240_120   10
#define CFG_PLL_160_160_80    11
#define CFG_PLL_400_200_200   12
#define CFG_PLL_260_260_130   13
#else
#define CFG_PLL_200_200_100   0x0
#define CFG_PLL_300_300_150   0x1
#define CFG_PLL_320_320_160   0x2
#define CFG_PLL_340_340_170   0x3
#define CFG_PLL_350_350_175   0x4
#define CFG_PLL_360_360_180   0x5
#define CFG_PLL_400_400_200   0x6
#define CFG_PLL_300_300_75    0x7
#define CFG_PLL_400_400_100   0x8
#define CFG_PLL_320_320_80    0x9
#define CFG_PLL_410_400_200   0xa
#define CFG_PLL_420_400_200   0xb
#define CFG_PLL_80_80_40      0xc
#define CFG_PLL_64_64_32      0xd
#define CFG_PLL_48_48_24      0xe
#define CFG_PLL_32_32_16      0xf
#endif
/* #define CFG_PLL_FREQ	CFG_PLL_360_360_180 */
#define CFG_PLL_FREQ	CFG_PLL_400_400_200



/*-----------------------------------------------------------------------
 * Cache Configuration
 */
#define CFG_DCACHE_SIZE		32768
#define CFG_ICACHE_SIZE		65536
#define CFG_CACHELINE_SIZE	32

#endif	/* __CONFIG_H */
