# INSTALL_DIR = /usr/local/bin
INSTALL_DIR = ../ 

INCLUDEDIR = .

CFLAGS := -I$(INCLUDEDIR) -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE -O2

#ifdef USE_LZMA
  LZMA_CFLAGS = -DUSE_LZMA
  LZMA_LIB = -llzma
  CFLAGS += $(LZMA_CFLAGS)
#endif

# lzma 4.32
# LZMA_LIB = ../squashfs-tools/lzma/C/7zip/Compress/LZMA_Lib

# lzma 4.65
LZMA_LIB_PATH = lzma-4.65
LZMA_LIB += -L$(LZMA_LIB_PATH)/C/LzmaUtil
LZMA_LIB_INCLUDEDIR += -I$(LZMA_LIB_PATH)/C/
LZMA_LIB_UTIL_DIR = $(LZMA_LIB_PATH)/C/LzmaUtil
LZMA_LIB_ALONE_DIR = $(LZMA_LIB_PATH)/CPP/7zip/Compress/LZMA_Alone

# LDFLAGS += -L$(LZMA_LIB_PATH)/C/7zip/Compress/LZMA_Lib
CFLAGS += $(LZMA_LIB_INCLUDEDIR)

all: lzma mksquashfs4 unsquashfs4

lzma:
	$(MAKE) -C $(LZMA_LIB_UTIL_DIR) -f makefile.gcc 
	$(MAKE) -C $(LZMA_LIB_ALONE_DIR) -f makefile.gcc

lzma_clean:
	$(MAKE) -C $(LZMA_LIB_UTIL_DIR) -f makefile.gcc clean 
	$(MAKE) -C $(LZMA_LIB_ALONE_DIR) -f makefile.gcc clean

mksquashfs4: mksquashfs.o read_fs.o sort.o swap.o pseudo.o uncompress.o
	$(CC) mksquashfs.o read_fs.o sort.o swap.o pseudo.o uncompress.o -lz -lpthread -lm $(LZMA_LIB) -o $@

mksquashfs.o: mksquashfs.c squashfs_fs.h mksquashfs.h global.h sort.h squashfs_swap.h uncompress.h Makefile

read_fs.o: read_fs.c squashfs_fs.h read_fs.h global.h squashfs_swap.h uncompress.h Makefile

sort.o: sort.c squashfs_fs.h global.h sort.h Makefile

swap.o: swap.c Makefile

pseudo.o: pseudo.c pseudo.h Makefile

uncompress.o: uncompress.c uncompress.h

unsquashfs4: unsquashfs.o unsquash-1.o unsquash-2.o unsquash-3.o unsquash-4.o swap.o uncompress.o
	$(CC) unsquashfs.o unsquash-1.o unsquash-2.o unsquash-3.o unsquash-4.o swap.o uncompress.o -lz -lpthread -lm $(LZMA_LIB) -o $@

unsquashfs.o: unsquashfs.h unsquashfs.c squashfs_fs.h squashfs_swap.h squashfs_compat.h global.h uncompress.h Makefile

unsquash-1.o: unsquashfs.h unsquash-1.c squashfs_fs.h squashfs_compat.h global.h uncompress.h Makefile

unsquash-2.o: unsquashfs.h unsquash-2.c unsquashfs.h squashfs_fs.h squashfs_compat.h global.h uncompress.h Makefile

unsquash-3.o: unsquashfs.h unsquash-3.c squashfs_fs.h squashfs_compat.h global.h uncompress.h Makefile

unsquash-4.o: unsquashfs.h unsquash-4.c squashfs_fs.h squashfs_swap.h global.h uncompress.h Makefile

clean: lzma_clean
	rm -f *.o mksquashfs4 unsquashfs4

install: lzma mksquashfs4 unsquashfs4
#	mkdir -p $(INSTALL_DIR)
	cp mksquashfs4 $(INSTALL_DIR)
	cp unsquashfs4 $(INSTALL_DIR)
