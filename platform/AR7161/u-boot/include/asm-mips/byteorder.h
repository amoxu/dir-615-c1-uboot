/* $Id: byteorder.h,v 1.2 2010/05/26 07:20:34 jackey Exp $
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License.  See the file "COPYING" in the main directory of this archive
 * for more details.
 *
 * Copyright (C) by Ralf Baechle
 */
#ifndef _MIPS_BYTEORDER_H
#define _MIPS_BYTEORDER_H

#include <asm/types.h>

#ifdef __GNUC__

#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
#  define __BYTEORDER_HAS_U64__
#  define __SWAB_64_THRU_32__
#endif

#endif /* __GNUC__ */

#if defined (__MIPSEB__)
#  include <linux/byteorder/big_endian.h>
#elif defined (__MIPSEL__)
#  include <linux/byteorder/little_endian.h>
#else
#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
#endif

#endif /* _MIPS_BYTEORDER_H */
