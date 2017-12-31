#!/bin/bash
#Cleanup before build

echo "Remove Any files"
cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/ramdisk/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/ramdisk


echo "copy split-img"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/split_img/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/refinedkernel_2/arch/arm64/boot/Image /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "copy compiled dtb"

sudo cp /home/elite/android/refinedkernel_2/boot.img-dtb /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-dtb

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/image-new.img /home/elite/android/refinedkernel_2/rf-tools/out/boot.img

echo "Cleanup after packing"

cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "boot.img saved to /rf-tools/out"
