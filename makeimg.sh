#!/bin/bash
DIR=/home/elite/android/RefinedKernel_2/rf-tools
DIRK=/home/elite/android/RefinedKernel_2
#Cleanup before build

echo "Remove Any files"

cd DIR/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a DIR/ramdisk/. DIR/AIK-Linux/ramdisk


echo "copy split-img"

sudo cp -a DIR/split_img/. DIR/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp DIRK/arch/arm64/boot/Image DIR/AIK-Linux/split_img/boot.img-zImage

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp DIR/AIK-Linux/image-new.img DIR/out/boot.img

echo "Cleanup after packing"

cd DIR/AIK-Linux

sudo ./cleanup.sh

echo "boot.img saved to /rf-tools/out"
