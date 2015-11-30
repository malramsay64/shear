stab_dir=stab-dir
vel_dir=vel-dir
dist_dir=dist-dir

PATH:=$(PATH):$(shell pwd)/bin
plot_dir=$(shell pwd)/plots
lib_dir=$(shell pwd)/lib
export plot_dir lib_dir PATH

dirs=$(stab_dir) $(vel_dir) $(dist_dir)
builds=stab vel dist

all: $(builds)

.PHONY: $(builds)
$(builds): % : update-%
	$(MAKE) -C $@-dir

plot-%: update-% | %-dir
	$(MAKE) -C ${@:plot-%=%-dir} plot

$(dirs):
	mkdir -p $@

update-%: %-dir
	cp Makefile.${<:%-dir=%} $</Makefile
	cp shear $</

delete-%:
	rm -r ${@:delete-%=%}-dir
