#!/sbin/sh

# Setup networking when boot starts
ifconfig eth0 10.0.2.15 netmask 255.255.255.0 up
route add default gw 10.0.2.2 dev eth0
