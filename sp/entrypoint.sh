#!/bin/bash

echo "Güncellemeler yükleniyor ve curl kuruluyor..."
# apt-get update && apt-get install -y curl

WAITER_URL="http://localhost:4441"
WAIT_INTERVAL=5

# DLL parametresi alınıyor
DLL_FILE="$1"

if [ -z "$DLL_FILE" ]; then
  echo "HATA: Çalıştırılacak DLL dosyası belirtilmedi!"
  echo "Kullanım: entrypoint.sh <dll-dosyası>"
  exit 1
fi

echo "Servisler hazır olana kadar bekleniyor..."

while true; do
  if curl --silent --fail "$WAITER_URL" > /dev/null; then
    echo "Bağlı servisler hazır. Uygulama başlatılıyor: $DLL_FILE"
    break
  else
    echo "Bekleniyor... ($WAIT_INTERVAL saniye)"
    sleep $WAIT_INTERVAL
  fi
done

exec dotnet "$DLL_FILE"
