##
## pine64 top-level makefile
##

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

tmp:
	mkdir -p tmp/bmount
	mkdir -p tmp/rmount

clean:
	-@rm -f $(DISK_IMAGE_NAME)
	-@rm -rf ./tmp
	-@sudo losetup -D || true

.PHONY: all clean disk-image tmp

.SILENT: clean

