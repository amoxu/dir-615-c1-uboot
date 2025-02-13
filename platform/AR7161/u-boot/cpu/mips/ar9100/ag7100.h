#ifndef _AG7100_H
#define _AG7100_H

#include <linux/types.h>

/*
 * h/w descriptor
 */
typedef struct {
    uint32_t    pkt_start_addr;

    uint32_t    is_empty       :  1;
    uint32_t    res1           : 10;
    uint32_t    ftpp_override  :  5;
    uint32_t    res2           :  4;
    uint32_t    pkt_size       : 12;

    uint32_t    next_desc      ;
}ag7100_desc_t;

#define NO_OF_TX_FIFOS  8
#define NO_OF_RX_FIFOS  8

#ifdef USE_TWO_MII//two mii
typedef struct {
    ag7100_desc_t *fifo_tx[NO_OF_TX_FIFOS];
    ag7100_desc_t *fifo_rx[NO_OF_RX_FIFOS];
    struct eth_device *dev;
    u32            next_tx;
    u32            next_rx;
    u32            link;
    u32            duplex;
    u32            speed;
    u32		   mac_unit;
    u32 	   mac_base;
}ag7100_mac_t;

#define ag7100_reg_wr(_mac, _x, _y)   ar7100_reg_wr(((_x) + _mac->mac_base), (_y))
#define ag7100_reg_rd(_mac, _x)       ar7100_reg_rd(((_x) + _mac->mac_base))

#define ag7100_reg_rmw_set(_mac, _x, _y)   \
    ar7100_reg_rmw_set(((_x) + _mac->mac_base ), (_y))
#define ag7100_reg_rmw_clear(_mac, _x, _y)    \
    ar7100_reg_rmw_clear(((_x) + _mac->mac_base), (_y))

/*
 * spd is _1000BASET, _100BASET etc. defined in include/miiphy.h
 */
#define mii_reg(_mac)   (AR7100_MII0_CTRL + ((_mac)->mac_unit * 4))
#define mii_if(_mac)    (((_mac)->mac_unit == 0) ? mii0_if : mii1_if)

#define ag7100_set_mii_ctrl_speed(_mac, _spd)   do {                        \
    ar7100_reg_rmw_clear(mii_reg(_mac), (3 << 4));                          \
    ar7100_reg_rmw_set(mii_reg(_mac), ((_spd) << 4));                       \
}while(0);
#else//two mii
typedef struct {
    ag7100_desc_t *fifo_tx[NO_OF_TX_FIFOS];
    ag7100_desc_t *fifo_rx[NO_OF_RX_FIFOS];
    u32            next_tx;
    u32            next_rx;
    u32            link;
    u32            duplex;
    u32            speed;
}ag7100_mac_t;

#define ag7100_reg_wr(_x, _y)   ar7100_reg_wr(((_x) + AR7100_GE0_BASE), (_y))
#define ag7100_reg_rd(_x)       ar7100_reg_rd(((_x) + AR7100_GE0_BASE))

#define ag7100_reg_rmw_set(_x, _y)   \
    ar7100_reg_rmw_set(((_x) + AR7100_GE0_BASE), (_y))
#define ag7100_reg_rmw_clear(_x, _y)    \
    ar7100_reg_rmw_clear(((_x) + AR7100_GE0_BASE), (_y))

/*
 * spd is _1000BASET, _100BASET etc. defined in include/miiphy.h
 */
#define ag7100_set_mii_ctrl_speed(_spd)   do {                        \
    ar7100_reg_rmw_clear(AR7100_MII0_CTRL, (3 << 4));                 \
    ar7100_reg_rmw_set(AR7100_MII0_CTRL, (((_spd) >> 2) << 4));       \
}while(0);
#endif//#ifdef USE_TWO_MII

#if defined (CFG_MII0_GMII)
#define ag7100_get_mii_if()             0
#elif defined (CFG_MII0_MII)
#define ag7100_get_mii_if()             0
#elif defined (CFG_MII0_RGMII)
#define ag7100_get_mii_if()             0
#elif defined (CFG_MII0_RMII)
#define ag7100_get_mii_if()             0
#endif
        
#define MAX_WAIT        1000

/*
 * Config/Mac Register definitions
 */
#define AG7100_MAC_CFG1             0x00
#define AG7100_MAC_CFG2             0x04
#define AG7100_MAC_IFCTL            0x38

/*
 * fifo control registers
 */
#define AG7100_MAC_FIFO_CFG_0      0x48
#define AG7100_MAC_FIFO_CFG_1      0x4c
#define AG7100_MAC_FIFO_CFG_2      0x50
#define AG7100_MAC_FIFO_CFG_3      0x54
#define AG7100_MAC_FIFO_CFG_4      0x58

#define AG7100_MAC_FIFO_CFG_5      0x5c
#define AG7100_BYTE_PER_CLK_EN     (1 << 19)

#define AG7100_MAC_FIFO_RAM_0      0x60
#define AG7100_MAC_FIFO_RAM_1      0x64
#define AG7100_MAC_FIFO_RAM_2      0x68
#define AG7100_MAC_FIFO_RAM_3      0x6c
#define AG7100_MAC_FIFO_RAM_4      0x70
#define AG7100_MAC_FIFO_RAM_5      0x74
#define AG7100_MAC_FIFO_RAM_6      0x78
#define AG7100_MAC_FIFO_RAM_7      0x7c

/*
 * fields
 */
#define AG7100_MAC_CFG1_SOFT_RST       (1 << 31)
#define AG7100_MAC_CFG1_LOOPBACK       (1 << 8)
#define AG7100_MAC_CFG1_RX_EN          (1 << 2)
#define AG7100_MAC_CFG1_TX_EN          (1 << 0)

#define AG7100_MAC_CFG2_FDX            (1 << 0)
#define AG7100_MAC_CFG2_PAD_CRC_EN     (1 << 2)
#define AG7100_MAC_CFG2_LEN_CHECK      (1 << 4)
#define AG7100_MAC_CFG2_HUGE_FRAME_EN  (1 << 5)
#define AG7100_MAC_CFG2_IF_1000        (1 << 9)
#define AG7100_MAC_CFG2_IF_10_100      (1 << 8)

#define AG7100_MAC_IFCTL_SPEED         (1 << 16)

/*
 * DMA (tx/rx) register defines
 */
#define AG7100_DMA_TX_CTRL              0x180
#define AG7100_DMA_TX_DESC              0x184
#define AG7100_DMA_TX_STATUS            0x188
#define AG7100_DMA_RX_CTRL              0x18c
#define AG7100_DMA_RX_DESC              0x190
#define AG7100_DMA_RX_STATUS            0x194
#define AG7100_DMA_INTR_MASK            0x198
#define AG7100_DMA_INTR                 0x19c

/*
 * tx/rx ctrl and status bits
 */
#define AG7100_TXE                      (1 << 0)
#define AG7100_TX_STATUS_PKTCNT_SHIFT   16
#define AG7100_TX_STATUS_PKT_SENT       0x1
#define AG7100_TX_STATUS_URN            0x2
#define AG7100_TX_STATUS_BUS_ERROR      0x8

#define AG7100_RXE                      (1 << 0)

#define AG7100_RX_STATUS_PKTCNT_MASK    0xff0000
#define AG7100_RX_STATUS_PKT_RCVD       (1 << 0)
#define AG7100_RX_STATUS_OVF            (1 << 2)
#define AG7100_RX_STATUS_BUS_ERROR      (1 << 3)

/*
 * Int and int mask
 */
#define AG7100_INTR_TX                  (1 << 0)
#define AG7100_INTR_TX_URN              (1 << 1)
#define AG7100_INTR_TX_BUS_ERROR        (1 << 3)
#define AG7100_INTR_RX                  (1 << 4)
#define AG7100_INTR_RX_OVF              (1 << 6)
#define AG7100_INTR_RX_BUS_ERROR        (1 << 7)

/*
 * MII registers
 */
#define AG7100_MAC_MII_MGMT_CFG         0x20
#define AG7100_MGMT_CFG_CLK_DIV_20      0x06

#define AG7100_MII_MGMT_CMD             0x24
#define AG7100_MGMT_CMD_READ            0x1

#define AG7100_MII_MGMT_ADDRESS         0x28
#define AG7100_ADDR_SHIFT               8

#define AG7100_MII_MGMT_CTRL            0x2c
#define AG7100_MII_MGMT_STATUS          0x30

#define AG7100_MII_MGMT_IND             0x34
#define AG7100_MGMT_IND_BUSY            (1 << 0)
#define AG7100_MGMT_IND_INVALID         (1 << 2)

#define AG7100_GE_MAC_ADDR1             0x40
#define AG7100_GE_MAC_ADDR2             0x44

/*
 *  * ownership of descriptors between DMA and cpu
 *   */
#define ag7100_rx_owned_by_dma(_ds)     ((_ds)->is_empty == 1)
#define ag7100_rx_give_to_dma(_ds)      ((_ds)->is_empty = 1)
#define ag7100_tx_owned_by_dma(_ds)     ((_ds)->is_empty == 0)
#define ag7100_tx_give_to_dma(_ds)      ((_ds)->is_empty = 0)
#define ag7100_tx_own(_ds)              ((_ds)->is_empty = 1)

/*
 * link settings
 */
#ifdef USE_TWO_MII//two mii
#define ag7100_set_mac_duplex(_mac, _fdx)       do {                         \
    if ((_fdx))                                                              \
        ag7100_reg_rmw_set(_mac, AG7100_MAC_CFG2, AG7100_MAC_CFG2_FDX)     \
    else                                                                     \
        ag7100_reg_rmw_clear(_mac, AG7100_MAC_CFG2, AG7100_MAC_CFG2_FDX)   \
}while(0)

#define ag7100_set_mac_if(_mac, _isXGMII)    do {                              \
    ag7100_reg_rmw_clear(_mac, AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_1000|      \
                                          AG7100_MAC_CFG2_IF_10_100);   \
    if ((_isXGMII)) {                                            \
        ag7100_reg_rmw_set(_mac, AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_1000)  \
        ag7100_reg_rmw_set(_mac, AG7100_MAC_FIFO_CFG_5, AG7100_BYTE_PER_CLK_EN);\
    }                                                                       \
    else {                                                              \
        ag7100_reg_rmw_set(_mac, AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_10_100)\
        ag7100_reg_rmw_clear(_mac, AG7100_MAC_FIFO_CFG_5, AG7100_BYTE_PER_CLK_EN);\
    }                                                                       \
}while(0)

#define ag7100_set_mac_speed(_mac, _is100)   do {                             \
    if ((_is100))                                                             \
        ag7100_reg_rmw_set(_mac, AG7100_MAC_IFCTL, AG7100_MAC_IFCTL_SPEED)  \
    else                                                                      \
        ag7100_reg_rmw_clear(_mac, AG7100_MAC_IFCTL, AG7100_MAC_IFCTL_SPEED)\
}while(0)
#else//two mii
#define ag7100_set_mac_duplex(_fdx)       do {                         \
    if ((_fdx))                                                              \
        ag7100_reg_rmw_set(AG7100_MAC_CFG2, AG7100_MAC_CFG2_FDX)     \
    else                                                                     \
        ag7100_reg_rmw_clear(AG7100_MAC_CFG2, AG7100_MAC_CFG2_FDX)   \
}while(0)

#define ag7100_set_mac_if(_isXGMII)    do {                              \
    ag7100_reg_rmw_clear(AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_1000|      \
                                          AG7100_MAC_CFG2_IF_10_100);   \
    if ((_isXGMII)) {                                            \
        ag7100_reg_rmw_set(AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_1000)  \
        ag7100_reg_rmw_set(AG7100_MAC_FIFO_CFG_5, AG7100_BYTE_PER_CLK_EN);\
    }                                                                       \
    else {                                                              \
        ag7100_reg_rmw_set(AG7100_MAC_CFG2, AG7100_MAC_CFG2_IF_10_100)\
        ag7100_reg_rmw_clear(AG7100_MAC_FIFO_CFG_5, AG7100_BYTE_PER_CLK_EN);\
    }                                                                       \
}while(0)

#define ag7100_set_mac_speed(_is100)   do {                             \
    if ((_is100))                                                             \
        ag7100_reg_rmw_set(AG7100_MAC_IFCTL, AG7100_MAC_IFCTL_SPEED)  \
    else                                                                      \
        ag7100_reg_rmw_clear(AG7100_MAC_IFCTL, AG7100_MAC_IFCTL_SPEED)\
}while(0)
#endif//#ifdef USE_TWO_MII

#endif
