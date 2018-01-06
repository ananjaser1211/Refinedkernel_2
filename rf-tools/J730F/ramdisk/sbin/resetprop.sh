#!/system/bin/sh

# KNOX warranty status
if [ "$(getprop ro.boot.warranty_bit)" != "0" ] || [ "$(getprop ro.warranty_bit)" != "0" ]; then
	/sbin/resetprop -v -n ro.boot.warranty_bit 0;
	/sbin/resetprop -v -n ro.warranty_bit 0;
fi;