# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers
# With reference to @djb77 script
# By @Siddhant Naik 
# Do Not Use Without My Permission!!
# (C) @Siddhant Naik

## AnyKernel setup
# Begin Properties
properties() {
kernel.string=Oxygen Kernel by Siddhant Naik
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=1
} # end properties

# Shell Variables
block=/dev/block/platform/13540000.dwmmc0/by-name/BOOT;
is_slot_device=0;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# Oxygen Kernel Scripts
ui_print "Injecting Oxygen Kernel Scripts";
replace_file sbin/resetprop 755 sbin/resetprop;
replace_file sbin/initd.sh 755 sbin/initd.sh;
replace_file sbin/kernelinit.sh 755 sbin/kernelinit.sh;
replace_file sbin/wakelock.sh 755 sbin/wakelock.sh;
replace_file init.services.rc 755 init.services.rc;
insert_line init.rc "import /init.services.rc" after "import /init.fac.rc" "import /init.services.rc";

# Install Spectrum
if egrep -q "install=1" "/tmp/aroma/spectrum.prop"; then
	ui_print "Installing Spectrum";
	replace_file sbin/spa 755 spectrum/spa;
	replace_file init.spectrum.rc 644 spectrum/init.spectrum.rc;
	replace_file init.spectrum.sh 644 spectrum/init.spectrum.sh;
	insert_line init.rc "import /init.spectrum.rc" after "import /init.services.rc" "import /init.spectrum.rc";
fi;

# Ramdisk changes - SELinux (Fake) Enforcing Mode
if egrep -q "install=1" "/tmp/aroma/selinux.prop"; then
	ui_print "Setting SELinux Enforcing Mode";
	replace_string sbin/kernelinit.sh "echo \"1\" > /sys/fs/selinux/enforce" "echo \"0\" > /sys/fs/selinux/enforce" "echo \"1\" > /sys/fs/selinux/enforce";
fi;

# End ramdisk changes
write_boot;

## End install
