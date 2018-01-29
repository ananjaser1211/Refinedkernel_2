#Build script for J530Y/J530YM With 3GB_RAM DTS
#!/bin/bash
DTS=arch/arm64/boot/dts
RDIR=$(pwd)
# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J530F Config
make j5y17lte_01_defconfig
# make exynos7870-j5y17lte_eur_openm_00.dtb exynos7870-j5y17lte_eur_openm_01.dtb exynos7870-j5y17lte_eur_openm_02.dtb exynos7870-j5y17lte_eur_openm_03.dtb exynos7870-j5y17lte_eur_openm_05.dtb exynos7870-j5y17lte_eur_openm_07.dtb
# Make zImage
make ARCH=arm64 -j4
# ./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb

# Generate Boot_J530Y.img

echo "Remove Any files"
cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/J530M/ramdisk/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/ramdisk

echo "copy split-img"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/J530M/split_img/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/refinedkernel_2/arch/arm64/boot/Image /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "copy Prebuilt dtb"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/prebuilts/boot.imgy-dtb /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-dtb

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/image-new.img /home/elite/android/refinedkernel_2/rf-tools/out/boot_J530Y.img

echo "Cleanup after packing"

cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

rm /home/elite/android/refinedkernel_2/boot.img-dtb

echo "boot.img saved to /rf-tools/out"

echo J530m Kernel Done