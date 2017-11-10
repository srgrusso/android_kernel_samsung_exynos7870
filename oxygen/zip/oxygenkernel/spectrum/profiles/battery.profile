   #Cpu Tweaks
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 1248000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   
   #Samsung Hotplug
   chmod 644 /sys/power/cpuhotplug/enable
   echo 0 > /sys/power/cpuhotplug/enable
  
	#ThunderPlug Hotplug
   chmod 644 /sys/kernel/thunderplug/hotplug_enabled
   echo 1 > /sys/kernel/thunderplug/hotplug_enabled
   
   #Gpu Tweaks
   chmod 644 /sys/devices/11400000.mali/max_clock
   echo 728 > /sys/devices/11400000.mali/max_clock
   chmod 644 /sys/devices/11400000.mali/min_clock
   echo 343 > /sys/devices/11400000.mali/min_clock
   
   #Internal I/O Scheduler tweaks
   chmod 644 /sys/block/mmcblk0/queue/scheduler
   echo "maple" > /sys/block/mmcblk0/queue/scheduler
   chmod 644 /sys/block/mmcblk0/queue/read_ahead_kb
   echo "512" > /sys/block/mmcblk0/queue/read_ahead_kb

   #External I/O Scheduler tweaks
   chmod 644 /sys/block/mmcblk1/queue/scheduler
   echo "maple" > /sys/block/mmcblk1/queue/scheduler
   chmod 644 /sys/block/mmcblk1/queue/read_ahead_kb
   echo "512" > /sys/block/mmcblk1/queue/read_ahead_kb
   
   #FSYNC
   echo "Y" > /sys/module/sync/parameters/fsync_enabled
