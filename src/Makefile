%.dtbo: %.dts
	dtc -@ -I dts -O dtb $< > $@

dtbos: w1-gpio.dtbo justboom-dac.dtbo

obj-m += snd-soc-justboom-dac.o

modules:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

.PHONY: all
all: dtbos modules

clean:
	rm -f *.dtbo
	$(MAKE) -C $(KDIR) M=$(PWD) clean
