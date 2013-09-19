#!/bin/bash


#Changing folder permitions
gksu chmod 777 /sys/kernel/debug/vgaswitcheroo/switch

#Send notification
notify-send -t 5000 -i /usr/share/icons/bluetri.png "integrated Graphics" "Session will restart in 5sec"

#Manage vga-switchero

echo ON > /sys/kernel/debug/vgaswitcheroo/switch
sleep 5
echo DIGD > /sys/kernel/debug/vgaswitcheroo/switch
#sleep 10
#echo OFF > /sys/kernel/debug/vgaswitcheroo/switch
         
