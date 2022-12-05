echo Add swap space

if [ ! -n "$1" ]; then
    echo "Must setup swap file size. Unit: 1M."
        exit 1
fi

if [ -f "/root/swapfile.sys" ]; then
    echo "Swapfile: /root/swapfile existed"
        exit 2
fi

dd if=/dev/zero of=/root/swapfile.sys bs=1M count=$1
mkswap /root/swapfile.sys
chmod 0600 /root/swapfile.sys
swapon -a /root/swapfile.sys

echo /root/swapfile.sys swap swap defaults 0 0 >> /etc/fstab
swapon -s
