#!/bin/sh
# !! run as root only one time !!

# SWAPPING DEAKTIVIEREN
# leert den Swapspeicher
swapoff --all
# stoppt den Swap-Dienst 
service dphys-swapfile stop
# deaktiviert den Dienst des Swapping
systemctl disable dphys-swapfile
# entfernt den Dienst vom System
apt-get purge dphys-swapfile

# Logs in RAM auslagern
echo 'tmpfs	/var/log	tmpfs	defaults,noatime,nosuid,mode=0755,size=200M	0	0' >> /etc/fstab

# BlueTooth deaktivieren (ca. 10mA Stromersparnis)
# Einstellung in /boot/config.txt eintragen
echo '# disable BlueTooth' >> /boot/config.txt
echo 'dtoverlay=disable-bt' >> /boot/config.txt
# BlueTooth dienste stoppen
systemctl disable hciuart.service
systemctl disable bluealsa.service
systemctl disable bluetooth.service

# Interne LEDs deaktivieren (ca. 5mA pro LED Stromersparnis)
# Einstellung in /boot/config.txt eintragen
echo '# disable Power-LED' >> /boot/config.txt
echo 'dtparam=pwr_led_trigger=none' >> /boot/config.txt
echo 'dtparam=pwr_led_activelow=off' >> /boot/config.txt
echo '# disable Aktion-LED' >> /boot/config.txt
echo 'dtparam=act_led_trigger=none' >> /boot/config.txt
echo 'dtparam=act_led_activelow=off' >> /boot/config.txt

# WLAN deaktivieren (ca. 30mA Stromersparnis)
# Einstellung in /boot/config.txt eintragen
echo '# disable WLAN' >> /boot/config.txt
echo 'dtoverlay=disable-wifi' >> /boot/config.txt
# BlueTooth dienste stoppen
systemctl disable wpa_supplicant.service

# IPv6 deaktivieren
echo '# Disable IPv6' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf

# USB und LAN deaktivieren (ca. 200mA Stromersparnis) 
# ! unkommtieren wernn benötigt !
# USB & LAN Abschalten:
#echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
# USB & LAN Einschalten:
#echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/bind
