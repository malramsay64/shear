stab_dir=stab-dir
vel_dir=vel-dir

dirs=$(stab_dir) $(vel_dir)
builds=stab vel

all: $(builds)

.PHONY: $(builds)
$(builds): % : update-% 
	echo $(MAKE) -C $@-dir


plot-stab: update-stab | $(stab_dir)
	$(MAKE) -C $(stab_dir) plot

plot-vel: update-vel | $(vel_dir)
	$(MAKE) -C $(vel_dir) plot

$(dirs):
	mkdir -p $@

update-%: %-dir
	cp Makefile.vel $</Makefile
	cp shear $</

delete-%:
	rm -r ${@:delete-%=%}-dir
