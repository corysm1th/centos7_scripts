#!/bin/sh
if [ -z $1 ]; then
    echo "Usage: glusterfs_install.sh DEVICE... where device is \"sda\" | \"sdb\" | etc"
fi

yum install -y centos-release-gluster
yum install -y glusterfs-server glusterfs-gnfs
systemctl enable glusterd
systemctl start glusterd
parted -a optimal /dev/${1} --script mklabel gpt mkpart primary xfs 0% 100%
mkfs.xfs /dev/${1}1
mkdir /bricks
echo "/dev/${1}     /bricks     xfs       defaults    0 0" >> /etc/fstab
mount -a
mkdir /bricks/brick
