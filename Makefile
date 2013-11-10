ifneq ($(KERNELRELEASE),)
obj-m := pixel_kb_backlight.o chromeos_keyboard_bl.o leds-chromeos-keyboard.o
else
KDIR ?= /lib/modules/`uname -r`/build

all: pixel_kb_backlight chromeos_keyboard_bl leds-chromeos-keyboard

pixel_kb_backlight: pixel_kb_backlight.c
	$(MAKE) -C $(KDIR) M=$$PWD

chromeos_keyboard_bl: chromeos_keyboard_bl.c
	$(MAKE) -C $(KDIR) M=$$PWD

leds-chromeos-keyboard: leds-chromeos-keyboard.c
	$(MAKE) -C $(KDIR) M=$$PWD

clean:
	rm -f *.o *.ko modules.order Module.symvers *.mod.c
endif
