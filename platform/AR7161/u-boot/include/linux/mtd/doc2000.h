
/* Linux driver for Disk-On-Chip 2000       */
/* (c) 1999 Machine Vision Holdings, Inc.   */
/* Author: David Woodhouse <dwmw2@mvhi.com> */
/* $Id: doc2000.h,v 1.2 2010/05/26 07:20:34 jackey Exp $ */

#ifndef __MTD_DOC2000_H__
#define __MTD_DOC2000_H__

struct DiskOnChip;

#include <linux/mtd/nftl.h>

#define DoC_Sig1 0
#define DoC_Sig2 1

#define DoC_ChipID		0x1000
#define DoC_DOCStatus		0x1001
#define DoC_DOCControl		0x1002
#define DoC_FloorSelect		0x1003
#define DoC_CDSNControl		0x1004
#define DoC_CDSNDeviceSelect 	0x1005
#define DoC_ECCConf 		0x1006
#define DoC_2k_ECCStatus	0x1007

#define DoC_CDSNSlowIO		0x100d
#define DoC_ECCSyndrome0	0x1010
#define DoC_ECCSyndrome1	0x1011
#define DoC_ECCSyndrome2	0x1012
#define DoC_ECCSyndrome3	0x1013
#define DoC_ECCSyndrome4	0x1014
#define DoC_ECCSyndrome5	0x1015
#define DoC_AliasResolution 	0x101b
#define DoC_ConfigInput		0x101c
#define DoC_ReadPipeInit 	0x101d
#define DoC_WritePipeTerm 	0x101e
#define DoC_LastDataRead 	0x101f
#define DoC_NOP 		0x1020

#define DoC_Mil_CDSN_IO 	0x0800
#define DoC_2k_CDSN_IO 		0x1800

#define ReadDOC_(adr, reg)      ((volatile unsigned char)(*(volatile __u8 *)(((unsigned long)adr)+((reg)))))
#define WriteDOC_(d, adr, reg)  do{ *(volatile __u8 *)(((unsigned long)adr)+((reg))) = (__u8)d; eieio();} while(0)

#define DOC_IOREMAP_LEN		0x4000

/* These are provided to directly use the DoC_xxx defines */
#define ReadDOC(adr, reg)      ReadDOC_(adr,DoC_##reg)
#define WriteDOC(d, adr, reg)  WriteDOC_(d,adr,DoC_##reg)

#define DOC_MODE_RESET 		0
#define DOC_MODE_NORMAL 	1
#define DOC_MODE_RESERVED1 	2
#define DOC_MODE_RESERVED2 	3

#define DOC_MODE_MDWREN 	4
#define DOC_MODE_CLR_ERR 	0x80

#define DOC_ChipID_UNKNOWN 	0x00
#define DOC_ChipID_Doc2k 	0x20
#define DOC_ChipID_DocMil 	0x30

#define CDSN_CTRL_FR_B 		0x80
#define CDSN_CTRL_ECC_IO 	0x20
#define CDSN_CTRL_FLASH_IO 	0x10
#define CDSN_CTRL_WP 		0x08
#define CDSN_CTRL_ALE 		0x04
#define CDSN_CTRL_CLE 		0x02
#define CDSN_CTRL_CE 		0x01

#define DOC_ECC_RESET 		0
#define DOC_ECC_ERROR 		0x80
#define DOC_ECC_RW 		0x20
#define DOC_ECC__EN 		0x08
#define DOC_TOGGLE_BIT 		0x04
#define DOC_ECC_RESV 		0x02
#define DOC_ECC_IGNORE		0x01

/* We have to also set the reserved bit 1 for enable */
#define DOC_ECC_EN (DOC_ECC__EN | DOC_ECC_RESV)
#define DOC_ECC_DIS (DOC_ECC_RESV)

#define MAX_FLOORS 4
#define MAX_CHIPS 4

#define MAX_FLOORS_MIL 4
#define MAX_CHIPS_MIL 1

#define ADDR_COLUMN 1
#define ADDR_PAGE 2
#define ADDR_COLUMN_PAGE 3

struct DiskOnChip {
	unsigned long physadr;
	unsigned long virtadr;
	unsigned long totlen;
	char* name;
	char ChipID; /* Type of DiskOnChip */
	int ioreg;

	char* chips_name;
	unsigned long mfr; /* Flash IDs - only one type of flash per device */
	unsigned long id;
	int chipshift;
	char page256;
	char pageadrlen;
	unsigned long erasesize;

	int curfloor;
	int curchip;

	int numchips;
	struct Nand *chips;

	int nftl_found;
	struct NFTLrecord nftl;
};

#define SECTORSIZE 512

/* Return codes from doc_write(), doc_read(), and doc_erase().
 */
#define DOC_OK		0
#define DOC_EIO		1
#define DOC_EINVAL	2
#define DOC_EECC	3
#define DOC_ETIMEOUT	4

/*
 * Function Prototypes
 */
int doc_decode_ecc(unsigned char sector[512], unsigned char ecc1[6]);

int doc_rw(struct DiskOnChip* this, int cmd, loff_t from, size_t len,
	   size_t *retlen, u_char *buf);
int doc_read_ecc(struct DiskOnChip* this, loff_t from, size_t len,
		 size_t *retlen, u_char *buf, u_char *eccbuf);
int doc_write_ecc(struct DiskOnChip* this, loff_t to, size_t len,
		  size_t *retlen, const u_char *buf, u_char *eccbuf);
int doc_read_oob(struct DiskOnChip* this, loff_t ofs, size_t len,
		 size_t *retlen, u_char *buf);
int doc_write_oob(struct DiskOnChip* this, loff_t ofs, size_t len,
		  size_t *retlen, const u_char *buf);
int doc_erase (struct DiskOnChip* this, loff_t ofs, size_t len);

void doc_probe(unsigned long physadr);

void doc_print(struct DiskOnChip*);

#endif /* __MTD_DOC2000_H__ */
