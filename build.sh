#!/bin/bash
RDIR=$(pwd)
# Oxygen Kernel build script by SiddhantNaik 

#~~~~~~~~
# Values 
#~~~~~~~~
export ARCH=arm64
export CROSS_COMPILE=~/Toolchains/aarch64-cortex_a53-linux-gnueabi/bin/aarch64-cortex_a53-linux-gnueabi-
export ANDROIDVERSION=N
DEVICE='J7 Prime'
DEFCONFIG=Oxygen_on7xelte_defconfig
ZIPNAME=Oxygen.G610x.v$(<oxygen/version).zip
DTSFILES="exynos7870-on7xelte_swa_open_00 exynos7870-on7xelte_swa_open_01 exynos7870-on7xelte_swa_open_02"

#~~~~~~~~~~~~~~~~
# Clean Remnants
#~~~~~~~~~~~~~~~~
rm -rf oxygen/build.log
rm -rf oxygen/zip/z*
rm -rf oxygen/zip/*.zip
rm -rf oxygen/zip/boot.img
rm -rf oxygen/ramdisk/split_img/boot.img-zImage
rm -rf oxygen/ramdisk/split_img/boot.img-dtb
rm -rf oxygen/zip/oxygenkernel/anykernel2/anykernel2.zip
clear

#~~~~~~~~~~~
# Show Logo
#~~~~~~~~~~~
echo "     XYGEN     EN      OX   ENO     OXY   GENOXY    YGENOXYGEN   OXYG    YG"
echo "    ENOXYGE     GE    GE    YGEN   GEN   OXYGENO    NOXYGENOXY   GENOX   OX"
echo "   XYG   XYG     YG  OX       YGE  XY   EN          EN           YG NO   EN"
echo "   NO     OX      XYG           YGEN    YG          YG           OX  EN  YG"
echo "   GE     EN      NOX            XYG    OX    OX    OXYGENOXYG   EN  YG  OX"
echo "   XY     YG     YGENO           NOX    ENO   EN    EN           YG   XY EN"
echo "   NOX   NOX    NOX  EN          GEN     GE   YG    YG           OX   NOXYG"
echo "    ENOXYGE     GE    GE         XYG      XYGENO    OXYGENOXYE   EN    ENOX"
echo "     GENOX     OX      GY        NOX       OXYGE    ENOXYGENOX   YG    YGEN"
echo ""
echo "                     A CUSTOM KERNEL BY SIDDHANT NAIK                      "
echo ""

#~~~~~~~~~~~~~~~~~~~
# Start Build Image
#~~~~~~~~~~~~~~~~~~~
(
echo "Starting To Build Oxygen Kernel v$(<oxygen/version) For $DEVICE"
echo ""
make $DEFCONFIG
time make -j`grep processor /proc/cpuinfo|wc -l`
echo ""

#~~~~~~~~~~~~~~~~~
# Start Build DTB (with referance to script by djb77 and tkkg1994)
#~~~~~~~~~~~~~~~~~
mkdir -p $RDIR/arch/arm64/boot/dtb && cd $RDIR/arch/arm64/boot/dtb && rm -rf *
echo "Starting DTB process"
for dts in $DTSFILES; do
	echo "=> Processing: ${dts}.dts"
	${CROSS_COMPILE}cpp -nostdinc -undef -x assembler-with-cpp -I "$RDIR/include" "$RDIR/arch/arm64/boot/dts/${dts}.dts" > "${dts}.dts"
	echo "=> Generating: ${dts}.dtb"
	$RDIR/scripts/dtc/dtc -p 0 -i "$RDIR/arch/arm64/boot/dts" -O dtb -o "${dts}.dtb" "${dts}.dts"
done
echo ""
echo "Generating dtb.img"
$RDIR/scripts/dtbTool/dtbTool -o "$RDIR/arch/arm64/boot/dtb.img" -d "$RDIR/arch/arm64/boot/dtb/" -s 2048
echo ""
echo "DTB Generated"
echo ""

#~~~~~~~~~~~~~~~~~
# Start Build Zip (with referance to script by djb77 and tkkg1994)
#~~~~~~~~~~~~~~~~~
mv $RDIR/arch/arm64/boot/Image $RDIR/oxygen/ramdisk/split_img/boot.img-zImage
mv $RDIR/arch/arm64/boot/dtb.img $RDIR/oxygen/ramdisk/split_img/boot.img-dtb
cd $RDIR/oxygen/ramdisk
./repackimg.sh
echo SEANDROIDENFORCE >> image-new.img
mv image-new.img $RDIR/oxygen/zip/boot.img
echo ""
echo "Building AnyKernel2 Zip File"
cd $RDIR/oxygen/anykernel2
zip -gq anykernel2.zip -r * -x "*~"
mv anykernel2.zip $RDIR/oxygen/zip/oxygenkernel/anykernel2/anykernel2.zip
echo ""
echo "Building Zip File"
cd $RDIR/oxygen/zip
zip -gq $ZIPNAME -r * -x "*~"
mv -f $ZIPNAME $RDIR/oxygen/$ZIPNAME
cd $RDIR
echo ""
echo "Oxygen Kernel v$(<oxygen/version) for $DEVICE is successfully built!"
echo ""
) 2>&1	 | tee -a oxygen/build.log
