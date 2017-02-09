PINE64+
=======

HW Specs
--------
### Architecture

    Quad-core ARM Cortex-A53 Processor@1152Mhz (NEON Advanced SIMD, VFPv4)
    RAM: 2GB.
    32KB L1 Instruction cache and 32KB L1 Data cache, 512KB L2 cache
    ARM Mali400MP2 Dual-core GPU, Support OpenGL ES 2.0 and OpenVG 1.1 standard
    HDMI 1.4a
    10/100/1000Mbps Ethernet
    Realtek 8723BS WiFi 802.11bgn

### Expansion Ports

    DSI - Display Serial Interface, 4 lanes MiPi, up to 1080P
    CSI - CMOS Camera Interface up to 5 mega pixel
    TP - Touch Panel Port, SPI with interrupt
    RTC - Real Time Clock Battery Connector
    VBAT - Lithium Battery Connector with temperature sensor input
    Wifi/BT Module Header - SDIO 3.0 and UART
    2x20 pins "Pi2" GPIO Header
    2x17 pins "Euler" GPIO Header
    2x5 pins "EXP" Console Header

Imaging
-------

    scp okertanov@debora.local:/home/okertanov/projects/pine64.git/pine64-disk-1Gb.img ./
    md5 pine64-disk-1Gb.img
    sudo diskutil list
    sudo diskutil unmountDisk /dev/disk2
    sudo dd if=pine64-disk-1Gb.img of=/dev/rdisk2 bs=1m

Debug
-----

    screen -t 'ttyUSB0 115200 8n1' /dev/cu.SLAB_USBtoUART 115200,-ixoff,-ixon


Host System setup
-----------------

    TBD

Ideas
-----
 - Own distributive sandbox
 - Buddha machine
 - Headless Musicbox/Streaming server
 - Radio and remote control
 - Auto Video player
 - Kodi Video player & Torrents
 - .Net core or Node app server

Credits
-------

    TBD

Links
-----
[https://www.pine64.org/](https://www.pine64.org/)  
[http://wiki.pine64.org/index.php/Pine_A64_Software_Release](http://wiki.pine64.org/index.php/Pine_A64_Software_Release)  
[http://wiki.pine64.org/index.php/Main_Page#Pine_A64_Hardware_PCB_information](http://wiki.pine64.org/index.php/Main_Page#Pine_A64_Hardware_PCB_information)  
[https://linux-sunxi.org/A64](https://linux-sunxi.org/A64)  
[https://linux-sunxi.org/Pine64](https://linux-sunxi.org/Pine64)  
[https://linux-sunxi.org/Sunxi-tools](https://linux-sunxi.org/Sunxi-tools)  
[https://linux-sunxi.org/Bootable_SD_card](https://linux-sunxi.org/Bootable_SD_card)  

[https://github.com/apritzel/pine64](https://github.com/apritzel/pine64)  
[https://github.com/apritzel/pine64/blob/master/Booting.md](https://github.com/apritzel/pine64/blob/master/Booting.md)  

[https://github.com/longsleep/linux-pine64](https://github.com/longsleep/linux-pine64)  
[https://github.com/longsleep/build-pine64-image](https://github.com/longsleep/build-pine64-image)  
[https://www.stdin.xyz/downloads/people/longsleep/tmp/pine64-images/](https://www.stdin.xyz/downloads/people/longsleep/tmp/pine64-images/)  

[https://www.pine64.pro/](https://www.pine64.pro/)  
[https://volumio.org/](https://volumio.org/)  
[https://www.plex.tv/](https://www.plex.tv/)  
[https://www.hackster.io/](https://www.hackster.io/)  
[https://github.com/alexa/alexa-avs-sample-app/blob/master/README.md](https://github.com/alexa/alexa-avs-sample-app/blob/master/README.md)  

