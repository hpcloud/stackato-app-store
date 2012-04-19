YAML2JSON := perl -MYAML::XS -MJSON::XS \
        -e 'print JSON::XS->new->pretty->canonical->encode(YAML::XS::LoadFile(shift))'
VERSION := 1.0
BUILD := /tmp/stackato-app-store
BASE := static/store/$(VERSION)
ALL := $(shell echo *.yaml)
ALLJSON := $(ALL:%.yaml=%.json)
ALLJSONP := $(ALL:%.yaml=%.jsonp)
ALL := $(ALLJSON) $(ALLJSONP)
ALL := $(ALL:%=$(BUILD)/%)

default: build
build: $(BUILD) $(ALL)

$(BUILD)/%.jsonp: %.yaml Makefile
	echo "ConsoleObject.set_app_store_data(" > $@
	$(YAML2JSON) $< >> $@
	echo >> $@
	echo ');' >> $@

$(BUILD)/%.json: %.yaml Makefile
	$(YAML2JSON) $< >> $@

$(BUILD): 
	mkdir -p $@

live: build
	git checkout master
	mkdir -p $(BASE)
	cp $(BUILD)/* $(BASE)
	git add $(BASE)
	-git commit -m "Updating store files"
	git checkout store
	rm $(BUILD) -rf
