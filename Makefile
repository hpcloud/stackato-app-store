YAML2JSON := perl -MYAML::XS -MJSON::XS \
        -e 'print JSON::XS->new->pretty->canonical->encode(YAML::XS::LoadFile(shift))'

STACKATO_STORE_VERSION ?= 1.0
STACKATO_STORE_SOURCE := $(STACKATO_STORE_VERSION)

STACKATO_STORE_BUILD ?= build
STACKATO_STORE_BUILD := $(STACKATO_STORE_BUILD:%=%/$(STACKATO_STORE_VERSION))

ALL := $(shell cd $(STACKATO_STORE_SOURCE); echo *.yaml)
ifeq ($(STACKATO_STORE_VERSION),1.0)
    ALL := $(ALL:%.yaml=%.jsonp)
else
    ALL := $(ALL:%.yaml=%.json)
endif
ALL := $(ALL:%=$(STACKATO_STORE_BUILD)/%)

MESSAGE ?= "Update Stackato App Store Files"

default: build
build: $(STACKATO_STORE_BUILD) $(ALL)

$(STACKATO_STORE_BUILD)/%.jsonp: $(STACKATO_STORE_SOURCE)/%.yaml Makefile
	echo "ConsoleObject.set_app_store_data(" > $@
	$(YAML2JSON) $< >> $@
	echo >> $@
	echo ');' >> $@

$(STACKATO_STORE_BUILD)/%.json: $(STACKATO_STORE_SOURCE)/%.yaml Makefile
	$(YAML2JSON) $< > $@

$(STACKATO_STORE_BUILD): 
	mkdir -p $@

pull:
	git checkout master
	git pull --rebase

push:
	git add .
	git commit -m "$(MESSAGE)"
	git push

clean purge:
	rm -fr build
