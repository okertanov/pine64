##
## pine64 top-level makefile
##

DISK_IMAGE_SIZE_GB:=4
DISK_IMAGE_NAME:=pine64-disk-$(DISK_IMAGE_SIZE_GB)Gb.img

all: tmp disk-image

disk-image: $(DISK_IMAGE_NAME)

%.img:
	fallocate -l $(DISK_IMAGE_SIZE_GB)G $@

tmp:
	mkdir -p tmp/bmount
	mkdir -p tmp/rmount

clean:
	-@rm -f $(DISK_IMAGE_NAME)
	-@rm -rf ./tmp

.PHONY: all clean disk-image tmp

.SILENT: clean

