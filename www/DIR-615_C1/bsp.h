#ifndef __BSP_H__
#define __BSG_H__

#define HWID                    "AP81-AR9130-RT-070614-02"
#define HWCOUNTRYID             "00"//00:us/na, 01:others country
#define MAC_ID                  0x00, 0x63, 0x07, 0x08, 0x64, 0x09, 0x10, 0x00
#define MAC_ADDR		0xbfc004d0

#define DIAGNOSTIC_LED          1
#define DLINK_ROUTER_LED_DEFINE	1

//For kernel or u-boot
//#define AR7161  1
//#define AR7240    0
//#define AR7241    0
 
#define AP81  1
//#define AP83  0
//#define AP94    1
//#define AP98  0
//#define AP99  0
 
#define WPS_PUSH_BUTTON_GPIO    12
#define WPS_LED_GPIO            15
#define WPS_WSCCMD    //AP94 use WPATALK
 
#define RESET_BUTTON_GPIO   0x200000  //=> GPIO 21
#define BACKUP_ERASE_START_SECTOR   0
#define BACKUP_ERASE_END_SECTOR     0x3
#define NORMAL_ERASE_START_SECTOR   0x3
#define NORMAL_ERASE_END_SECTOR     0x3f

#endif //__BSP_H__
