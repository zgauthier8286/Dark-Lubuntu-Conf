#!/bin/bash


vgause=`cat /sys/kernel/debug/vgaswitcheroo/switch | grep IGD:+`


#Change permitions
#chmod 777 /opt/ucc/
#chmod 777 /opt/ucc/*

#Clear text file
rm -r /opt/ucc/vga.txt


#Verify actual state

if [ -f $vgause ]
then
   echo 'Dedicated Graphics' >> /opt/ucc/vga.txt
#Send notification
	notify-send -t 5000 -i /usr/share/icons/redtri.png "Dedicated Graphics"

else
   echo 'Integrated Graphics' >> /opt/ucc/vga.txt
#Send notification
	notify-send -t 5000 -i /usr/share/icons/bluetri.png "Integrated Graphics"

fi

echo OFF > /sys/kernel/debug/vgaswitcheroo/switch


