# docker_install.sh
Installs docker community edition on Centos 7, using Docker's repo

# standalone_network.sh
Creates a bridge network called docker1, and enables packet forwarding in the kernel.

Make sure you specicify the network you want to use.

In addition, you'll need to configure your network with a route with destination of the docker network, and a via/next-hop address of the host.

Example:
- Docker host IP address: 192.168.0.10
- Docker bridge network: 10.0.0.0/24
- Add this route to your network: ip route add 10.0.0.0/24 via 192.168.0.10
- Container configuration: docker run --net docker1 --ip 10.0.0.10
