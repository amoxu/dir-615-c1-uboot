# www Makefile
#
# Copyright 2005, CAMEO Corporation 
# All Rights Reserved.

include $(APPS_PATH)/.config
INSTALLDIR = $(FS_PATH)

ifeq ($(CONFIG_TEST_PAGE),y)
	WWW_INSTALL += install-test-page
endif

ifeq ($(CONFIG_WWW),y)
	WWW_INSTALL += install-www
endif

ifeq ($(CONFIG_SSI_WWW), y)
	WWW_INSTALL += install-www
endif

ifeq ($(CONFIG_MODEL_NAME), DIR-730)
	include $(APPS_PATH)/../.config
	FIRMWARE_VERSION=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_FIRMWARE|awk 'BEGIN {FS="\\""}; {print $$2}'`
	FIRMWARE_BUILD=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_BUILD|awk 'BEGIN {FS="\\""}; {print $$2}'`
	FIRMWARE_DATE=`cat ./${CONFIG_MODEL_NAME}/version.c|grep VER_DATE|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_VERSION=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_SDK=`cat ../apps/doc/apps_version.c|grep __CAMEO_ATHEROS_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_BUILD=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_BUILD__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_DATE=`cat ../platform/${PLATFORM}/doc/linux_version.c|grep __CAMEO_LINUX_BUILD_DATE__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	KERNEL_TAG="KERNEL: ${KERNEL_VERSION}, SDK: ${KERNEL_SDK}, Build: ${KERNEL_BUILD}, Date: ${KERNEL_DATE}<Br>"
	WIRELESS_VERSION=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_VERSION__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_BUILD=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_BUILD__|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_DATE=`cat ../wireless/${WL_PLATFORM}/doc/wireless_version.c|grep __CAMEO_WIRELESS_DATE_|awk 'BEGIN {FS="\\""}; {print $$2}'`
	WIRELESS_TAG="WLAN Version: ${WIRELESS_VERSION}, Build: ${WIRELESS_BUILD}, Date: ${WIRELESS_DATE}<Br>"
	TAIL="</body></html>"
endif

#	Date:		2009-05-26
#	Name:		Jimmy Huang
#	Reason:		Modified Makefile to support project depended packages
#	Notice :	When you want to add a project depended packages, please follow steps described below
#		1. www/model_name/project_apps/Makefile
#			append package directory name to variable PROJECT_APPS
#		2. make sure the CFLAGS or CONFIG flags your packages used must be bring to 
#			www/model_name/project_apps/Makefile
#

PROJETC_APPS_PATH = $(WWW_PATH)/project_apps

all:
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) all || exit 1; \
	fi

clean:
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) clean || exit 1; \
	fi

install: $(WWW_INSTALL) all
	@if [ -d $(PROJETC_APPS_PATH) ]; then \
		$(MAKE) -C $(PROJETC_APPS_PATH) install || exit 1; \
	fi

install-www: 
	mkdir -p $(INSTALLDIR)/www
#	cp -R ./$(CONFIG_MODEL_NAME)/www$(CONFIG_LANGUAGE_PACK)/* $(INSTALLDIR)/www
ifneq (y,$(CONFIG_LIGHTTPD))
	$(TOOL_PATH)/cp_html/cp_html $(CONFIG_MODEL_NAME)/www$(CONFIG_LANGUAGE_PACK) $(INSTALLDIR)/www
endif
	if [ -f $(WWW_PATH)/pre_customer.sh ]; then \
	install $(WWW_PATH)/pre_customer.sh $(FS_PATH)/etc/rc.d/; \
	chmod 777 $(FS_PATH)/etc/rc.d/pre_customer.sh; \
	fi
	if [ -f $(WWW_PATH)/post_customer.sh ] ; then \
	install $(WWW_PATH)/post_customer.sh $(FS_PATH)/etc/rc.d/; \
	chmod 777 $(FS_PATH)/etc/rc.d/post_customer.sh; \
	fi 
	[ ! -e $(CONFIG_MODEL_NAME)/Makefile ] || $(MAKE) -C $(CONFIG_MODEL_NAME) $@
	-$(MAKE) -C $(CONFIG_MODEL_NAME) $@
ifeq ($(CONFIG_RUSSIA_WIZARD_PAGES),y)	
	mv $(INSTALLDIR)/www/wizard3.russia.asp $(INSTALLDIR)/www/wizard3.asp
endif

install-test-page:
	mkdir -p $(INSTALLDIR)/www
	cp -R Test-Page/* $(INSTALLDIR)/www
	rm -fr $(INSTALLDIR)/www/CVS
