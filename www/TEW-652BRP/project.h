#ifndef _PROJECT_H
#define _PROJECT_H

/* Project Setting */
/* from shvar.h */
#define SYS_KERNEL_START_ADDR		0xBF030000
#define SYS_KERNEL_MTDBLK               "/dev/mtdblock2"
#define SYS_KERNEL_MTD 			"/dev/mtd2"
#define IMG_LOWER_BOUND			3 * 1024 * 1024
#define IMG_UPPER_BOUND			4 * 1024 * 1024
#define FW_KERNEL_BUF_SIZE		0x100000 
#define SYS_ROOTFS_MTDBLK               "/dev/mtdblock3"
#define SYS_ROOTFS_MTD                  "/dev/mtd3"
#define FW_ROOTFS_BUF_SIZE		0x2B0000 
#define FW_BUF_SIZE			FW_KERNEL_BUF_SIZE + FW_ROOTFS_BUF_SIZE
#define SYS_CAL_MTDBLK    "/dev/mtdblock4"
#define SYS_CAL_MTD 			"/dev/mtd4"
#define FW_CAL_BUF_SIZE			0x20000 
#define CAL_UPGRADE_ADDR		0xbf3e0000
#define ATH_MAC_OFFSET  		0x1120c 
#define SYS_BOOT_MTDBLK			"/dev/mtdblock0"
#define SYS_BOOT_MTD 			"/dev/mtd0"
#define BOOT_IMG_LOWER_BOUND	100 * 1024
#define BOOT_IMG_UPPER_BOUND	128 * 1024
#define BOOT_BUF_SIZE			0x20000 
#define SYS_BOOT_START_ADDR		0xBF000000
#define GPIO_DRIVER_PATH		"/lib/modules/2.6.15/net/gpio_mod.ko"
#define WPS_LED_GPIO_DRIVER_PATH "/lib/modules/2.6.15/net/ar531xgpio.o"
#define BOOT_HWID_ADDR_OFFSET 0x400

/* Wireless Setting, 
But DIR-615_C1 do not need these
Only for build process
*/
#define AP_SCAN_LIST			"/var/tmp/ap_scan_list"
#define MSG_ERROR_OPEN			"fail to open file"
#define CIPHER_AUTO				0
#define CIPHER_TKIP				1
#define CIPHER_AES				2
#define WPA_IE_TKIP				"000050f20201"
#define WPA_IE_AES				"000050f20401"
#define RSN_IE_TKIP				"00000fac0201"
#define RSN_IE_AES				"00000fac0401"
#define CIPHER_BEGIN_KEYWORD	"="
#define BUFFER_LENGTH 4096
#define WL_BAND_24G 0
#define WL_BAND_5G 1
#define ATH_BRIDGE "br_wds"
#define ATH_REPEATER "rpt_wds"

/* Project Setting, 
But DIR-615_C1 do not need these
Only for build process
*/
#define SYS_MAC_MTDBLK			"/dev/mtdblock4"
#define MAC_BUF_SIZE			64 * 1024

/* Wireless Domain and Channel Setting, */
/*Domain*/
#define MAX_GROUP           4
#define WIRELESS_BAND_24G   0
#define WIRELESS_BAND_50G   1
/* region domain */
#define DEBUG_REG_DMN   0x0000
#define NULL1           0xffff
/* for 2.4G */
#define APLD            0x0001
#define ETSIA           0x0002
#define ETSIB           0x0003
#define ETSIC           0x0004
#define FCCA            0x0005
#define MKKA            0x0006
#define MKKC            0x0007
#define WORLD           0x0008
/* for 5G */
#define APL1            0x1001
#define APL2            0x1002
#define APL3            0x1003
#define APL4            0x1004
#define APL5            0x1005
#define APL6            0x1006
#define ETSI1           0x1007
#define ETSI2           0x1008
#define ETSI3           0x1009
#define ETSI4           0x100A
#define ETSI5           0x100B
#define ETSI6           0x100C
#define FCC1            0x100D
#define FCC2            0x100E
#define FCC3            0x100F
#define MKK1            0x1010
#define MKK2            0x1011
#define APL9            0x1012
#define FCC6            0x1013

struct channel_list_s {
	unsigned short low_channel;   // Low Channel center in MHz
	unsigned short high_channel;  // High Channel center in MHz
};

struct freq_table_s {
	int regdomain_mode;
	int no_group;
	struct channel_list_s group[MAX_GROUP];
};

static struct freq_table_s wireless2_table[] = {
	{DEBUG_REG_DMN, 4,  {
				    {2312, 2372},      /* Channel -19 to -7 */
				    {2412, 2472},
				    {2484, 2484},
				    {2512, 2732}}},

	{APLD, 2,  {
			   {2312, 2372},        /* Negative Channels */
			   {2412, 2472},        /* Channel 1 - 13 */
			   {   0,    0},
			   {   0,    0}}},

	{ETSIA, 1,  {
			    {2457, 2472},        /* Channel 10 - 13 */
			    {   0,    0},
			    {   0,    0},
			    {   0,    0}}},

	{ETSIB, 1,  {
			    {2432, 2472},        /* Channel 5 - 13 */
			    {   0,    0},
			    {   0,    0},
			    {   0,    0}}},

	{ETSIC, 1, {
			   {2412, 2472},        /* Channel 1 - 13 */
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},

	{FCCA, 1, {
			  {2412, 2462},        /* Channel 1 - 11 */
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{MKKA, 2, {
			  {2412, 2472},        /* Channel 1 - 13 */
			  {2484, 2484},        /* Channel 14 */
			  {   0,    0},
			  {   0,    0}}},

	{MKKC, 1, {
			  {2412, 2472},        /* Channel 1 - 13 */
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{WORLD, 1, {
			   {2412, 2472},        /* Channel 1 - 13 */
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},    

	{NULL1, 1, {
			   {2412, 2472},        /* Channel 1 - 13 */
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},  
};

static struct freq_table_s wireless5_table[] = {
	{DEBUG_REG_DMN, 2, {
				   {5120, 5700},
				   {5745, 5825},
				   {   0,    0},
				   {   0,    0}}},

	{APL1, 1, {
			  {5745, 5825}, //CH 149, 153, 157, 161, 165
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{APL2, 1, {
			  {5745, 5805}, //CH 149, 153, 157, 161
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{APL3, 2, {
			  {5280, 5320}, //CH 56, 60, 64
			  {5745, 5805}, //CH 149, 153, 157, 161
			  {   0,    0},
			  {   0,    0}}},

	{APL4, 2, {
			  {5180, 5240},
			  {5745, 5825},
			  {   0,    0},
			  {   0,    0}}},

	{APL5, 2, {
			  {5745, 5825},
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{APL6, 2, {
			  {5180, 5320}, //CH 36, 40, 44, 48, 52, 56, 60, 64
			  {5745, 5825}, //CH 149, 153, 157, 161, 165
			  {   0,    0},
			  {   0,    0}}},
			  
	{APL9, 3, {
			  {5180, 5320}, //CH 36, 40, 44, 48, 52, 56, 60, 64
			  {5500, 5620}, //CH 100, 104, 108, 112, 116, 120, 124
			  {5745, 5805}, //CH 149, 153, 157, 161
			  {   0,    0}}},		  
	/*
	 * The ETSI1 domain requires TPC
	 * As the TPC specification are unfinished, 3dBi are
	 * removed from each of the ETSI1 power selections
	 */
	{ETSI1, 2, {
			   {5180, 5320},  // Should be 23 with TPC, CH 36, 40, 44, 48, 52, 56, 60, 64
			   {5500, 5700},  // Should be 30 with TPC, CH 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140
			   {   0,    0},
			   {   0,    0}}},

	{ETSI2, 1, {
			   {5180, 5240},
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},

	{ETSI3, 1, {
			   {5180, 5320},
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},

	{ETSI4, 1, {
			   {5180, 5320}, //36,40,44,48,52,56,60,64
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},

	{ETSI5, 1, {
			   {5180, 5240},
			   {   0,    0},
			   {   0,    0},
			   {   0,    0}}},

	{ETSI6, 2, {
			   {5180, 5280},
			   {5500, 5700},
			   {   0,    0},
			   {   0,    0}}},

	/*
	 * Values artificially decreased to meet FCC testing
	 * procedures
	 */
	{FCC1, 3, {
			  {5180, 5240},
			  {5260, 5320},
			  {5745, 5825},
			  {   0,    0}}},

	{FCC2, 2, {
			  {5180, 5320},
			  {5745, 5825},
			  {   0,    0},
			  {   0,    0}}},

	{FCC3, 4, {
			  {5180, 5240}, //CH 36, 40, 44, 48
			  {5260, 5320}, //CH 52, 56, 60, 64
			  {5500, 5700}, //CH 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140
			  {5745, 5825}}},//CH 149, 153, 157, 161, 165
	
	{FCC6, 4, {
			  {5180, 5320}, //CH 36, 40, 44, 48, 52, 56, 60, 64
			  {5500, 5580}, //CH 100, 104, 108, 112, 116, 
			  {5660, 5700}, //CH 132, 136, 140
			  {5745, 5825}}},//CH 149, 153, 157, 161, 165		  

	{MKK1, 1, {
			  //{5170, 5230},// preJP
			  {5180, 5320},  // newJP
			  {   0,    0},
			  {   0,    0},
			  {   0,    0}}},

	{MKK2, 3, {
			  {4920, 4980},
			  {5040, 5080},
			  {5170, 5230},
			  {   0,    0}}},    

	{NULL1, 3, {          /* FCC1 */
			   {5180, 5240},
			   {5260, 5320},
			   {5745, 5825},
			   {   0,    0}}}, 

};

struct domain_name_s {
	int  number;
	char name[20];
	int  wireless2_freq_table;
	int  wireless5_freq_table;
};

static struct domain_name_s  domain_name[] = {
	{0x00,     "NO_ENUMRD",     NULL1,  NULL1  },
	{0x03,     "NULL1_WORLD",   WORLD,  NULL1},         /* For 11b-only countries (no 11a allowed) */
	{0x07,     "NULL1_ETSIB",   ETSIB,  NULL1},         /* Israel */
	{0x08,     "NULL1_ETSIC",   ETSIC,  NULL1},
	{0x10,     "FCC1_FCCA",     FCCA,   FCC1},          // USA
	{0x11,     "FCC1_WORLD",    WORLD,  FCC1},          // Hong Kong 
	{0x14,	   "FCC6_FCCA",		FCCA,	FCC6},	//CTRY_CANADA2                                                          
	{0x20,     "FCC2_FCCA",     FCCA,   FCC2},          // Canada                                                             
	{0x21,     "FCC2_WORLD",    WORLD,  FCC2},          // Australia                                                          
	{0x22,     "FCC2_ETSIC",    ETSIC,  FCC2},   
	{0x23,     "FCC6_WORLD",    WORLD,  FCC6},	//CTRY_AUSTRALIA2                                                                       
	{0x31,     "FRANCE_RES",    WORLD,  ETSI3},         // Legacy France for OEM                                              
	{0x3A,     "FCC3_FCCA",		FCCA,	FCC3},          // USA & Canada w/5470 band, 11h, DFS enabled  //CTRY_UNITED_STATES                       
	{0x37,     "ETSI1_WORLD",   WORLD,  ETSI1},          //CTRY_GERMANY                                                               
	{0x32,     "ETSI3_ETSIA",   WORLD,  ETSI3},         // France (optional)                                                  
	{0x35,     "ETSI2_WORLD",   WORLD,  ETSI2},         // Hungary & others                                                   
	{0x36,     "ETSI3_WORLD",   WORLD,  ETSI3},         // France & others                                                    
	{0x30,     "ETSI4_WORLD",   WORLD,  ETSI4},                                                                         
	{0x38,     "ETSI4_ETSIC",   ETSIC,  ETSI4},                                                                         
	{0x39,     "ETSI5_WORLD",   WORLD,  ETSI5},                                                                         
	{0x34,     "ETSI6_WORLD",   WORLD,  ETSI6},         // Bulgaria                                                           
	{0x33,     "ETSI_RESERVED", NULL1,  NULL1},         // Reserved (Do not used)                                             
	{0x40,     "MKK1_MKKA",     MKKA,   MKK1},          // Japan (JP1)                                                        
	{0x41,     "MKK1_MKKB",     MKKA,   MKK1},          // Japan (JP0)                                                        
	{0x42,     "APL4_WORLD",    WORLD,  APL4},          // Jordon                                                             
	{0x43,     "MKK2_MKKA",     MKKA,   MKK2},          // Japan with 4.9G channels                                           
	{0x44,     "APL_RESERVED",  NULL1,  NULL1},         // Reserved (Do not used)                                             
	{0x45,     "APL2_WORLD",    WORLD,  APL2},          // Korea                                                              
	{0x46,     "APL2_APLC",     NULL1,  APL2},                                                                           
	{0x47,     "APL3_WORLD",    WORLD,  APL3},                                                                          
	{0x48,     "MKK1_FCCA",     FCCA,   MKK1},          // Japan (JP1-1)                                                      
	{0x49,     "APL2_APLD",     APLD,   APL2},          // Korea with 2.3G channels  
	{0x50,     "APL3_FCCA",		FCCA,	APL3},	//CTRY_TAIWAN  
	{0x51,     "APL2_FCCA",		FCCA,	APL2},	//CTRY_CHILE 
	{0x5E,     "APL9_WORLD",    WORLD,  APL9},	//CTRY_KOREA_NORTH                                         
	{0x4A,     "MKK1_MKKA1",    MKKA,   MKK1},          // Japan (JE1)                                                        
	{0x4B,     "MKK1_MKKA2",    MKKA,   MKK1},          // Japan (JE2)                                                        
	{0x4C,     "MKK1_MKKC",     MKKC,   MKK1},          // Japan (MKK1_MKKA,except Ch14)                                      
	{0x52,     "APL1_WORLD",    WORLD,  APL1},          // Latin America //CTRY_CHINA                                                     
	{0x53,     "APL1_FCCA",     FCCA,   APL1},                                                                           
	{0x54,     "APL1_APLA",     NULL1,  APL1},                                                                           
	{0x55,     "APL1_ETSIC",    ETSIC,  APL1},                                                                          
	{0x56,     "APL2_ETSIC",    ETSIC,  APL2},          // Venezuala                                                          
	{0x58,     "APL5_WORLD",    WORLD,  APL5},          // Chile                                                              
	{0x5B,     "APL6_WORLD",    WORLD,  APL6},          // Singapore  //CTRY_INDIA                                                        
	{0xffff,   "unknow",        NULL1,  NULL1}
};

/*  Date: 2009-2-17
*   Name: Ken Chiang
*   Reason: added to change wireless region from show Domain name to Country name for version.txt.
*   Notice :
*/
struct country_name_s {
	int  number;
	char name[10];	
};

static struct country_name_s  country_name[] = {
	{0x10,     "US/NA"},//FCC1_FCCA
	{0x14,	   "CA"},	        //FCC6_FCCA
	{0x20,	   "CA"},	//FCC2_FCCA   
	{0x23,     "AU"},			//FCC6_WORLD                                             
	{0x30,     "EU"},	//ETSI4_WORLD
	{0x31,     "SP"},   //FRANCE_RES        
	{0x32,     "FR"},	//ETSI3_ETSIA 
	{0x37,     "EU"},	        //ETSI1_WORLD  
	{0x3A,     "US/NA"},	    //FCC3_FCCA                                                              
	{0x40,     "JP"},	//MKK1_MKKA 
	{0x41,     "JP"},	//MKK1_MKKB    
	{0x50,     "TW"},	        //APL3_FCCA  
    {0x51,     "LA"},	        //APL2_FCCA                                                               
	{0x52,     "CN"},	        //APL1_WORLD                                                                                                             
	{0x5B,     "SG"},	        //APL6_WORLD (INDIA) 
	{0x5E,     "KR"},			//APL9_WORLD                                                           
	{0xffff,   "unknow"}
};

struct region_s{
	char *name;
	int number;
};

static struct region_s region[] = {
	{"Africa",				0x37},
	{"Asia",					0x52},
	{"Australia",			0x21},
	{"Canada",				0x20},
	{"Europe",				0xffff},   //can't find
	{"France",				0x36},
	{"Israel",				0x07},
	{"Japan",					0x40},
	{"Maxico",				0x10},
	{"South America",	0xffff},   //can't find
	{"United States",	0x10}
};


/* For rc insert switch module */ 
#define SWITCH_MOD_OPT_WAN_SPEED	"wan_speed="
#define SWITCH_MODUE_FILE		"/lib/modules/2.6.15/net/ag7100_mod.ko"

#endif //#ifndef _PROJECT_H
