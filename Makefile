##
## pine64 top-level makefile
##

##
## Deps
## sudo apt-get install debootstrap
## sudo apt-get install qemu binfmt-support qemu-user-static
## sudo apt-get install gcc-aarch64-linux-gnu
##

##
## How to extract blobs
## wget https://www.stdin.xyz/downloads/people/longsleep/tmp/pine64-images/simpleimage-pine64-20160618-1.img.xz
## unxz simpleimage-pine64-20160618-1.img.xz
## dd if=simpleimage-pine64-20160618-1.img of=boot0.bin bs=1024 skip=8 count=32
## dd if=simpleimage-pine64-20160618-1.img of=u-boot-with-dtb.bin bs=1024 skip=19096 count=20000
## rm simpleimage-pine64-20160618-1.img
##

##
## How to extract kernel & /boot contents
## See https://www.stdin.xyz/downloads/people/longsleep/tmp/pine64-images/linux/
##

##
## ARM hosts: pine, cone, nootka
##

ARM_ARCH:=arm64
ADDITIONAL_DEBS1:="netbase,net-tools,ifupdown,iproute,openssh-server,ntp,ntpdate,vim,less,sudo,locales,tasksel,ca-certificates"
ADDITIONAL_DEBS2:="avahi-daemon avahi-discover,libnss-mdns"
ADDITIONAL_DEBS:=$(ADDITIONAL_DEBS1),$(ADDITIONAL_DEBS2)

DISK_IMAGE_SIZE_GB:=1
DISK_IMAGE_NAME:=pine64-disk-$(DISK_IMAGE_SIZE_GB)Gb.img

all: tmp disk-image

disk-image: $(DISK_IMAGE_NAME)

%.img:
	fallocate -l $(DISK_IMAGE_SIZE_GB)G $@
	dd conv=notrunc if=/dev/zero of=$@ bs=1M count=64
	dd conv=notrunc if=vendor/sunxi/boot0.bin of=$@ bs=1024 seek=8
	dd conv=notrunc if=vendor/sunxi/u-boot-with-dtb.bin of=$@ bs=1024 seek=19096
	sync
	printf "20M,64M,c\n65M,,L" | sudo sfdisk $@
	sudo losetup --partscan --show --find $@
	sudo mkfs.vfat /dev/loop0p1 -n "PINEBOOT"
	sudo mkfs.ext4 -m0 -L"pineroot" /dev/loop0p2
	sudo tune2fs -o journal_data_writeback /dev/loop0p2
	sudo fsck /dev/loop0p2
	sync
	sudo mount /dev/loop0p1 tmp/bmount
	sudo mount /dev/loop0p2 tmp/rmount
	sudo cp -r vendor/kernel/linux-pine64-new/* tmp/bmount
	ls -la tmp/bmount
	sync
	sudo debootstrap --arch=$(ARM_ARCH) --foreign --include=$(ADDITIONAL_DEBS) testing tmp/rmount
	sudo cp /usr/bin/qemu-aarch64-static tmp/rmount/usr/bin/
	sudo chroot tmp/rmount /usr/bin/qemu-aarch64-static /bin/sh -i /debootstrap/debootstrap --second-stage
	sync
	$(post-config-rootfs)
	sync
	sudo umount tmp/bmount
	sudo umount tmp/rmount

tmp:
	mkdir -p tmp/bmount
	mkdir -p tmp/rmount

clean:
	-@sudo umount tmp/bmount || true
	-@sudo umount tmp/rmount || true
	-@sudo losetup -D || true
	-@rm -f $(DISK_IMAGE_NAME)
	-@sudo rm -rf ./tmp

.PHONY: all clean disk-image tmp

.SILENT: clean

define post-config-rootfs =
-@echo "Post configuration..."
sudo du -sh tmp/rmount
sudo cp -r rootfs/* tmp/rmount/
endef

