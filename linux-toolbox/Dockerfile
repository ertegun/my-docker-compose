FROM ubuntu:22.04

# Gerekli paketleri yükle (Zeek + Squid + iptables)
# RUN apt update && apt install -y \
#   cmake make gcc g++ flex bison libpcap-dev libssl-dev python3-dev \
#   swig zlib1g-dev curl vim git python3-pip iptables iproute2 squid supervisor

# # Zeek'i indir ve derle
# RUN git clone --recursive https://github.com/zeek/zeek /opt/zeek \
#   && cd /opt/zeek \
#   && ./configure --prefix=/usr/local/zeek \
#   && make -j$(nproc) \
#   && make install

# ENV PATH="/usr/local/zeek/bin:$PATH"

# # Squid Proxy için konfigürasyon dosyasını ekle
# COPY squid.conf /etc/squid/squid.conf

# # DPI Bypass betiğini ekleyelim
# COPY dpi_bypass.sh /dpi_bypass.sh
# RUN chmod +x /dpi_bypass.sh

# # Konteyner başlatıldığında DPI Bypass + Proxy başlat
# CMD ["/dpi_bypass.sh"]
