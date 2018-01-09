#!/bin/bash
# Must be run with Root
# Device Names >>>
# J530F/J530G = BOOT_J530FG.IMG
# J530Y/FM/GM/YM = BOOT_J530M.IMG
# J730F = BOOT_J730F.IMG

# Build script for J530F/J530G With EUR_OPEN DTS
DTS=arch/arm64/boot/dts
RDIR=$(pwd)
# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J530F Config
make j5y17lte_01_defconfig
make exynos7870-j5y17lte_eur_open_00.dtb exynos7870-j5y17lte_eur_open_01.dtb exynos7870-j5y17lte_eur_open_02.dtb exynos7870-j5y17lte_eur_open_03.dtb exynos7870-j5y17lte_eur_open_05.dtb exynos7870-j5y17lte_eur_open_07.dtb
# Make zImage
make ARCH=arm64 -j4
./scripts/dtbTool/dtbTool -o ./bootfg.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb

# Generate Boot_J530FG.img

echo "Remove Any files"
cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/ramdisk/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/ramdisk

echo "copy split-img"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/split_img/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/refinedkernel_2/arch/arm64/boot/Image /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "copy compiled zimage again"

sudo cp /home/elite/android/refinedkernel_2/arch/arm64/boot/Image /home/elite/android/refinedkernel_2/rf-tools/boot.img-zImage

echo "copy compiled dtb"

sudo cp /home/elite/android/refinedkernel_2/bootfg.img-dtb /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-dtb

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/image-new.img /home/elite/android/refinedkernel_2/rf-tools/out/boot_J530FG.img

echo "Cleanup after packing"

cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "boot.img saved to /rf-tools/out"

echo J530F_G Kernel Done

cd /home/elite/android/refinedkernel_2

# Generate J530GM/FM/Y/YM EUR_OPENM DTS
make clean && make mrproper
# J530F Config
make j5y17lte_01_defconfig
make exynos7870-j5y17lte_eur_openm_00.dtb exynos7870-j5y17lte_eur_openm_01.dtb exynos7870-j5y17lte_eur_openm_02.dtb exynos7870-j5y17lte_eur_openm_03.dtb exynos7870-j5y17lte_eur_openm_05.dtb exynos7870-j5y17lte_eur_openm_07.dtb
./scripts/dtbTool/dtbTool -o ./bootm.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb

# Generate Boot_J530m.img

echo "Remove Any files"
cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/ramdisk/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/ramdisk

echo "copy split-img"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/split_img/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/boot.img-zImage /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "copy compiled dtb"

sudo cp /home/elite/android/refinedkernel_2/bootm.img-dtb /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-dtb

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/image-new.img /home/elite/android/refinedkernel_2/rf-tools/out/boot_J530M.img

echo "Cleanup after packing"

cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

sudo rm /home/elite/android/refinedkernel_2/rf-tools/boot.img-zImage

echo "boot.img saved to /rf-tools/out"

echo J530m Kernel Done

# Build J730F Kernel

cd /home/elite/android/refinedkernel_2

# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J730F Config
make j7y17lte_eur_open_defconfig
make exynos7870-j7y17lte_eur_open_00.dtb exynos7870-j7y17lte_eur_open_01.dtb exynos7870-j7y17lte_eur_open_02.dtb exynos7870-j7y17lte_eur_open_03.dtb exynos7870-j7y17lte_eur_open_04.dtb exynos7870-j7y17lte_eur_open_05.dtb exynos7870-j7y17lte_eur_open_06.dtb exynos7870-j7y17lte_eur_open_07.dtb
# Make zImage
make ARCH=arm64 -j4
./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb
#!/bin/bash
#Cleanup before build

# Generate Boot_J730F.img
echo "Remove Any files"
cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "Copy Ramdisk"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/ramdisk/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/ramdisk

echo "copy split-img"

sudo cp -a /home/elite/android/refinedkernel_2/rf-tools/Unified/split_img/. /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img

echo "copy compiled zimage"

sudo cp /home/elite/android/refinedkernel_2/arch/arm64/boot/Image /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-zImage

echo "copy compiled dtb"

sudo cp /home/elite/android/refinedkernel_2/boot.img-dtb /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/split_img/boot.img-dtb

echo "packing image"

sudo ./repackimg.sh

echo "Copy boot.img"

sudo cp /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux/image-new.img /home/elite/android/refinedkernel_2/rf-tools/out/boot_J730F.img

echo "Cleanup after packing"

cd /home/elite/android/refinedkernel_2/rf-tools/AIK-Linux

sudo ./cleanup.sh

echo "boot.img saved to /rf-tools/out"

echo J730F Kernel Done

