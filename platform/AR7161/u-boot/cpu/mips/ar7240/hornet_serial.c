#include <asm/addrspace.h>
#include <asm/types.h>
#include <config.h>
#include <ar7240_soc.h>


// 0x0000 (UARTDATA)
#define UARTDATA_UARTTXCSR_MSB                                       9
#define UARTDATA_UARTTXCSR_LSB                                       9
#define UARTDATA_UARTTXCSR_MASK                                      0x00000200
#define UARTDATA_UARTTXCSR_GET(x)                                    (((x) & UARTDATA_UARTTXCSR_MASK) >> UARTDATA_UARTTXCSR_LSB)
#define UARTDATA_UARTTXCSR_SET(x)                                    (((0 | (x)) << UARTDATA_UARTTXCSR_LSB) & UARTDATA_UARTTXCSR_MASK)
#define UARTDATA_UARTTXCSR_RESET                                     0
#define UARTDATA_UARTRXCSR_MSB                                       8
#define UARTDATA_UARTRXCSR_LSB                                       8
#define UARTDATA_UARTRXCSR_MASK                                      0x00000100
#define UARTDATA_UARTRXCSR_GET(x)                                    (((x) & UARTDATA_UARTRXCSR_MASK) >> UARTDATA_UARTRXCSR_LSB)
#define UARTDATA_UARTRXCSR_SET(x)                                    (((0 | (x)) << UARTDATA_UARTRXCSR_LSB) & UARTDATA_UARTRXCSR_MASK)
#define UARTDATA_UARTRXCSR_RESET                                     0
#define UARTDATA_UARTTXRXDATA_MSB                                    7
#define UARTDATA_UARTTXRXDATA_LSB                                    0
#define UARTDATA_UARTTXRXDATA_MASK                                   0x000000ff
#define UARTDATA_UARTTXRXDATA_GET(x)                                 (((x) & UARTDATA_UARTTXRXDATA_MASK) >> UARTDATA_UARTTXRXDATA_LSB)
#define UARTDATA_UARTTXRXDATA_SET(x)                                 (((0 | (x)) << UARTDATA_UARTTXRXDATA_LSB) & UARTDATA_UARTTXRXDATA_MASK)
#define UARTDATA_UARTTXRXDATA_RESET                                  0
#define UARTDATA_ADDRESS                                             0x0000
#define UARTDATA_HW_MASK                                             0x000003ff
#define UARTDATA_SW_MASK                                             0x000003ff
#define UARTDATA_RSTMASK                                             0x000003ff
#define UARTDATA_RESET                                               0x00000000

// 0x0004 (UARTCS)
#define UARTCS_UARTRXBUSY_MSB                                        15
#define UARTCS_UARTRXBUSY_LSB                                        15
#define UARTCS_UARTRXBUSY_MASK                                       0x00008000
#define UARTCS_UARTRXBUSY_GET(x)                                     (((x) & UARTCS_UARTRXBUSY_MASK) >> UARTCS_UARTRXBUSY_LSB)
#define UARTCS_UARTRXBUSY_SET(x)                                     (((0 | (x)) << UARTCS_UARTRXBUSY_LSB) & UARTCS_UARTRXBUSY_MASK)
#define UARTCS_UARTRXBUSY_RESET                                      0
#define UARTCS_UARTTXBUSY_MSB                                        14
#define UARTCS_UARTTXBUSY_LSB                                        14
#define UARTCS_UARTTXBUSY_MASK                                       0x00004000
#define UARTCS_UARTTXBUSY_GET(x)                                     (((x) & UARTCS_UARTTXBUSY_MASK) >> UARTCS_UARTTXBUSY_LSB)
#define UARTCS_UARTTXBUSY_SET(x)                                     (((0 | (x)) << UARTCS_UARTTXBUSY_LSB) & UARTCS_UARTTXBUSY_MASK)
#define UARTCS_UARTTXBUSY_RESET                                      0
#define UARTCS_UARTHOSTINTEN_MSB                                     13
#define UARTCS_UARTHOSTINTEN_LSB                                     13
#define UARTCS_UARTHOSTINTEN_MASK                                    0x00002000
#define UARTCS_UARTHOSTINTEN_GET(x)                                  (((x) & UARTCS_UARTHOSTINTEN_MASK) >> UARTCS_UARTHOSTINTEN_LSB)
#define UARTCS_UARTHOSTINTEN_SET(x)                                  (((0 | (x)) << UARTCS_UARTHOSTINTEN_LSB) & UARTCS_UARTHOSTINTEN_MASK)
#define UARTCS_UARTHOSTINTEN_RESET                                   0
#define UARTCS_UARTHOSTINT_MSB                                       12
#define UARTCS_UARTHOSTINT_LSB                                       12
#define UARTCS_UARTHOSTINT_MASK                                      0x00001000
#define UARTCS_UARTHOSTINT_GET(x)                                    (((x) & UARTCS_UARTHOSTINT_MASK) >> UARTCS_UARTHOSTINT_LSB)
#define UARTCS_UARTHOSTINT_SET(x)                                    (((0 | (x)) << UARTCS_UARTHOSTINT_LSB) & UARTCS_UARTHOSTINT_MASK)
#define UARTCS_UARTHOSTINT_RESET                                     0
#define UARTCS_UARTTXBREAK_MSB                                       11
#define UARTCS_UARTTXBREAK_LSB                                       11
#define UARTCS_UARTTXBREAK_MASK                                      0x00000800
#define UARTCS_UARTTXBREAK_GET(x)                                    (((x) & UARTCS_UARTTXBREAK_MASK) >> UARTCS_UARTTXBREAK_LSB)
#define UARTCS_UARTTXBREAK_SET(x)                                    (((0 | (x)) << UARTCS_UARTTXBREAK_LSB) & UARTCS_UARTTXBREAK_MASK)
#define UARTCS_UARTTXBREAK_RESET                                     0
#define UARTCS_UARTRXBREAK_MSB                                       10
#define UARTCS_UARTRXBREAK_LSB                                       10
#define UARTCS_UARTRXBREAK_MASK                                      0x00000400
#define UARTCS_UARTRXBREAK_GET(x)                                    (((x) & UARTCS_UARTRXBREAK_MASK) >> UARTCS_UARTRXBREAK_LSB)
#define UARTCS_UARTRXBREAK_SET(x)                                    (((0 | (x)) << UARTCS_UARTRXBREAK_LSB) & UARTCS_UARTRXBREAK_MASK)
#define UARTCS_UARTRXBREAK_RESET                                     0
#define UARTCS_UARTSERIATXREADY_MSB                                  9
#define UARTCS_UARTSERIATXREADY_LSB                                  9
#define UARTCS_UARTSERIATXREADY_MASK                                 0x00000200
#define UARTCS_UARTSERIATXREADY_GET(x)                               (((x) & UARTCS_UARTSERIATXREADY_MASK) >> UARTCS_UARTSERIATXREADY_LSB)
#define UARTCS_UARTSERIATXREADY_SET(x)                               (((0 | (x)) << UARTCS_UARTSERIATXREADY_LSB) & UARTCS_UARTSERIATXREADY_MASK)
#define UARTCS_UARTSERIATXREADY_RESET                                0
#define UARTCS_UARTTXREADYORIDE_MSB                                  8
#define UARTCS_UARTTXREADYORIDE_LSB                                  8
#define UARTCS_UARTTXREADYORIDE_MASK                                 0x00000100
#define UARTCS_UARTTXREADYORIDE_GET(x)                               (((x) & UARTCS_UARTTXREADYORIDE_MASK) >> UARTCS_UARTTXREADYORIDE_LSB)
#define UARTCS_UARTTXREADYORIDE_SET(x)                               (((0 | (x)) << UARTCS_UARTTXREADYORIDE_LSB) & UARTCS_UARTTXREADYORIDE_MASK)
#define UARTCS_UARTTXREADYORIDE_RESET                                0
#define UARTCS_UARTRXREADYORIDE_MSB                                  7
#define UARTCS_UARTRXREADYORIDE_LSB                                  7
#define UARTCS_UARTRXREADYORIDE_MASK                                 0x00000080
#define UARTCS_UARTRXREADYORIDE_GET(x)                               (((x) & UARTCS_UARTRXREADYORIDE_MASK) >> UARTCS_UARTRXREADYORIDE_LSB)
#define UARTCS_UARTRXREADYORIDE_SET(x)                               (((0 | (x)) << UARTCS_UARTRXREADYORIDE_LSB) & UARTCS_UARTRXREADYORIDE_MASK)
#define UARTCS_UARTRXREADYORIDE_RESET                                0
#define UARTCS_UARTDMAEN_MSB                                         6
#define UARTCS_UARTDMAEN_LSB                                         6
#define UARTCS_UARTDMAEN_MASK                                        0x00000040
#define UARTCS_UARTDMAEN_GET(x)                                      (((x) & UARTCS_UARTDMAEN_MASK) >> UARTCS_UARTDMAEN_LSB)
#define UARTCS_UARTDMAEN_SET(x)                                      (((0 | (x)) << UARTCS_UARTDMAEN_LSB) & UARTCS_UARTDMAEN_MASK)
#define UARTCS_UARTDMAEN_RESET                                       0
#define UARTCS_UARTFLOWCONTROLMODE_MSB                               5
#define UARTCS_UARTFLOWCONTROLMODE_LSB                               4
#define UARTCS_UARTFLOWCONTROLMODE_MASK                              0x00000030
#define UARTCS_UARTFLOWCONTROLMODE_GET(x)                            (((x) & UARTCS_UARTFLOWCONTROLMODE_MASK) >> UARTCS_UARTFLOWCONTROLMODE_LSB)
#define UARTCS_UARTFLOWCONTROLMODE_SET(x)                            (((0 | (x)) << UARTCS_UARTFLOWCONTROLMODE_LSB) & UARTCS_UARTFLOWCONTROLMODE_MASK)
#define UARTCS_UARTFLOWCONTROLMODE_RESET                             0
#define UARTCS_UARTINTERFACEMODE_MSB                                 3
#define UARTCS_UARTINTERFACEMODE_LSB                                 2
#define UARTCS_UARTINTERFACEMODE_MASK                                0x0000000c
#define UARTCS_UARTINTERFACEMODE_GET(x)                              (((x) & UARTCS_UARTINTERFACEMODE_MASK) >> UARTCS_UARTINTERFACEMODE_LSB)
#define UARTCS_UARTINTERFACEMODE_SET(x)                              (((0 | (x)) << UARTCS_UARTINTERFACEMODE_LSB) & UARTCS_UARTINTERFACEMODE_MASK)
#define UARTCS_UARTINTERFACEMODE_RESET                               0
#define UARTCS_UARTPARITYMODE_MSB                                    1
#define UARTCS_UARTPARITYMODE_LSB                                    0
#define UARTCS_UARTPARITYMODE_MASK                                   0x00000003
#define UARTCS_UARTPARITYMODE_GET(x)                                 (((x) & UARTCS_UARTPARITYMODE_MASK) >> UARTCS_UARTPARITYMODE_LSB)
#define UARTCS_UARTPARITYMODE_SET(x)                                 (((0 | (x)) << UARTCS_UARTPARITYMODE_LSB) & UARTCS_UARTPARITYMODE_MASK)
#define UARTCS_UARTPARITYMODE_RESET                                  0
#define UARTCS_ADDRESS                                               0x0004
#define UARTCS_HW_MASK                                               0x0000ffff
#define UARTCS_SW_MASK                                               0x0000ffff
#define UARTCS_RSTMASK                                               0x000029ff
#define UARTCS_RESET                                                 0x00000000

// 0x0008 (UARTCLOCK)
#define UARTCLOCK_UARTCLOCKSCALE_MSB                                 23
#define UARTCLOCK_UARTCLOCKSCALE_LSB                                 16
#define UARTCLOCK_UARTCLOCKSCALE_MASK                                0x00ff0000
#define UARTCLOCK_UARTCLOCKSCALE_GET(x)                              (((x) & UARTCLOCK_UARTCLOCKSCALE_MASK) >> UARTCLOCK_UARTCLOCKSCALE_LSB)
#define UARTCLOCK_UARTCLOCKSCALE_SET(x)                              (((0 | (x)) << UARTCLOCK_UARTCLOCKSCALE_LSB) & UARTCLOCK_UARTCLOCKSCALE_MASK)
#define UARTCLOCK_UARTCLOCKSCALE_RESET                               0
#define UARTCLOCK_UARTCLOCKSTEP_MSB                                  15
#define UARTCLOCK_UARTCLOCKSTEP_LSB                                  0
#define UARTCLOCK_UARTCLOCKSTEP_MASK                                 0x0000ffff
#define UARTCLOCK_UARTCLOCKSTEP_GET(x)                               (((x) & UARTCLOCK_UARTCLOCKSTEP_MASK) >> UARTCLOCK_UARTCLOCKSTEP_LSB)
#define UARTCLOCK_UARTCLOCKSTEP_SET(x)                               (((0 | (x)) << UARTCLOCK_UARTCLOCKSTEP_LSB) & UARTCLOCK_UARTCLOCKSTEP_MASK)
#define UARTCLOCK_UARTCLOCKSTEP_RESET                                0
#define UARTCLOCK_ADDRESS                                            0x0008
#define UARTCLOCK_HW_MASK                                            0x00ffffff
#define UARTCLOCK_SW_MASK                                            0x00ffffff
#define UARTCLOCK_RSTMASK                                            0x00ffffff
#define UARTCLOCK_RESET                                              0x00000000

// 0x000c (UARTINT)
#define UARTINT_UARTTXEMPTYINT_MSB                                   9
#define UARTINT_UARTTXEMPTYINT_LSB                                   9
#define UARTINT_UARTTXEMPTYINT_MASK                                  0x00000200
#define UARTINT_UARTTXEMPTYINT_GET(x)                                (((x) & UARTINT_UARTTXEMPTYINT_MASK) >> UARTINT_UARTTXEMPTYINT_LSB)
#define UARTINT_UARTTXEMPTYINT_SET(x)                                (((0 | (x)) << UARTINT_UARTTXEMPTYINT_LSB) & UARTINT_UARTTXEMPTYINT_MASK)
#define UARTINT_UARTTXEMPTYINT_RESET                                 0
#define UARTINT_UARTRXFULLINT_MSB                                    8
#define UARTINT_UARTRXFULLINT_LSB                                    8
#define UARTINT_UARTRXFULLINT_MASK                                   0x00000100
#define UARTINT_UARTRXFULLINT_GET(x)                                 (((x) & UARTINT_UARTRXFULLINT_MASK) >> UARTINT_UARTRXFULLINT_LSB)
#define UARTINT_UARTRXFULLINT_SET(x)                                 (((0 | (x)) << UARTINT_UARTRXFULLINT_LSB) & UARTINT_UARTRXFULLINT_MASK)
#define UARTINT_UARTRXFULLINT_RESET                                  0
#define UARTINT_UARTRXBREAKOFFINT_MSB                                7
#define UARTINT_UARTRXBREAKOFFINT_LSB                                7
#define UARTINT_UARTRXBREAKOFFINT_MASK                               0x00000080
#define UARTINT_UARTRXBREAKOFFINT_GET(x)                             (((x) & UARTINT_UARTRXBREAKOFFINT_MASK) >> UARTINT_UARTRXBREAKOFFINT_LSB)
#define UARTINT_UARTRXBREAKOFFINT_SET(x)                             (((0 | (x)) << UARTINT_UARTRXBREAKOFFINT_LSB) & UARTINT_UARTRXBREAKOFFINT_MASK)
#define UARTINT_UARTRXBREAKOFFINT_RESET                              0
#define UARTINT_UARTRXBREAKONINT_MSB                                 6
#define UARTINT_UARTRXBREAKONINT_LSB                                 6
#define UARTINT_UARTRXBREAKONINT_MASK                                0x00000040
#define UARTINT_UARTRXBREAKONINT_GET(x)                              (((x) & UARTINT_UARTRXBREAKONINT_MASK) >> UARTINT_UARTRXBREAKONINT_LSB)
#define UARTINT_UARTRXBREAKONINT_SET(x)                              (((0 | (x)) << UARTINT_UARTRXBREAKONINT_LSB) & UARTINT_UARTRXBREAKONINT_MASK)
#define UARTINT_UARTRXBREAKONINT_RESET                               0
#define UARTINT_UARTRXPARITYERRINT_MSB                               5
#define UARTINT_UARTRXPARITYERRINT_LSB                               5
#define UARTINT_UARTRXPARITYERRINT_MASK                              0x00000020
#define UARTINT_UARTRXPARITYERRINT_GET(x)                            (((x) & UARTINT_UARTRXPARITYERRINT_MASK) >> UARTINT_UARTRXPARITYERRINT_LSB)
#define UARTINT_UARTRXPARITYERRINT_SET(x)                            (((0 | (x)) << UARTINT_UARTRXPARITYERRINT_LSB) & UARTINT_UARTRXPARITYERRINT_MASK)
#define UARTINT_UARTRXPARITYERRINT_RESET                             0
#define UARTINT_UARTTXOFLOWERRINT_MSB                                4
#define UARTINT_UARTTXOFLOWERRINT_LSB                                4
#define UARTINT_UARTTXOFLOWERRINT_MASK                               0x00000010
#define UARTINT_UARTTXOFLOWERRINT_GET(x)                             (((x) & UARTINT_UARTTXOFLOWERRINT_MASK) >> UARTINT_UARTTXOFLOWERRINT_LSB)
#define UARTINT_UARTTXOFLOWERRINT_SET(x)                             (((0 | (x)) << UARTINT_UARTTXOFLOWERRINT_LSB) & UARTINT_UARTTXOFLOWERRINT_MASK)
#define UARTINT_UARTTXOFLOWERRINT_RESET                              0
#define UARTINT_UARTRXOFLOWERRINT_MSB                                3
#define UARTINT_UARTRXOFLOWERRINT_LSB                                3
#define UARTINT_UARTRXOFLOWERRINT_MASK                               0x00000008
#define UARTINT_UARTRXOFLOWERRINT_GET(x)                             (((x) & UARTINT_UARTRXOFLOWERRINT_MASK) >> UARTINT_UARTRXOFLOWERRINT_LSB)
#define UARTINT_UARTRXOFLOWERRINT_SET(x)                             (((0 | (x)) << UARTINT_UARTRXOFLOWERRINT_LSB) & UARTINT_UARTRXOFLOWERRINT_MASK)
#define UARTINT_UARTRXOFLOWERRINT_RESET                              0
#define UARTINT_UARTRXFRAMINGERRINT_MSB                              2
#define UARTINT_UARTRXFRAMINGERRINT_LSB                              2
#define UARTINT_UARTRXFRAMINGERRINT_MASK                             0x00000004
#define UARTINT_UARTRXFRAMINGERRINT_GET(x)                           (((x) & UARTINT_UARTRXFRAMINGERRINT_MASK) >> UARTINT_UARTRXFRAMINGERRINT_LSB)
#define UARTINT_UARTRXFRAMINGERRINT_SET(x)                           (((0 | (x)) << UARTINT_UARTRXFRAMINGERRINT_LSB) & UARTINT_UARTRXFRAMINGERRINT_MASK)
#define UARTINT_UARTRXFRAMINGERRINT_RESET                            0
#define UARTINT_UARTTXREADYINT_MSB                                   1
#define UARTINT_UARTTXREADYINT_LSB                                   1
#define UARTINT_UARTTXREADYINT_MASK                                  0x00000002
#define UARTINT_UARTTXREADYINT_GET(x)                                (((x) & UARTINT_UARTTXREADYINT_MASK) >> UARTINT_UARTTXREADYINT_LSB)
#define UARTINT_UARTTXREADYINT_SET(x)                                (((0 | (x)) << UARTINT_UARTTXREADYINT_LSB) & UARTINT_UARTTXREADYINT_MASK)
#define UARTINT_UARTTXREADYINT_RESET                                 0
#define UARTINT_UARTRXVALIDINT_MSB                                   0
#define UARTINT_UARTRXVALIDINT_LSB                                   0
#define UARTINT_UARTRXVALIDINT_MASK                                  0x00000001
#define UARTINT_UARTRXVALIDINT_GET(x)                                (((x) & UARTINT_UARTRXVALIDINT_MASK) >> UARTINT_UARTRXVALIDINT_LSB)
#define UARTINT_UARTRXVALIDINT_SET(x)                                (((0 | (x)) << UARTINT_UARTRXVALIDINT_LSB) & UARTINT_UARTRXVALIDINT_MASK)
#define UARTINT_UARTRXVALIDINT_RESET                                 0
#define UARTINT_ADDRESS                                              0x000c
#define UARTINT_HW_MASK                                              0x000003ff
#define UARTINT_SW_MASK                                              0x000003ff
#define UARTINT_RSTMASK                                              0x000003ff
#define UARTINT_RESET                                                0x00000000

// 0x0010 (UARTINTEN)
#define UARTINTEN_UARTTXEMPTYINTEN_MSB                               9
#define UARTINTEN_UARTTXEMPTYINTEN_LSB                               9
#define UARTINTEN_UARTTXEMPTYINTEN_MASK                              0x00000200
#define UARTINTEN_UARTTXEMPTYINTEN_GET(x)                            (((x) & UARTINTEN_UARTTXEMPTYINTEN_MASK) >> UARTINTEN_UARTTXEMPTYINTEN_LSB)
#define UARTINTEN_UARTTXEMPTYINTEN_SET(x)                            (((0 | (x)) << UARTINTEN_UARTTXEMPTYINTEN_LSB) & UARTINTEN_UARTTXEMPTYINTEN_MASK)
#define UARTINTEN_UARTTXEMPTYINTEN_RESET                             0
#define UARTINTEN_UARTRXFULLINTEN_MSB                                8
#define UARTINTEN_UARTRXFULLINTEN_LSB                                8
#define UARTINTEN_UARTRXFULLINTEN_MASK                               0x00000100
#define UARTINTEN_UARTRXFULLINTEN_GET(x)                             (((x) & UARTINTEN_UARTRXFULLINTEN_MASK) >> UARTINTEN_UARTRXFULLINTEN_LSB)
#define UARTINTEN_UARTRXFULLINTEN_SET(x)                             (((0 | (x)) << UARTINTEN_UARTRXFULLINTEN_LSB) & UARTINTEN_UARTRXFULLINTEN_MASK)
#define UARTINTEN_UARTRXFULLINTEN_RESET                              0
#define UARTINTEN_UARTRXBREAKOFFINTEN_MSB                            7
#define UARTINTEN_UARTRXBREAKOFFINTEN_LSB                            7
#define UARTINTEN_UARTRXBREAKOFFINTEN_MASK                           0x00000080
#define UARTINTEN_UARTRXBREAKOFFINTEN_GET(x)                         (((x) & UARTINTEN_UARTRXBREAKOFFINTEN_MASK) >> UARTINTEN_UARTRXBREAKOFFINTEN_LSB)
#define UARTINTEN_UARTRXBREAKOFFINTEN_SET(x)                         (((0 | (x)) << UARTINTEN_UARTRXBREAKOFFINTEN_LSB) & UARTINTEN_UARTRXBREAKOFFINTEN_MASK)
#define UARTINTEN_UARTRXBREAKOFFINTEN_RESET                          0
#define UARTINTEN_UARTRXBREAKONINTEN_MSB                             6
#define UARTINTEN_UARTRXBREAKONINTEN_LSB                             6
#define UARTINTEN_UARTRXBREAKONINTEN_MASK                            0x00000040
#define UARTINTEN_UARTRXBREAKONINTEN_GET(x)                          (((x) & UARTINTEN_UARTRXBREAKONINTEN_MASK) >> UARTINTEN_UARTRXBREAKONINTEN_LSB)
#define UARTINTEN_UARTRXBREAKONINTEN_SET(x)                          (((0 | (x)) << UARTINTEN_UARTRXBREAKONINTEN_LSB) & UARTINTEN_UARTRXBREAKONINTEN_MASK)
#define UARTINTEN_UARTRXBREAKONINTEN_RESET                           0
#define UARTINTEN_UARTRXPARITYERRINTEN_MSB                           5
#define UARTINTEN_UARTRXPARITYERRINTEN_LSB                           5
#define UARTINTEN_UARTRXPARITYERRINTEN_MASK                          0x00000020
#define UARTINTEN_UARTRXPARITYERRINTEN_GET(x)                        (((x) & UARTINTEN_UARTRXPARITYERRINTEN_MASK) >> UARTINTEN_UARTRXPARITYERRINTEN_LSB)
#define UARTINTEN_UARTRXPARITYERRINTEN_SET(x)                        (((0 | (x)) << UARTINTEN_UARTRXPARITYERRINTEN_LSB) & UARTINTEN_UARTRXPARITYERRINTEN_MASK)
#define UARTINTEN_UARTRXPARITYERRINTEN_RESET                         0
#define UARTINTEN_UARTTXOFLOWERRINTEN_MSB                            4
#define UARTINTEN_UARTTXOFLOWERRINTEN_LSB                            4
#define UARTINTEN_UARTTXOFLOWERRINTEN_MASK                           0x00000010
#define UARTINTEN_UARTTXOFLOWERRINTEN_GET(x)                         (((x) & UARTINTEN_UARTTXOFLOWERRINTEN_MASK) >> UARTINTEN_UARTTXOFLOWERRINTEN_LSB)
#define UARTINTEN_UARTTXOFLOWERRINTEN_SET(x)                         (((0 | (x)) << UARTINTEN_UARTTXOFLOWERRINTEN_LSB) & UARTINTEN_UARTTXOFLOWERRINTEN_MASK)
#define UARTINTEN_UARTTXOFLOWERRINTEN_RESET                          0
#define UARTINTEN_UARTRXOFLOWERRINTEN_MSB                            3
#define UARTINTEN_UARTRXOFLOWERRINTEN_LSB                            3
#define UARTINTEN_UARTRXOFLOWERRINTEN_MASK                           0x00000008
#define UARTINTEN_UARTRXOFLOWERRINTEN_GET(x)                         (((x) & UARTINTEN_UARTRXOFLOWERRINTEN_MASK) >> UARTINTEN_UARTRXOFLOWERRINTEN_LSB)
#define UARTINTEN_UARTRXOFLOWERRINTEN_SET(x)                         (((0 | (x)) << UARTINTEN_UARTRXOFLOWERRINTEN_LSB) & UARTINTEN_UARTRXOFLOWERRINTEN_MASK)
#define UARTINTEN_UARTRXOFLOWERRINTEN_RESET                          0
#define UARTINTEN_UARTRXFRAMINGERRINTEN_MSB                          2
#define UARTINTEN_UARTRXFRAMINGERRINTEN_LSB                          2
#define UARTINTEN_UARTRXFRAMINGERRINTEN_MASK                         0x00000004
#define UARTINTEN_UARTRXFRAMINGERRINTEN_GET(x)                       (((x) & UARTINTEN_UARTRXFRAMINGERRINTEN_MASK) >> UARTINTEN_UARTRXFRAMINGERRINTEN_LSB)
#define UARTINTEN_UARTRXFRAMINGERRINTEN_SET(x)                       (((0 | (x)) << UARTINTEN_UARTRXFRAMINGERRINTEN_LSB) & UARTINTEN_UARTRXFRAMINGERRINTEN_MASK)
#define UARTINTEN_UARTRXFRAMINGERRINTEN_RESET                        0
#define UARTINTEN_UARTTXREADYINTEN_MSB                               1
#define UARTINTEN_UARTTXREADYINTEN_LSB                               1
#define UARTINTEN_UARTTXREADYINTEN_MASK                              0x00000002
#define UARTINTEN_UARTTXREADYINTEN_GET(x)                            (((x) & UARTINTEN_UARTTXREADYINTEN_MASK) >> UARTINTEN_UARTTXREADYINTEN_LSB)
#define UARTINTEN_UARTTXREADYINTEN_SET(x)                            (((0 | (x)) << UARTINTEN_UARTTXREADYINTEN_LSB) & UARTINTEN_UARTTXREADYINTEN_MASK)
#define UARTINTEN_UARTTXREADYINTEN_RESET                             0
#define UARTINTEN_UARTRXVALIDINTEN_MSB                               0
#define UARTINTEN_UARTRXVALIDINTEN_LSB                               0
#define UARTINTEN_UARTRXVALIDINTEN_MASK                              0x00000001
#define UARTINTEN_UARTRXVALIDINTEN_GET(x)                            (((x) & UARTINTEN_UARTRXVALIDINTEN_MASK) >> UARTINTEN_UARTRXVALIDINTEN_LSB)
#define UARTINTEN_UARTRXVALIDINTEN_SET(x)                            (((0 | (x)) << UARTINTEN_UARTRXVALIDINTEN_LSB) & UARTINTEN_UARTRXVALIDINTEN_MASK)
#define UARTINTEN_UARTRXVALIDINTEN_RESET                             0
#define UARTINTEN_ADDRESS                                            0x0010
#define UARTINTEN_HW_MASK                                            0x000003ff
#define UARTINTEN_SW_MASK                                            0x000003ff
#define UARTINTEN_RSTMASK                                            0x000003ff
#define UARTINTEN_RESET                                              0x00000000

#define uart_reg_read(x)        ar7240_reg_rd( (AR7240_UART_BASE+x) )
#define uart_reg_write(x, y)    ar7240_reg_wr( (AR7240_UART_BASE+x), y)

static int
AthrUartGet(char *__ch_data)
{
    u32    rdata;    
    
    rdata = uart_reg_read(UARTDATA_ADDRESS);

    if (UARTDATA_UARTRXCSR_GET(rdata)) {
        *__ch_data = (char)UARTDATA_UARTTXRXDATA_GET(rdata);
        rdata = UARTDATA_UARTRXCSR_SET(1);
        uart_reg_write(UARTDATA_ADDRESS, rdata); 
        return 1;
    }
    else {
        return 0;        
    }
}

static void
AthrUartPut(char __ch_data)
{
    u32 rdata;

    do {
        rdata = uart_reg_read(UARTDATA_ADDRESS);
    } while (UARTDATA_UARTTXCSR_GET(rdata) == 0);
    
    rdata = UARTDATA_UARTTXRXDATA_SET((u32)__ch_data);
    rdata |= UARTDATA_UARTTXCSR_SET(1);

    uart_reg_write(UARTDATA_ADDRESS, rdata);
}

void
ar7240_sys_frequency(u32 *cpu_freq, u32 *ddr_freq, u32 *ahb_freq)
{
#ifdef CONFIG_HORNET_EMU
    #ifdef CONFIG_HORNET_EMU_HARDI_WLAN
    *cpu_freq = 48 * 1000000;
    *ddr_freq = 48 * 1000000;
    *ahb_freq = 24 * 1000000;    
    #else
    *cpu_freq = 80 * 1000000;
    *ddr_freq = 80 * 1000000;
    *ahb_freq = 40 * 1000000;
    #endif
#else
    #if 1 /* Hornet's PLL is completely different from Python's */
    u32     ref_clock_rate, pll_freq;
    u32     pllreg, clockreg;
    u32     nint, refdiv, outdiv;
    u32     cpu_div, ahb_div, ddr_div;
    
    if ( ar7240_reg_rd(HORNET_BOOTSTRAP_STATUS) & HORNET_BOOTSTRAP_SEL_25M_40M_MASK )
        ref_clock_rate = 40 * 1000000;
    else
        ref_clock_rate = 25 * 1000000;        
    
    pllreg   = ar7240_reg_rd(AR7240_CPU_PLL_CONFIG);
    clockreg = ar7240_reg_rd(AR7240_CPU_CLOCK_CONTROL);    
    
    if (clockreg & HORNET_CLOCK_CONTROL_BYPASS_MASK) {
        /* Bypass PLL */ 
        pll_freq = ref_clock_rate;
        cpu_div = ahb_div = ddr_div = 1;
    }
    else {
        nint = (pllreg & HORNET_PLL_CONFIG_NINT_MASK) >> HORNET_PLL_CONFIG_NINT_SHIFT;
        refdiv = (pllreg & HORNET_PLL_CONFIG_REFDIV_MASK) >> HORNET_PLL_CONFIG_REFDIV_SHIFT;
        outdiv = (pllreg & HORNET_PLL_CONFIG_OUTDIV_MASK) >> HORNET_PLL_CONFIG_OUTDIV_SHIFT;
        
        pll_freq = (ref_clock_rate / refdiv) * nint;
        
        if (outdiv == 1)
            pll_freq /= 2;
        else if (outdiv == 2)   
            pll_freq /= 4;                    
        else if (outdiv == 3)  
            pll_freq /= 8;             
        else if (outdiv == 4) 
            pll_freq /= 16;                
        else if (outdiv == 5) 
            pll_freq /= 32;             
        else if (outdiv == 6)  
            pll_freq /= 64;              
        else if (outdiv == 7)  
            pll_freq /= 128;              
        else /* outdiv == 0 --> illegal value */                                                                     
            pll_freq /= 2;   
            
        cpu_div = (clockreg & HORNET_CLOCK_CONTROL_CPU_POST_DIV_MASK) >> HORNET_CLOCK_CONTROL_CPU_POST_DIV_SHIFT;
        ddr_div = (clockreg & HORNET_CLOCK_CONTROL_DDR_POST_DIV_MASK) >> HORNET_CLOCK_CONTROL_DDR_POST_DIV_SFIFT;
        ahb_div = (clockreg & HORNET_CLOCK_CONTROL_AHB_POST_DIV_MASK) >> HORNET_CLOCK_CONTROL_AHB_POST_DIV_SFIFT;
        
        /*
         * b00 : div by 1, b01 : div by 2, b10 : div by 3, b11 : div by 4
         */
        cpu_div++;
        ddr_div++;
        ahb_div++;                              
    }
    
    *cpu_freq = pll_freq / cpu_div;
    *ddr_freq = pll_freq / ddr_div;
    *ahb_freq = pll_freq / ahb_div;
    #else /* Hornet's PLL is completely different from Python's */
    u32 pll, pll_div, ref_div, ahb_div, ddr_div, freq;

    pll = ar7240_reg_rd(AR7240_CPU_PLL_CONFIG);

    pll_div =
        ((pll & PLL_CONFIG_PLL_DIV_MASK) >> PLL_CONFIG_PLL_DIV_SHIFT);

    ref_div =
        ((pll & PLL_CONFIG_PLL_REF_DIV_MASK) >> PLL_CONFIG_PLL_REF_DIV_SHIFT);

    ddr_div =
        ((pll & PLL_CONFIG_DDR_DIV_MASK) >> PLL_CONFIG_DDR_DIV_SHIFT) + 1;

    ahb_div =
       (((pll & PLL_CONFIG_AHB_DIV_MASK) >> PLL_CONFIG_AHB_DIV_SHIFT) + 1)*2;

    freq = pll_div * ref_div * 5000000;

    if (cpu_freq)
        *cpu_freq = freq;

    if (ddr_freq)
        *ddr_freq = freq/ddr_div;

    if (ahb_freq)
        *ahb_freq = freq/ahb_div;
    #endif /* Hornet's PLL is completely different from Python's */         
#endif
}

int serial_init(void)
{
    u32 rdata;
    u32 baudRateDivisor, clock_step;
    u32 fcEnable = 0; 
    u32 ahb_freq, ddr_freq, cpu_freq;

    ar7240_sys_frequency(&cpu_freq, &ddr_freq, &ahb_freq);    

    /* GPIO Configuration */
    ar7240_reg_wr(AR7240_GPIO_OE, 0xcff);
    rdata = ar7240_reg_rd(AR7240_GPIO_OUT);
    rdata |= 0x400; // GPIO 10 (UART_SOUT) must output 1
    ar7240_reg_wr(AR7240_GPIO_OUT, rdata);
    ar7240_reg_wr(AR7240_GPIO_FUNC, 0x001c8102);
    
    /* Get reference clock rate, then set baud rate to 115200 */
#ifndef CONFIG_HORNET_EMU    
    rdata = ar7240_reg_rd(HORNET_BOOTSTRAP_STATUS);
    rdata &= HORNET_BOOTSTRAP_SEL_25M_40M_MASK;
    if (rdata)
        baudRateDivisor = ( 40000000 / (16*115200) ) - 1; // 40 MHz clock is taken as UART clock        
    else
        baudRateDivisor = ( 25000000 / (16*115200) ) - 1; // 25 MHz clock is taken as UART clock	        
#else
    baudRateDivisor = ( ahb_freq / (16*115200) ) - 1; // 40 MHz clock is taken as UART clock 
#endif
 
    clock_step = 8192;
    
	rdata = UARTCLOCK_UARTCLOCKSCALE_SET(baudRateDivisor) | UARTCLOCK_UARTCLOCKSTEP_SET(clock_step);
	uart_reg_write(UARTCLOCK_ADDRESS, rdata);    
    
    /* Config Uart Controller */
#if 1 /* No interrupt */
	rdata = UARTCS_UARTDMAEN_SET(0) | UARTCS_UARTHOSTINTEN_SET(0) | UARTCS_UARTHOSTINT_SET(0)
	        | UARTCS_UARTSERIATXREADY_SET(0) | UARTCS_UARTTXREADYORIDE_SET(~fcEnable) 
	        | UARTCS_UARTRXREADYORIDE_SET(~fcEnable) | UARTCS_UARTHOSTINTEN_SET(0);
#else    
	rdata = UARTCS_UARTDMAEN_SET(0) | UARTCS_UARTHOSTINTEN_SET(0) | UARTCS_UARTHOSTINT_SET(0)
	        | UARTCS_UARTSERIATXREADY_SET(0) | UARTCS_UARTTXREADYORIDE_SET(~fcEnable) 
	        | UARTCS_UARTRXREADYORIDE_SET(~fcEnable) | UARTCS_UARTHOSTINTEN_SET(1);
#endif	        	        
	        
    /* is_dte == 1 */
    rdata = rdata | UARTCS_UARTINTERFACEMODE_SET(2);   
    
	if (fcEnable) {
	   rdata = rdata | UARTCS_UARTFLOWCONTROLMODE_SET(2); 
	}
	
    /* invert_fc ==0 (Inverted Flow Control) */
    //rdata = rdata | UARTCS_UARTFLOWCONTROLMODE_SET(3);
    
    /* parityEnable == 0 */
    //rdata = rdata | UARTCS_UARTPARITYMODE_SET(2); -->Parity Odd  
    //rdata = rdata | UARTCS_UARTPARITYMODE_SET(3); -->Parity Even
    uart_reg_write(UARTCS_ADDRESS, rdata);
    
    return 0;
}

int serial_tstc (void)
{
    return (UARTDATA_UARTRXCSR_GET(uart_reg_read(UARTDATA_ADDRESS)));
}

u8 serial_getc(void)
{
    char    ch_data;

    while (!AthrUartGet(&ch_data))  ;

    return (u8)ch_data;
}


void serial_putc(u8 byte)
{
    if (byte == '\n')   AthrUartPut('\r');

    AthrUartPut((char)byte);
}

void serial_setbrg (void)
{
}

void serial_puts (const char *s)
{
	while (*s)
	{
		serial_putc (*s++);
	}
}
