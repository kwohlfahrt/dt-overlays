%.dtbo: %.dts
	dtc -@ -I dts -O dtb $< > $@

dtbos: w1-gpio.dtbo justboom-dac.dtbo

obj-m += justboom-dac.o

all: dtbos
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	rm -f *.dtbo
	$(MAKE) -C $(KDIR) M=$(PWD) clean
