## Docker-Dev ##

This is a set of scripts that build images with some helpful development tools (compilers, network utilities, editors, remote capturing and piping).

These images have the following packages installed:

 - gcc, g++, make, automake, etc. (so we can build stuff)
 - perl/python (for scripting)
 - net-tools (for ifconfig)
 - iputils-ping (for ping)
 - iptables (for firewall testing)
 - wireshark (for network captures)
 - vi (because, just do it)

### To run wireshark on OS X but targeting these images ###

Launch your instance with `--cap-add ALL`

From your host machine, run:

```bash
mkfifo /tmp/sharkfin && wireshark -k -i /tmp/sharkfin; rm /tmp/sharkfin
```

From your host machine in a different window, run:

```bash
docker exec -i <instance_name> /usr/bin/dumpcap -i eth0 -Ppw- -f 'ip' > /tmp/sharkfin
```
