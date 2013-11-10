#Chromebook Pixel Keyboard backlight driver for Linux 3.x.  

Since the newest Linux Kernel(3.12) ships with Chromebook Pixel support, both touchscreen and touchpad all work fine, but kernel doesn't include the keyboard backlight driver. So I pick the driver form [https://github.com/brocktice/pixel_linux](https://github.com/brocktice/pixel_linux) and make it standalone, easy to use.

Thanks to [brocktice](http://blog.brocktice.com/2013/03/09/running-debian-wheezy-7-0-on-the-chromebook-pixel/)
[DaveM](http://vger.kernel.org/~davem/chromebook_pixel_linux.txt)

##Requirements
* Google Chromebook Pixel laptop with Linux installed.
* Build toolchains.  


##Know issue
If we register the keyboard backlight device as `backlight` to Linux system, Gnome will be confused with LCD backlight and Keyboard backlight, In system setting panel, display brightness adjust will be operated on Keyboard Backlight.
So, we register it as `leds` devices to system to make Gnome happy.

##How to install

Clone the code 

if you want the keyboard backlight works like an `backlight` then edit `pixel_kb_backlight.c` 

	#ifdef KB_BACKLIGHT
	#define DEVICE_NAME "chromeos-keyboard-backlight"
	#else
	#define DEVICE_NAME "chromeos-keyboard-leds"
	#endif

Change these you the driver will act as `backlight` or `leds`.

Build with:

	make

You will get 3 drivers:
	chromeos_keyboard_bl.ko  	#backlight class driver
	chromeos-keyboard-leds.ko   #leds class driver
	pixel_kb_backlight.ko		#keyboard backlight device driver
	
Now, you can load the drivers:

if you choose `backlight`

	sudo insmod chromeos_keyboard_bl.ko
	sudo insmod pixel_kb_backlight.ko

if you choose `leds`

	sudo insmod chromeos-keyboard-leds.ko
	sudo insmod pixel_kb_backlight.ko

OK, check whether the drivers load succsefully:

if you choose `backlight`

	ls /sys/class/backlight
	
if you choose `leds`

	ls /sys/class/leds
	

If you can see `keyboard_backlight` or `chromeos::kbd_backlight` from `ls` output, It works!

###How to use
I have put a helper shell script to adjust the backlight level
**You need edit the script if you choose `backlight`, to use the correct path**

	# turn on the backlight
	sudo ./keyboard_brightness.sh on
	
	#turn off the backlight
	sudo ./keyboard_brightness.sh off
	
	#turn up 
	sudo ./keyboard_brightness.sh up
	
	#turn down
	sudo ./keyboard_brightness.sh down
	


##For `leds` as sample:
###Make it load automaticlly while system boot

I install Ubuntu 13.10 with Linux kernel 3.12.0-031200-generic, so I do the following:

	#copy our drivers to the kernel's modules dir
	sudo cp chromeos_keyboard_bl.ko /lib/modules/3.12.0-031200-generic/
	sudo cp pixel_kb_backlight.ko /lib/modules/3.12.0-031200-generic/
	
	#tell system we have new modules
	sudo depmod -a
	sudo modprobe module
	
then edit `/etc/modules` and add two lines:

	chromeos-keyboard-leds
	pixel_kb_backlight

Just reboot the laptop, the keyboard backlight driver will load automaticlly.

###Enjoy!
