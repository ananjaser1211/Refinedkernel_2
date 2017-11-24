#!/bin/bash
DTS=arch/arm64/boot/dts
# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J530F Config
make j5y17lte_01_defconfig
# J530F DTB
make exynos7870-j5y17lte_eur_open_00.dtb
# Make zImage
make ARCH=arm64 -j4
# Make DT.img
./tools/dtbtool -o ./arch/arm64/boot/dt.img -v -s 2048 -p ./scripts/dtc/ $DTS/
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb
