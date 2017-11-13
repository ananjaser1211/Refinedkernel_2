#!/bin/bash
DTS=arch/arm64/boot/dts
DIR=/home/elite/android/RefinedKernel_2
#Cleanup before build

echo "Compile wtih UberTC"
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
ARCH=arm64

echo "CleanUp"
make clean && make mrproper

echo "Refined DEFCON"
make j5y17lte_01_defconfig
make -j3

# echo "Make DTB"
# sudo chmod 755 /tools/dtbTool
# ./tools/dtbTool -o ./dtb.img -v -s 2048 -p ./scripts/dtc/ $DTS/
# rm -rf $DTS/.*.tmp
# rm -rf $DTS/.*.cmd
# rm -rf $DTS/*.dtb
