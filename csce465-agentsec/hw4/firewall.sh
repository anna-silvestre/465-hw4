#!/bin/bash
modprobe br_netfilter
sysctl -w net.bridge.bridge-nf-call-iptables=1

# custom chain for clean separation of HW4 policy
iptables -N HW4-POLICY 2>/dev/null || iptables -F HW4-POLICY

# insert the custom chain into the DOCKER-USER chain if not already present
iptables -C HW4-POLICY -j HW4-POLICY 2>/dev/null || iptables -I DOCKER-USER 1 -j HW4-POLICY

# allow established and related return traffic
iptables -A HW4-POLICY -m state --state ESTABLISHED,RELATED -j ACCEPT

# allow agent-node to reach web-lab on TCP 8000
iptables -A HW4-POLICY -s 172.30.0.10 -d 172.30.0.40 -p tcp --dport 8000 -j ACCEPT

# log and drop new connections from agent-node to mock-c2 on TCP 8080
iptables -A HW4-POLICY -s 172.30.0.10 -d 172.30.0.66 -p tcp --dport 8080 -m state --state NEW -j LOG --log-prefix "HW4-C2-DROP: "
iptables -A HW4-POLICY -s 172.30.0.10 -d 172.30.0.66 -p tcp --dport 8080 -m state --state NEW -j DROP

# drop other new forwarded connections from agent-node
iptables -A HW4-POLICY -s 172.30.0.10 -j DROP

# leave unrelated Docker traffic unchanged