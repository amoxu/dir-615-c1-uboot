/*
 * Memory controller config:
 * Assumes that the caches are initialized.
 *
 * 0) Figah out the Tap controller settings.
 * 1) Figure out whether the interface is 16bit or 32bit.
 * 2) Size the DRAM
 *
 *  0) Tap controller settings
 *  --------------------------
 * The Table below provides all possible values of TAP controllers. We need to
 * find the extreme left and extreme right of the spectrum (of max_udelay and
 * min_udelay). We then program the TAP to be in the middle.
 * Note for this we would need to be able to read and write memory. So,
 * initially we assume that a 16bit interface, which will always work unless
 * there is exactly _1_ 32 bit part...for now we assume this is not the case.
 *
 * The algo:
 * 0) Program the controller in 16bit mode.
 * 1) Start with the extreme left of the table
 * 2) Write 0xa4, 0xb5, 0xc6, 0xd7 to 0, 2, 4, 6
 * 3) Read 0 - this will fetch the entire cacheline.
 * 4) If the value at address 4 is good, record this table entry, goto 6
 * 5) Increment to get the next table entry. Goto 2.
 * 6) Start with extreme right. Do the same as above.
 *
 * 1) 16bit or 32bit
 * -----------------
 *  31st bit of reg 0x1800_0000 will  determine the mode. By default,
 *  controller is set to 32-bit mode. In 32 bit mode, full data bus DQ [31:0]
 *  will be used to write 32 bit data. Suppose you have 16bit DDR memory
 *  (it will have 16bit wide data bus). If you try to write 16 bit DDR in 32
 *  bit mode, you are going to miss upper 16 bits of data. Reading to that
 *  location will give you only lower 16 bits correctly, upper 16 bits will
 *  have some junk value. E.g.,
 *
 *  write to 0x0000_0000 0x12345678
 *  write to 0x0000_1000 0x00000000 (just to discharge DQ[31:16] )
 *  read from 0x0000_0000
 *  if u see something like 0x0000_5678 (or XXXX_5678 but not equal to
 *  0x12345678) - its a 16 bit interface
 *
 *  2) Size the DRAM
 *  -------------------
 *  DDR wraps around. Write a pattern to 0x0000_0000. Write an address
 *  pattern at 4M, 8M, 16M etc. and check when 0x0000_0000 gets overwritten.
 *
 *
 *  We can use #define's for all these addresses and patterns but its easier
 *  to see what's going on without :)
 */
#include <common.h>
#include <asm/addrspace.h>
#include "ar7240_soc.h"


uint8_t     tap_settings[] =
            {0x40, 0x41, 0x10, 0x12, 0x13, 0x15, 0x1a, 0x1c, 0x1f, 0x2f, 0x3f};

uint16_t    tap_pattern[] = {0xa5, 0xb6, 0xc7, 0xd8};

void
ar7240_ddr_tap_set(uint8_t set)
{
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL0, set);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL1, set);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL2, set);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL3, set);
}

/*
 * We check for size in 4M increments
 */
#define AR7240_DDR_SIZE_INCR    (4*1024*1024)
int
ar7240_ddr_find_size(void)
{
#ifdef CONFIG_HORNET_EMU
    return (4*AR7240_DDR_SIZE_INCR);
#else
    uint8_t  *p = (uint8_t *)KSEG1, pat = 0x77;
    int i;

    *p = pat;

    for(i = 1; ; i++) {
        *(p + i * AR7240_DDR_SIZE_INCR) = (uint8_t)(i);
        if (*p != pat) {
            break;
        }
    }

    return (i*AR7240_DDR_SIZE_INCR);
#endif
}

void
ar7240_ddr_initial_config(uint32_t refresh)
{
#ifndef COMPRESSED_UBOOT

    int ddr_type = 0,ddr_config;
    int ddr_config2,ext_mod,ddr2_ext_mod;

    printf("\nsri\n");
#else
	int mod_val = CFG_DDR_MODE_VAL;
#endif /* #ifndef COMPRESSED_UBOOT */
#if 0
    ar7240_reg_wr(AR7240_RESET, AR7240_RESET_DDR);
    udelay(10);
#endif
#ifndef COMPRESSED_UBOOT
//	ddr2 = ((ar7240_reg_rd(0xb8050020) & 0x1) == 0);
#ifdef ENABLE_DYNAMIC_CONF
    if(*(volatile int *)CFG_DDR_MAGIC_F == CFG_DDR_MAGIC){
	ddr_config = CFG_DDR_CONFIG_VAL_F;
	ddr_config2 = CFG_DDR_CONFIG2_VAL_F;
	ext_mod = CFG_DDR_EXT_MODE_VAL_F;
	ddr2_ext_mod = ext_mod;
    }
    else {
	ddr_config = CFG_DDR_CONFIG_VAL;
	ddr_config2 = CFG_DDR_CONFIG2_VAL;
	ext_mod = CFG_DDR_EXT_MODE_VAL;
        ddr2_ext_mod = CFG_DDR2_EXT_MODE_VAL;
    }

    ddr_type = ar7240_reg_rd(0xb8050020);
    if ((ddr_type & 0x1) == 0) {
        ar7240_reg_wr_nf(0xb800008c, 0xA59);
        udelay(100);
        ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x10);
        udelay(10);
        ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x20);
        udelay(10);
    }
    else {
        ar7240_reg_wr_nf(AR7240_DDR_CONFIG, ddr_config);
        udelay(100);
        ar7240_reg_wr_nf(AR7240_DDR_CONFIG2, ddr_config2);
        udelay(100);
        ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);
        udelay(10);
    }
#if 0
    ar7240_reg_wr_nf(AR7240_DDR_MODE, CFG_DDR_MODE_VAL_INIT);
    udelay(1000);
#endif
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);
    udelay(10);
    if ((ddr_type & 0x1) == 0)
        ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, ddr2_ext_mod);
    else
        ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, ext_mod);
#else
#ifdef PYTHON_DDR2
    ar7240_reg_wr_nf(0xb800008c, 0xA59);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x10);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x20);
    udelay(10);
#endif
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG, CFG_DDR_CONFIG_VAL);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG2, CFG_DDR_CONFIG2_VAL);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);
    udelay(10);
#if 0
    ar7240_reg_wr_nf(AR7240_DDR_MODE, CFG_DDR_MODE_VAL_INIT);
    udelay(1000);
#endif
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);
    udelay(10);
#ifdef PYTHON_DDR2
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, 0x402);
#else
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, CFG_DDR_EXT_MODE_VAL);
#endif

#endif
#endif /* #ifndef COMPRESSED_UBOOT */
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x2);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_MODE, CFG_DDR_MODE_VAL);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_REFRESH, refresh);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_RD_DATA_THIS_CYCLE,
                             CFG_DDR_RD_DATA_THIS_CYCLE_VAL);
    udelay(100);
}

void
ar7240_ddr_initial_config_for_fpga(void)
{
#ifdef CONFIG_HORNET_EMU
 #ifdef CONFIG_HORNET_EMU_HARDI
    /* HARDI FPGA board */
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x4);          /* Auto-Refresh */
    udelay(10);      
    ar7240_reg_wr_nf(AR7240_DDR_REFRESH, 0x4100);
    udelay(10);  
        
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG, 0x7fd68cd0);    /* Cas Latency 7 */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG2, 0x959ec6a8);   /* Gate Open 5 */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_DDR2_CONFIG, 0x858);    /* Disable DDR2, set Write Latency */
    udelay(10);    
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);          /* precharge all */
    udelay(10);       
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);          /* precharge all */
    udelay(10);       
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);          /* MR update */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_MODE, 0x133);           /* Mode Word Settings  */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, 0x0);         /* Extended Mode Word Settings */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_RD_DATA_THIS_CYCLE, 0xff);  /* DDR read data capture bit mask */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);          /* MR update */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x2);          /* EMR update */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);          /* precharge all */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);          /* precharge all */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x4);          /* Auto-Refresh */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x4);          /* Auto-Refresh */
    udelay(10);        
    ar7240_reg_wr_nf(AR7240_DDR_MODE, 0x133);           /* Mode Word Settings  */
    udelay(10);    
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);          /* MR update */    
    udelay(10); 
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, 0x382);       /* Extended Mode Word Settings */     
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x2);          /* EMR update */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, 0x402);       /* Extended Mode Word Settings */     
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x2);          /* EMR update */
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_MODE, 0x33);            /* Mode Word Settings  */
    udelay(10);    
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);          /* MR update */    
    udelay(10);
    #ifdef CONFIG_HORNET_EMU_HARDI_WLAN
    /* 
     * Emulation board reference clock is 48 MHz(20.833ns)
     * DDR request 64ms has 8192 refresh
     * So each refresh interval is 64ms/8192 = 7812.5 ns
     * i.e ddr have to refresh in 7812.5/20.833 = 375 = 0x177 clock cycles     
     */
    ar7240_reg_wr_nf(AR7240_DDR_REFRESH, 0x4177);
    #else
    /* 
     * Emulation board reference clock is 80 MHz(12.5ns)
     * DDR request 64ms has 8192 refresh
     * So each refresh interval is 64ms/8192 = 7812.5 ns
     * i.e ddr have to refresh in 7812.5/12.5 = 625 = 0x271 clock cycles
     */
    ar7240_reg_wr_nf(AR7240_DDR_REFRESH, 0x4271);
    #endif
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL0, 0x0);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL1, 0x0);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL2, 0x0);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_TAP_CONTROL3, 0x0);
    udelay(10);
 #else
    /* EBU FPGA board */
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG, 0xc7bc8cd0); /* Cas Latency 8 */
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONFIG2, 0x95d0e6a8); /* Gate Open 5 */
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_MODE, 0x123);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_EXT_MODE, 0x1);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x2);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x8);
    udelay(10);
    ar7240_reg_wr_nf(AR7240_DDR_MODE, 0x23);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_CONTROL, 0x1);
    udelay(10);
    /* 
     * Emulation board reference clock is 80 MHz(12.5ns)
     * DDR request 64ms has 8192 refresh
     * So each refresh interval is 64ms/8192 = 7812.5 ns
     * i.e ddr have to refresh in 7812.5/12.5 = 625 = 0x271 clock cycles     
     */
    ar7240_reg_wr_nf(AR7240_DDR_REFRESH, 0x4271);
    udelay(100);
    ar7240_reg_wr_nf(AR7240_DDR_RD_DATA_THIS_CYCLE, 0x00ff);
    udelay(100);
 #endif
#endif
}

