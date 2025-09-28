#!/bin/bash
set -e  # Para em qualquer erro

echo "
 /$$   /$$ /$$$$$$$$ /$$$$$$$$ /$$      /$$  /$$$$$$  /$$$$$$$  /$$   /$$
| $$$ | $$| $$_____/|__  $$__/| $$  /$ | $$ /$$__  $$| $$__  $$| $$  /$$/
| $$$$| $$| $$         | $$   | $$ /$$$| $$| $$  \ $$| $$  \ $$| $$ /$$/ 
| $$ $$ $$| $$$$$      | $$   | $$/$$ $$ $$| $$  | $$| $$$$$$$/| $$$$$/  
| $$  $$$$| $$__/      | $$   | $$$$_  $$$$| $$  | $$| $$__  $$| $$  $$  
| $$\  $$$| $$         | $$   | $$$/ \  $$$| $$  | $$| $$  \ $$| $$\  $$ 
| $$ \  $$| $$$$$$$$   | $$   | $$/   \  $$|  $$$$$$/| $$  | $$| $$ \  $$
|__/  \__/|________/   |__/   |__/     \__/ \______/ |__/  |__/|__/  \__/
                                                                         
                                                                         
                                                                         
 /$$      /$$  /$$$$$$  /$$   /$$ /$$$$$$ /$$$$$$$$ /$$$$$$  /$$$$$$$    
| $$$    /$$$ /$$__  $$| $$$ | $$|_  $$_/|__  $$__//$$__  $$| $$__  $$   
| $$$$  /$$$$| $$  \ $$| $$$$| $$  | $$     | $$  | $$  \ $$| $$  \ $$   
| $$ $$/$$ $$| $$  | $$| $$ $$ $$  | $$     | $$  | $$  | $$| $$$$$$$/   
| $$  $$$| $$| $$  | $$| $$  $$$$  | $$     | $$  | $$  | $$| $$__  $$   
| $$\  $ | $$| $$  | $$| $$\  $$$  | $$     | $$  | $$  | $$| $$  \ $$   
| $$ \/  | $$|  $$$$$$/| $$ \  $$ /$$$$$$   | $$  |  $$$$$$/| $$  | $$   
|__/     |__/ \______/ |__/  \__/|______/   |__/   \______/ |__/  |__/   
                                                                         
                                                                    By Satoshi Yamazaki
                                                                         "

echo "

=== Atualizando pacotes ===


"
sudo apt update && sudo apt upgrade -y

echo "=== Instalando Python e ferramentas ==="
sudo apt install -y python3 python3-venv python3-pip

echo "

=== Instalando Snap ===


"
sudo apt install -y snapd
sudo systemctl enable snapd
sudo systemctl start snapd

echo "

=== Instalando Firefox ===


"
sudo apt install -y firefox

echo "

=== Instalando AnyDesk ===


"
# Baixar e instalar pacote oficial do AnyDesk
wget -qO anydesk.deb https://download.anydesk.com/linux/anydesk_7.1.0-1_amd64.deb
sudo apt install -y ./anydesk.deb
rm -f anydesk.deb

echo "

=== Instalando Featherpad (editor de texto) ===


"
sudo apt install -y featherpad

echo "

=== Instalando SQLite e DB Browser ===


"
sudo apt install -y sqlite3 sqlitebrowser

echo "

=== Criando virtualenv e instalando Flask ===


"
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask

echo "

=== Preparando pastas de logs ===


"
mkdir -p logs

echo "=== Criando serviço systemd para monitor ==="

SERVICE_FILE="/etc/systemd/system/monitor-ping.service"
PROJECT_DIR="$(pwd)"  # assume que você está na raiz do projeto
USER_NAME=$(whoami)

sudo bash -c "cat > $SERVICE_FILE <<EOF
[Unit]
Description=Monitor de Ping
After=network.target

[Service]
Type=simple
User=$USER_NAME
WorkingDirectory=$PROJECT_DIR
ExecStart=$PROJECT_DIR/venv/bin/python $PROJECT_DIR/app.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
"

echo "=== Recarregando systemd ==="
sudo systemctl daemon-reload

echo "=== Ativando serviço para iniciar junto com o sistema ==="
sudo systemctl enable monitor-ping.service

echo "=== Iniciando serviço agora ==="
sudo systemctl start monitor-ping.service

echo "=== Status do serviço ==="
sudo systemctl status monitor-ping.service --no-pager

echo "=== Setup finalizado ==="
echo "Para iniciar a aplicação:"
echo "1. source venv/bin/activate"
echo "2. python app.py"


echo "
  /$$$$$$  /$$           /$$           /$$                       /$$$  
 /$$__  $$|__/          |__/          | $$                      |_  $$ 
| $$  \__/ /$$ /$$$$$$$  /$$  /$$$$$$$| $$$$$$$        /$$        \  $$
| $$$$    | $$| $$__  $$| $$ /$$_____/| $$__  $$      |__/         | $$
| $$_/    | $$| $$  \ $$| $$|  $$$$$$ | $$  \ $$                   | $$
| $$      | $$| $$  | $$| $$ \____  $$| $$  | $$       /$$         /$$/
| $$      | $$| $$  | $$| $$ /$$$$$$$/| $$  | $$      |__/       /$$$/ 
|__/      |__/|__/  |__/|__/|_______/ |__/  |__/                |___/  
                                                                       
                                                                       
                                                                       "