#!/bin/bash

# Ağ Arayüzünü Belirle
INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'eth|en' | head -n1)
echo "Using interface: $INTERFACE"

# Zeek'i başlat
zeek -i $INTERFACE &

# Squid Proxy'yi başlat
service squid start

# NAT ve IP Forwarding Kuralları
iptables -t nat -A POSTROUTING -o $INTERFACE -j MASQUERADE
iptables -A FORWARD -i eth0 -o $INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $INTERFACE -o eth0 -j ACCEPT

# Sonsuz döngüde çalışmayı sürdür
tail -f /dev/null
