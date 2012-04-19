YAML2JSON := perl -MYAML::XS -MJSON::XS \
        -e 'print JSON::XS->new->pretty->canonical->encode(YAML::XS::LoadFile(shift))'

ifndef STACKATO_STORE_VERSION
    STACKATO_STORE_VERSION := 1.0
endif
STACKATO_STORE_SOURCE := $(STACKATO_STORE_VERSION)

ifndef STACKATO_STORE_BUILD
    STACKATO_STORE_BUILD := build
endif
STACKATO_STORE_BUILD := $(STACKATO_STORE_BUILD)/$(STACKATO_STORE_VERSION)

ALL := $(shell (cd $(STACKATO_STORE_SOURCE; echo *.yaml))
ALLJSON := $(ALL:%.yaml=%.json)
ALLJSONP := $(ALL:%.yaml=%.jsonp)
ALL := $(ALLJSON) $(ALLJSONP)
ALL := $(ALL:%=$(STACKATO_STORE_BUILD)/%)

default: build
build: $(STACKATO_STORE_BUILD) $(ALL)

$(STACKATO_STORE_BUILD)/%.jsonp: $(STACKATO_STORE_SOURCE)/%.yaml Makefile
	echo "ConsoleObject.set_app_store_data(" > $@
	$(YAML2JSON) $< >> $@
	echo >> $@
	echo ');' >> $@

$(STACKATO_STORE_BUILD)/%.json: $(STACKATO_STORE_SOURCE)/%.yaml Makefile
	$(YAML2JSON) $< >> $@

$(STACKATO_STORE_BUILD): 
	mkdir -p $@

clean purge:
	rm -fr $(STACKATO_STORE_BUILD)
