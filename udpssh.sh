#!/bin/bash

cd
mkdir -p /root/udp

# change to time GMT+7
# ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

# install udp-custom
echo downloading udp-custom
wget -q --show-progress https://github.com/imnotdev25/firessh/raw/main/udpssh/udp-custom

echo downloading default config
wget -q --show-progress https://github.com/imnotdev25/firessh/raw/main/udpssh/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom 

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom 

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=15s

[Install]
WantedBy=default.target
EOF
fi

echo start service udp-custom
systemctl start udp-custom &>/dev/null

echo enable service udp-custom
systemctl enable udp-custom &>/dev/null

echo reboot
