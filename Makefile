stab_dir=stab-dir
vel_dir=vel-dir

plot_dir=$(shell pwd)/plots
export plot_dir

dirs=$(stab_dir) $(vel_dir)
builds=stab vel

all: $(builds)

.PHONY: $(builds)
$(builds): % : update-%
	echo $(MAKE) -C $@-dir

plot-%: update-% | %-dir
	$(MAKE) -C ${@:plot-%=%-dir} plot

$(dirs):
	mkdir -p $@

update-%: %-dir
	cp Makefile.vel $</Makefile
	cp shear $</

delete-%:
	rm -r ${@:delete-%=%}-dir
