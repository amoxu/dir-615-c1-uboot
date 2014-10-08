include $(DAEMONS_PATH)/.config

COMPILER_FLAGS += -DEN

ifeq ($(CONFIG_M17N_TW),y)
COMPILER_FLAGS+=-DTW
endif

ifeq ($(CONFIG_M17N_CN),y)
COMPILER_FLAGS+=-DCN
endif

ifeq ($(CONFIG_M17N_JA),y)
COMPILER_FLAGS+=-DJA
endif

ifeq ($(CONFIG_M17N_DE),y)
COMPILER_FLAGS+=-DDE
endif

ifeq ($(CONFIG_M17N_ES),y)
COMPILER_FLAGS+=-DES
endif

ifeq ($(CONFIG_M17N_FR),y)
COMPILER_FLAGS+=-DFR
endif

ifeq ($(CONFIG_M17N_IT),y)
COMPILER_FLAGS+=-DIT
endif

ifeq ($(CONFIG_M17N_KR),y)
COMPILER_FLAGS+=-DKR
endif

ifeq ($(CONFIG_LP),y)
DEFAULT_LANG = `grep lingual $(PROJECTS_PATH)/nvram.default |sed -e 's/lingual=//'`
LP_MAJOR=`sed -n 's/\#define LP_VER \"\([0-9]\{1\}\)\.\([0-9]\{2\}\)\"/\1/p' lp_version.h`
LP_MINOR=`sed -n 's/\#define LP_VER \"\([0-9]\{1\}\)\.\([0-9]\{2\}\)\"/\2/p' lp_version.h`
LP_DATE=`cat lp_version.h | grep LP_DATE | sed -e 's/^.*= "//' | sed 's/ *";//'`
LP_JS=lingualMTD
CFLAGS += -DCONFIG_MODEL_NAME="\"$(CONFIG_MODEL_NAME)\"" -DCONFIG_LP
endif

js_converter: *.c lp_version.h
	gcc $(COMPILER_FLAGS) $(CFLAGS) -o $@ $^

install_m17n_%:
ifeq ($(CONFIG_LP),y)
#Generate $(LP_JS)
	 $(if $(findstring $(subst install_m17n_,,$@),EN TW), \
$(ENV_PATH)/tools/m17n/js_converter -l $(subst install_m17n_,,$@) -c $(STRING_PATH)STRINGS_ZH.txt -t ./$(LP_JS), \
$(ENV_PATH)/tools/m17n/js_converter -l $(subst install_m17n_,,$@) -c $(STRING_PATH)STRINGS_$(subst install_m17n_,,$@).txt -t ./$(LP_JS))
#touch $(FS_PATH)/www/$(LP_JS).js is used to prevent httpd return error with there is no $(LP_JS).js in /www/
	if [ $(DEFAULT_LANG) = $(subst install_m17n_,,$@) ];\
	then \
	  echo "document.write(\"<script language=JavaScript type=text\/javascript src=$(LP_JS).js><\/script>\");" >> ./$(LP_JS);\
	  cp -f ./$(LP_JS) $(FS_PATH)/www/lingual_$(subst install_m17n_,,$@).js; \
	  touch $(FS_PATH)/www/$(LP_JS).js; \
	else ./release_LP.sh $(ENV_PATH) $(CONFIG_MODEL_NAME) $(LP_MAJOR) $(LP_MINOR) $(subst install_m17n_,,$@) $(LP_JS) "$(LP_DATE)"; \
	fi
	rm -f ./$(LP_JS)
endif

ifeq ($(CONFIG_M17N),y)
	$(if $(findstring $(subst install_m17n_,,$@),EN TW), \
$(ENV_PATH)/tools/m17n/js_converter -l $(subst install_m17n_,,$@) -c $(STRING_PATH)STRINGS_ZH.txt -t $(FS_PATH)/www, \
$(ENV_PATH)/tools/m17n/js_converter -l $(subst install_m17n_,,$@) -c $(STRING_PATH)STRINGS_$(subst install_m17n_,,$@).txt -t $(FS_PATH)/www)
endif

clean:
	rm -f js_converter
	rm -f *.js
