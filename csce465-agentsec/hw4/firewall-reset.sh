#!/bin/bash
modprobe br_netfilter
sysctl -w net.bridge.bridge-nf-call-iptables=1

# disconnect the custom chain from the DOCKER-USER chain if present
iptables -D DOCKER-USER -j HW4-POLICY 2>/dev/null

# flush and delete the custom chain
iptables -F HW4-POLICY 2>/dev/null
iptables -X HW4-POLICY 2>/dev/null