ifneq ($(KERNELRELEASE),)
obj-m := pixel_kb_backlight.o chromeos_keyboard_bl.o
else
KDIR ?= /lib/modules/`uname -r`/build

all: pixel_kb_backlight chromeos_keyboard_bl

pixel_kb_backlight: pixel_kb_backlight.c
	$(MAKE) -C $(KDIR) M=$$PWD

chromeos_keyboard_bl: chromeos_keyboard_bl.c
	$(MAKE) -C $(KDIR) M=$$PWD

clean:
	rm -f pixel_kb_backlight *.o *.ko modules.order Module.symvers *.mod.c
endif
