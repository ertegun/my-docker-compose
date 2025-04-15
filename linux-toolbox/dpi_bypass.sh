#!/bin/bash

# Ağ Arayüzünü Tespit Et
INTERFACE=$(ip -o link show | awk -F': ' '{print $2}' | grep -E 'eth|en' | head -n1)
echo "Using interface: $INTERFACE"

# Zeek DPI Analizini Başlat
zeek -i $INTERFACE &

# Squid Proxy'yi Başlat
service squid start

# 1️⃣ **DPI Tarafından Görülebilen SNI'yi Gizle**
iptables -t mangle -A PREROUTING -p tcp --dport 443 -j DROP
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8443

# 2️⃣ **Paketleri Fragment Ederek DPI'dan Kaçırma**
iptables -A OUTPUT -p tcp --dport 443 -m length --length 64:1500 -j DROP
iptables -A OUTPUT -p tcp --dport 443 -j TOS --set-tos 0x10

# 3️⃣ **Fake SNI Gönderme (Discord yerine başka bir domain)**
iptables -t nat -A OUTPUT -p tcp --dport 443 -j DNAT --to-destination 104.16.248.249:443  # cloudflare.com

# 4️⃣ **MSS ve MTU Değerlerini Değiştirerek DPI Tespitini Engelle**
iptables -t mangle -A POSTROUTING -p tcp --dport 443 -j TCPMSS --set-mss 1300

# 5️⃣ **Proxy Portunu Aç ve NAT Yönlendirmesi Yap**
iptables -t nat -A POSTROUTING -o $INTERFACE -j MASQUERADE

echo "DPI Bypass Aktif! Squid Proxy dış dünyaya açıldı!"

# Sonsuz Döngüde Çalışmayı Sürdür
tail -f /dev/null
