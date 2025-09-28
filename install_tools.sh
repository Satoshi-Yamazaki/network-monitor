#!/bin/bash
set -e  # Para em qualquer erro

echo "=== Atualizando pacotes ==="
sudo apt update && sudo apt upgrade -y

echo "=== Instalando Python e ferramentas ==="
sudo apt install -y python3 python3-venv python3-pip

echo "=== Instalando Snap ==="
sudo apt install -y snapd
sudo systemctl enable snapd
sudo systemctl start snapd

echo "=== Instalando Speedtest via Snap ==="
sudo snap install speedtest

echo "=== Rodando Speedtest uma vez para aceitar os termos ==="
speedtest --accept-license --accept-gdpr || true

echo "=== Instalando Chromium Browser ==="
sudo apt install -y chromium-browser

echo "=== Instalando AnyDesk ==="
# Baixar e instalar pacote oficial do AnyDesk
wget -qO anydesk.deb https://download.anydesk.com/linux/anydesk_7.1.0-1_amd64.deb
sudo apt install -y ./anydesk.deb
rm -f anydesk.deb

echo "=== Instalando Featherpad (editor de texto) ==="
sudo apt install -y featherpad

echo "=== Instalando SQLite e DB Browser ==="
sudo apt install -y sqlite3 sqlitebrowser

echo "=== Criando virtualenv e instalando Flask ==="
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask

echo "=== Preparando pastas de logs ==="
mkdir -p logs

echo "=== Setup finalizado ==="
echo "Para iniciar a aplicação:"
echo "1. source venv/bin/activate"
echo "2. python app.py"
