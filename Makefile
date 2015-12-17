stab_dir=stab-dir
vel_dir=vel-dir
dist_dir=dist-dir
scale_dir=scale-dir
stab_search_dir=stab_search-dir


plot_dir=$(shell pwd)/plots
bin_dir=$(shell pwd)/bin
PATH:=$(PATH):$(bin_dir)
export plot_dir lib_dir PATH bin_dir

dirs=$(stab_dir) $(vel_dir) $(dist_dir) $(scale_dir) $(stab_search_dir)
builds=stab vel dist scale stab_search

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

$(addprefix delete-,$(builds)):delete-%:
	-rm -r ${@:delete-%=%}-dir

delete-all: $(addprefix delete-,$(builds))
