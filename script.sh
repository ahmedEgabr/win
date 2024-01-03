#!/usr/bin/env bash
read -p "Please Enter your SSD Disk " SSD
read -p "Please Enter your storage passowrd " PASS

apt install tmux -y
dd if=/dev/zero of=$SSD bs=1M count=1
partprobe
mount -t tmpfs -o size=5500m tmpfs /mnt
wget -P /mnt ftp://u384119:$PASS@u384119.your-storagebox.de/win8.1n.iso
wget -qO- /tmp http://www.danpros.com/content/files/vkvm.tar.gz | tar xvz -C /tmp
tmux new -d '/tmp/qemu-system-x86_64 -net nic -net user,hostfwd=tcp::3389-:3389 -m 2048M -localtime -enable-kvm -cpu host,+nx -M pc -smp 2 -vga std -usbdevice tablet -k en-us -cdrom /mnt/win8.1n.iso -hda $SSD -boot once=d -vnc :1'
