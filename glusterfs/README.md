# GlusterFS

## Installation

Run the glusterfs_install.sh script, and pass the device name as an argument.

For example, to install with the brick on /dev/sdb, run:
```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_scripts/master/glusterfs/glusterfs_install.sh | sh -s sdb
```

The above needs to be run on every server.

## Volume Provisioning

### Simple Replicated Volume

This works like a 3 way mirror of the data.  Minimum of three is recommended to allow a majority and avoid split brain issues.

Then run these (example) commands on the first server:

```sh
gluster peer probe server2
gluster peer probe server3
gluster volume create gvol1 replica 3 transport tcp \
    server{1..3}:/bricks/brick
gluster volume start gvol1

# NFS performs better than FUSE
gluster volume set gvol1 auth.allow 10.0.0.*
gluster volume set gvol1 nfs.disable off
gluster volume set gvol1 nfs.export-volumes on
```

Where 10.0.0.* is the address range where your clients will be connecting from.

### Striped Volume Example

This is like a RAID5 of gluster nodes.  Data is striped and paritied across all nodes in the cluster.  The total number of nodes should be equally divisible by the stripe count.  Nodes can be added in quantities equal to the stripe count.

This example uses 12 nodes, with a stipe count of 3.  Nodes can be added 3 at a time.

```sh
gluster peer probe server{2..12}
gluster volume create gvol1 stripe 3 transport tcp \
    server{1..12}:/bricks/brick
gluster volume start gvol1

# NFS performs better than FUSE
gluster volume set gvol1 auth.allow 10.0.0.*
gluster volume set gvol1 nfs.disable off
gluster volume set gvol1 nfs.export-volumes on
```

## Mounting the Volume

Mount just like any NFS volume at server:/volumename

```sh
echo "server1:/gvol1                    /data                   nfs     rw,hard,rsize=8192,wsize=8192,_netdev,tcp,vers=3   0 0" >> /etc/fstab
mount -a
```
