#include <common.h>
#include <command.h>
#include <asm/mipsregs.h>
#include <asm/addrspace.h>
#include <config.h>
#include <version.h>
#include "ar7240_soc.h"

extern void ar7240_ddr_initial_config(uint32_t refresh);
extern int ar7240_ddr_find_size(void);

#ifdef CONFIG_HORNET_EMU
extern void ar7240_ddr_initial_config_for_fpga(void);
#endif

void
ar7240_usb_initial_config(void)
{
#ifndef CONFIG_HORNET_EMU
    ar7240_reg_wr_nf(AR7240_USB_PLL_CONFIG, 0x0a04081e);
    ar7240_reg_wr_nf(AR7240_USB_PLL_CONFIG, 0x0804081e);
#endif
}

void ar7240_gpio_config(void)
{
    /* Disable clock obs */
    ar7240_reg_wr (AR7240_GPIO_FUNC, (ar7240_reg_rd(AR7240_GPIO_FUNC) & 0xffe7e0ff));
    /* Enable eth Switch LEDs */
    ar7240_reg_wr (AR7240_GPIO_FUNC, (ar7240_reg_rd(AR7240_GPIO_FUNC) | 0xf8));
}

int
ar7240_mem_config(void)
{
#ifndef COMPRESSED_UBOOT
    unsigned int tap_val1, tap_val2;
#endif
#ifdef CONFIG_HORNET_EMU
    ar7240_ddr_initial_config_for_fpga();
#else
    ar7240_ddr_initial_config(CFG_DDR_REFRESH_VAL);
#endif

/* Default tap values for starting the tap_init*/
#ifndef COMPRESSED_UBOOT
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL0, 0x8);
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL1, 0x9);
#else
#ifndef CONFIG_HORNET_EMU
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL0, 0x9);
    ar7240_reg_wr (AR7240_DDR_TAP_CONTROL1, 0xa);
#endif
#endif
    ar7240_gpio_config();

#ifndef COMPRESSED_UBOOT
#ifndef CONFIG_HORNET_EMU
    ar7240_ddr_tap_init();

    tap_val1 = ar7240_reg_rd(0xb800001c);
    tap_val2 = ar7240_reg_rd(0xb8000020);
    printf("#### TAP VALUE 1 = %x, 2 = %x\n",tap_val1, tap_val2);
#endif
#endif

    ar7240_usb_initial_config();

    return (ar7240_ddr_find_size());
}

long int initdram(int board_type)
{
    return (ar7240_mem_config());
}

#ifdef COMPRESSED_UBOOT
int checkboard (char *board_string)
{
    strcpy(board_string, "AP91 (ar7240) U-boot");
    return 0;
}
#else
int checkboard (void)
{
    printf("AP121-2MB (ar9330) U-boot\n");
    return 0;
}
#endif /* #ifdef COMPRESSED_UBOOT */
