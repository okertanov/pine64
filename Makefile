##
## pine64 top-level makefile
##

## Deps
## sudo apt-get install debootstrap
## sudo apt-get install qemu binfmt-support qemu-user-static

DISK_IMAGE_SIZE_GB:=1
DISK_IMAGE_NAME:=pine64-disk-$(DISK_IMAGE_SIZE_GB)Gb.img

all: tmp disk-image

disk-image: $(DISK_IMAGE_NAME)

%.img:
	fallocate -l $(DISK_IMAGE_SIZE_GB)G $@
	dd conv=notrunc if=/dev/zero of=$@ bs=1M count=1
	dd conv=notrunc if=vendor/sunxi/sunxi-spl-1.bin of=$@ bs=1024 seek=8
	dd conv=notrunc if=vendor/sunxi/u-boot-1.bin of=$@ bs=1024 seek=32
	printf "1M,64M,c\n,,L" | sudo sfdisk $@
	sudo losetup --partscan --show --find $@
	sudo mkfs.vfat /dev/loop0p1
	sudo mkfs.ext4 /dev/loop0p2
	sync
	sudo mount /dev/loop0p1 tmp/bmount
	sudo mount /dev/loop0p2 tmp/rmount
	sudo cp vendor/kernel/linux-pine64-latest/* tmp/bmount
	ls -la tmp/bmount
	sync
	sudo debootstrap --arch=armhf --foreign jessie tmp/rmount
	sudo cp /usr/bin/qemu-arm-static tmp/rmount/usr/bin/
	sudo chroot tmp/rmount /usr/bin/qemu-arm-static /bin/sh -i /debootstrap/debootstrap --second-stage
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

