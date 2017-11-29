#!/bin/bash
DTS=arch/arm64/boot/dts
RDIR=$(pwd)
# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J530F Config
make j5y17lte_01_defconfig
make exynos7870-j5y17lte_eur_open_00.dtb
make exynos7870-j5y17lte_eur_open_01.dtb
make exynos7870-j5y17lte_eur_open_02.dtb
make exynos7870-j5y17lte_eur_open_03.dtb
make exynos7870-j5y17lte_eur_open_05.dtb
make exynos7870-j5y17lte_eur_open_07.dtb
# Make zImage
make ARCH=arm64 -j4
# Make DT.img
./scripts/dtbTool/dtbTool -o ./dt.img -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb