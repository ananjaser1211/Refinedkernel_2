# J530Y PLACEHOLDER
#!/bin/bash
DTS=arch/arm64/boot/dts
RDIR=$(pwd)
# UberTC
export CROSS_COMPILE=/home/elite/android/toolchain/ubertc-aarch64-4.9/bin/aarch64-linux-android-
# Cleanup
make clean && make mrproper
# J530Y Config
make 
make 
# Make zImage
make ARCH=arm64 -j4
./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb
# Generate Boot_J530Y.img
./makeimg_j530y.sh

echo J530Y Kernel Done