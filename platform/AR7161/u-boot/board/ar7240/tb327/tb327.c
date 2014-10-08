#include <common.h>
#include <command.h>
#include <asm/mipsregs.h>
#include <asm/addrspace.h>
#include <config.h>
#include <version.h>
#include "ar7240_soc.h"

extern void ar7240_ddr_initial_config(uint32_t refresh);
extern int ar7240_ddr_find_size(void);

void
ar7240_usb_initial_config(void)
{
    ar7240_reg_wr_nf(AR7240_USB_PLL_CONFIG, 0x0a04081e);
    ar7240_reg_wr_nf(AR7240_USB_PLL_CONFIG, 0x0804081e);
}

int
ar7240_mem_config(void)
{
#if 0
    ar7240_ddr_initial_config(CFG_DDR_REFRESH_VAL);

    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL0, 0xa);
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL1, 0xa);
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL2, 0x0);
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL3, 0x0);

    ar7240_usb_initial_config();
#endif

    return (ar7240_ddr_find_size());
}

long int initdram(int board_type)
{
    return (ar7240_mem_config());
}

int checkboard (void)
{

    printf("AP93 (ar7240) U-boot\n");
    return 0;
}
