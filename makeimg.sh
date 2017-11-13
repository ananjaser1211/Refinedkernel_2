#!/bin/bash
#Cleanup before build

echo "Remove Any files"

cd /home/elite/android/Refinedkernel/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/Refinedkernel/rf-tools/ramdisk/. /home/elite/android/Refinedkernel/rf-tools/AIK-Linux/ramdisk


echo "copy split-img"

sudo cp -a /home/elite/android/Refinedkernel/rf-tools/split_img/. /home/elite/android/Refinedkernel/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/Refinedkernel/arch/arm64/boot/Image /home/elite/android/Refinedkernel/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/Refinedkernel/rf-tools/AIK-Linux/image-new.img /home/elite/android/Refinedkernel/rf-tools/out/boot.img

echo "Cleanup after packing"

cd /home/elite/android/Refinedkernel/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "boot.img saved to /rf-tools/out"
