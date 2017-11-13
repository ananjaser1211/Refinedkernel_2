#!/bin/bash
DTS=arch/arm64/boot/dts
DIR=/home/elite/android/RefinedKernel_2
TC=/home/elite/android/toolchain
#Cleanup before build

echo "Compile wtih UberTC"
export CROSS_COMPILE=TC/ubertc-aarch64-4.9/bin/aarch64-linux-android-
ARCH=arm64

echo "CleanUp"
make clean && make mrproper

echo "Refined DEFCON"
make j5y17lte_eur_open_defconfig
make -j3
