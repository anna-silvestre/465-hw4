#!/bin/bash
modprobe br_netfilter
sysctl -w net.bridge.bridge-nf-call-iptables=1

# estblished and related connections are allowed
iptables -A DOCKER-USER -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# allow agent-node to talk to web-lab on TCP 8000
iptables -A DOCKER-USER -s 172.30.0.10 -d 172.30.0.40 -p tcp --dport 8000 -j ACCEPT

# monitor and do not permit agent-node to talk to mock-c2 on TCP 8080
iptables -A DOCKER-USER -s 172.30.0.10 -d 172.30.0.66 -p tcp --dport 8080 -j conntrack --ctstate NEW -j LOG --log-prefix "HW4-C2-DROP: "
iptables -A DOCKER-USER -s 172.30.0.10 -d 172.30.0.66 -p tcp --dport 8080 -j DROP

# default-deny all other traffic to agent-node
iptables -A DOCKER-USER -d 172.30.0.10 -j DROP
