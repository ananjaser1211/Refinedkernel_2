#!/bin/bash
# Cronos Kernel for Exynos 7870
# Coded by Ananjaser1211/BlackMesa
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software

# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Kernel Variables
CR_VERSION=v2.6
CR_DATE=$(date +%Y%m%d)
# CR_TC_GCC=/home/elite/android/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CR_TC_UB=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
CR_DIR=$(pwd)
CR_OUT=$CR_DIR/rf-tools/out
CR_DTS=arch/arm64/boot/dts
CR_JOBS=5
CR_AIK=$CR_DIR/rf-tools/AIK-Linux
CR_RAMDISK=$CR_DIR/rf-tools/Unified
CR_KERNEL=$CR_DIR/arch/arm64/boot/Image
CR_DTB=$CR_DIR/boot.img-dtb
# Device specific Variables
CR_DTSFILES="exynos7870-j5y17lte_eur_openm_00.dtb exynos7870-j5y17lte_eur_openm_01.dtb exynos7870-j5y17lte_eur_openm_02.dtb exynos7870-j5y17lte_eur_openm_03.dtb exynos7870-j5y17lte_eur_openm_05.dtb exynos7870-j5y17lte_eur_openm_07.dtb"
CR_CONFG=j5y17lte_eur_openm_defconfig
CR_VARIANT=J530GM/FM
CR_ANDROID=7
CR_ARCH=arm64

echo "----------------------------------------------"
echo "Cleaning"
echo " "
# make clean
# make mrproper
rm -r -f $CR_OUT/*
echo " "
echo "----------------------------------------------"
echo "Building zImage for $CR_VARIANT"
echo " "
export $CR_ARCH
export CROSS_COMPILE=$CR_TC_UB
export LOCALVERSION=-Refined_Kernel-$CR_VERSION-$CR_VARIANT-$CR_DATE
export ANDROID_MAJOR_VERSION=$CR_ANDROID
make  $CR_CONFG
make -j$CR_JOBS
echo " "
echo "----------------------------------------------"
echo "Building DTB for $CR_VARIANT"
echo " "
export $CR_ARCH
export CROSS_COMPILE=$CR_TC_UB
export ANDROID_MAJOR_VERSION=$CR_ANDROID
make  $CR_CONFG
make $CR_DTSFILES
./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $CR_DTS/ -s 2048
rm -rf $CR_DTS/.*.tmp
rm -rf $CR_DTS/.*.cmd
rm -rf $CR_DTS/*.dtb
du -k "./boot.img-dtb" | cut -f1 >sizT
sizT=$(head -n 1 sizT)
rm -rf sizT
echo "Combined DTB Size = $sizT Kb"
echo " "
echo "----------------------------------------------"
echo "Building Boot.img for $CR_VARIANT"
echo " "
cp -rf $CR_RAMDISK/* $CR_AIK
mv $CR_KERNEL $CR_AIK/split_img/boot.img-zImage
mv $CR_DTB $CR_AIK/split_img/boot.img-dtb
$CR_AIK/repackimg.sh
mv $CR_AIK/image-new.img $CR_OUT/Refined-$CR_VERSION-$CR_DATE-$CR_VARIANT.img
$CR_AIK/cleanup.sh
echo "----------------------------------------------"
echo "$CR_VARIANT Ready at $CR_OUT"
echo " "
