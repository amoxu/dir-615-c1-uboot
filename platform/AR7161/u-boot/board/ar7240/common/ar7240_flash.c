#include <common.h>
#include <jffs2/jffs2.h>
#include <asm/addrspace.h>
#include <asm/types.h>
#include "ar7240_soc.h"
#include "ar7240_flash.h"

/*
 * globals
 */
flash_info_t flash_info[CFG_MAX_FLASH_BANKS];

#undef display
#define display(x)  ;

/*
 * statics
 */
static void ar7240_spi_write_enable(void);
static void ar7240_spi_poll(void);
#if !defined(ATH_SST_FLASH)
static void ar7240_spi_write_page(uint32_t addr, uint8_t *data, int len);
#endif
static void ar7240_spi_sector_erase(uint32_t addr);

static void
read_id(void)
{
    u32 rd = 0x777777;

    ar7240_reg_wr_nf(AR7240_SPI_WRITE, AR7240_SPI_CS_DIS);
    ar7240_spi_bit_banger(0x9f);
    ar7240_spi_delay_8();
    ar7240_spi_delay_8();
    ar7240_spi_delay_8();
    ar7240_spi_done(); 
    /* rd = ar7240_reg_rd(AR7240_SPI_RD_STATUS); */
    rd = ar7240_reg_rd(AR7240_SPI_READ); 
    printf("id read %#x\n", rd);
}


#ifdef ATH_SST_FLASH
void ar7240_spi_flash_unblock(void)
{
	ar7240_spi_write_enable();
	ar7240_spi_bit_banger(AR7240_SPI_CMD_WRITE_SR);
	ar7240_spi_bit_banger(0x0);
	ar7240_spi_go();
	ar7240_spi_poll();
}
#endif

unsigned long flash_init(void)
{

#ifdef ATH_SST_FLASH
	ar7240_reg_wr_nf(AR7240_SPI_CLOCK, 0x3);
	ar7240_spi_flash_unblock();
	ar7240_reg_wr(AR7240_SPI_FS, 0);
#else
    ar7240_reg_wr_nf(AR7240_SPI_CLOCK, 0x43);
#endif
    read_id();

    /*
     * hook into board specific code to fill flash_info
     */
    return (flash_get_geom(&flash_info[0]));
}

void
flash_print_info(flash_info_t *info)
{
    printf("The hell do you want flinfo for??\n");
}

int
flash_erase(flash_info_t *info, int s_first, int s_last)
{
    int i, sector_size = info->size/info->sector_count;

    printf("\nFirst %#x last %#x sector size %#x\n",
           s_first, s_last, sector_size);

    for (i = s_first; i <= s_last; i++) {
        printf("\b\b\b\b%4d", i);
        ar7240_spi_sector_erase(i * sector_size);
    }
    ar7240_spi_done();
    printf("\n");

    return 0;
}

int 
flash_erase_t(int sector_size, int s_first, int s_last)
{
    int i = s_first;
    printf("First %#x last %#x\n", s_first, s_last);
    for (i = s_first; i <= s_last; i++) {
    	printf("\b\b\b\b%4d", i);
	ar7240_spi_sector_erase(i * sector_size);
    }
    ar7240_spi_done();
    return 0;
}


/*
 * Write a buffer from memory to flash:
 * 0. Assumption: Caller has already erased the appropriate sectors.
 * 1. call page programming for every 256 bytes
 */
#ifdef ATH_SST_FLASH
void
ar7240_spi_flash_chip_erase(void)
{
	ar7240_spi_write_enable();
	ar7240_spi_bit_banger(AR7240_SPI_CMD_CHIP_ERASE);
	ar7240_spi_go();
	ar7240_spi_poll();
}

int
write_buff(flash_info_t *info, uchar *src, ulong dst, ulong len)
{
	uint32_t val;

	dst = dst - CFG_FLASH_BASE;
	printf("write len: %lu dst: 0x%x src: %p\n", len, dst, src);

	for (; len; len--, dst++, src++) {
		ar7240_spi_write_enable();	// dont move this above 'for'
		ar7240_spi_bit_banger(AR7240_SPI_CMD_PAGE_PROG);
		ar7240_spi_send_addr(dst);

		val = *src & 0xff;
		ar7240_spi_bit_banger(val);

		ar7240_spi_go();
		ar7240_spi_poll();
	}
/*
	 * Disable the Function Select
	 * Without this we can't read from the chip again
 */
	ar7240_reg_wr(AR7240_SPI_FS, 0);

	if (len) {
		// how to differentiate errors ??
		return ERR_PROG_ERROR;
	} else {
		return ERR_OK;
	}
}
#else
int 
write_buff(flash_info_t *info, uchar *source, ulong addr, ulong len)
{
    int total = 0, len_this_lp, bytes_this_page;
    ulong dst;
    uchar *src;
    
    printf ("write addr: %x\n", addr); 
    addr = addr - CFG_FLASH_BASE;

    while(total < len) {
        src              = source + total;
        dst              = addr   + total;
		bytes_this_page =
		    AR7240_SPI_PAGE_SIZE - (addr % AR7240_SPI_PAGE_SIZE);
		len_this_lp =
		    ((len - total) >
		     bytes_this_page) ? bytes_this_page : (len - total);
        ar7240_spi_write_page(dst, src, len_this_lp);
        total += len_this_lp;
    }

    ar7240_spi_done();

    return 0;
}
#endif

static void
ar7240_spi_write_enable()  
{
    ar7240_reg_wr_nf(AR7240_SPI_FS, 1);                  
    ar7240_reg_wr_nf(AR7240_SPI_WRITE, AR7240_SPI_CS_DIS);     
    ar7240_spi_bit_banger(AR7240_SPI_CMD_WREN);             
    ar7240_spi_go();
}

static void
ar7240_spi_poll()   
{
    int rd;                                                 

    do {
        ar7240_reg_wr_nf(AR7240_SPI_WRITE, AR7240_SPI_CS_DIS);     
        ar7240_spi_bit_banger(AR7240_SPI_CMD_RD_STATUS);        
        ar7240_spi_delay_8();
        rd = (ar7240_reg_rd(AR7240_SPI_RD_STATUS) & 1);               
    }while(rd);
}

#if !defined(ATH_SST_FLASH)
static void
ar7240_spi_write_page(uint32_t addr, uint8_t *data, int len)
{
    int i;
    uint8_t ch;

    display(0x77);
    ar7240_spi_write_enable();
    ar7240_spi_bit_banger(AR7240_SPI_CMD_PAGE_PROG);
    ar7240_spi_send_addr(addr);

    for(i = 0; i < len; i++) {
        ch = *(data + i);
        ar7240_spi_bit_banger(ch);
    }

    ar7240_spi_go();
    display(0x66);
    ar7240_spi_poll();
    display(0x6d);
}
#endif

static void
ar7240_spi_sector_erase(uint32_t addr)
{
    ar7240_spi_write_enable();
    ar7240_spi_bit_banger(AR7240_SPI_CMD_SECTOR_ERASE);
    ar7240_spi_send_addr(addr);
    ar7240_spi_go();
    display(0x7d);
    ar7240_spi_poll();
}
