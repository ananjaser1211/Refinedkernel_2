#!/bin/bash
#Cleanup before build

echo "Compile wtih Google Toolchain"
export CROSS_COMPILE=/home/elite/android/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
ARCH=arm64

echo "CleanUp"
make clean && make mrproper

echo "Stock DEFCON"
make j5y17lte_eur_open_defconfig
make -j3
