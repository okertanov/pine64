##
## pine64 top-level makefile
##

DISK_IMAGE_SIZE_GB:=4
DISK_IMAGE_NAME:=pine64-disk-$(DISK_IMAGE_SIZE_GB)Gb.img

all: disk-image

disk-image: $(DISK_IMAGE_NAME)

%.img:
	fallocate -l $(DISK_IMAGE_SIZE_GB)G $@

clean:
	-@rm -f $(DISK_IMAGE_NAME)

.PHONY: all clean disk-image

.SILENT: clean

