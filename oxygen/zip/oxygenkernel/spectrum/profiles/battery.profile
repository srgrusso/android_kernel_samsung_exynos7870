   #Cpu Tweaks
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 1248000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   
   #Hotplug Samsung
   chmod 644 /sys/power/cpuhotplug/enable
   echo 1 > /sys/power/cpuhotplug/enable
   
   #Gpu Tweaks
   chmod 644 /sys/devices/11400000.mali/max_clock
   echo 728 > /sys/devices/11400000.mali/max_clock
   chmod 644 /sys/devices/11400000.mali/min_clock
   echo 343 > /sys/devices/11400000.mali/min_clock
   
   #I/O Scheduler tweaks (internal)
   chmod 644 /sys/block/mmcblk0/queue/scheduler
   echo "maple" > /sys/block/mmcblk0/queue/scheduler
   chmod 644 /sys/block/mmcblk0/queue/read_ahead_kb
   echo "512" > /sys/block/mmcblk0/queue/read_ahead_kb

   # Set I/O Scheduler tweaks (external)
   chmod 644 /sys/block/mmcblk1/queue/scheduler
   echo "maple" > /sys/block/mmcblk1/queue/scheduler
   chmod 644 /sys/block/mmcblk1/queue/read_ahead_kb
   echo "512" > /sys/block/mmcblk1/queue/read_ahead_kb
   
   #FSYNC
   echo "Y" > /sys/module/sync/parameters/fsync_enabled
