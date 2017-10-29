#!/bin/bash
RDIR=$(pwd)

export ARCH=arm64
export CROSS_COMPILE=~/Toolchains/aarch64-cortex_a53-linux-gnueabi/bin/aarch64-cortex_a53-linux-gnueabi-
make clean
make mrproper
rm -rf oxygen/build.log
rm -rf oxygen/zip/z*
rm -rf oxygen/zip/*.zip
rm -rf oxygen/zip/boot.img
rm -rf oxygen/ramdisk/split_img/boot.img-zImage
rm -rf oxygen/ramdisk/split_img/boot.img-dtb
rm -rf oxygen/zip/oxygenkernel/anykernel2/anykernel2.zip
