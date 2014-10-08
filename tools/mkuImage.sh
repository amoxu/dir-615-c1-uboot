#!/bin/sh -x

#
# $1 == u-boot/tools path
# $2 == kernel tree path
# $3 == kernel type
#
MKIMAGE=$TOOL_PATH/mkimage
VMLINUX=$1/vmlinux
VMLINUXBIN=$1/arch/mips/boot/vmlinux.bin

if [ $3 ] ;then
	case $3 in
		ap94)
			#NickChou for AP94 Low memory load
			LDADDR=0x80002000
			ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|cut -d":" -f 2`
			;;
		ap98)
			LDADDR=0x80002000
			ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|cut -d":" -f 2`
			;;
		mv_ap95)
			#	LDADDR=0xF8100000
			LDADDR=0x00008000
			ENTRY=0x00008000
			;;
		db12x)
			LDADDR=0x80002000
			ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|head -1|cut -d":" -f 2`
			;;
		*)
			LDADDR=0x80060000
			ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|cut -d":" -f 2`
			;;
	esac
else
	LDADDR=0x80060000
	ENTRY=`readelf -a ${VMLINUX}|grep "Entry"|cut -d":" -f 2`
fi


TFTPPATH=/tftpboot
IMAGEDIR=$2/vmlinux.lzma


#gzip -f ${VMLINUXBIN}

#${MKIMAGE} -A mips -O linux -T kernel -C gzip \
#        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
#               -d ${VMLINUXBIN}.gz ${TFTPPATH}/vmlinux.gz.uImage

if [ $3 ] && [ $3 == mv_ap95 ]; then
${MKIMAGE} -A arm -O linux -T kernel -C lzma \
        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
                -d ${IMAGEDIR} $2/vmlinux.lzma.ub
else
${MKIMAGE} -A mips -O linux -T kernel -C lzma \
        -a ${LDADDR} -e ${ENTRY} -n "Linux Kernel Image"    \
                -d ${IMAGEDIR} $2/vmlinux.lzma.ub
fi
