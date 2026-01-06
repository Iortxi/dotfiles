#!/bin/bash

# Check user NOT root
if [ $UID -eq 0 ]; then
  echo "[!] Do not execute this as root"
  exit 1
fi


# System update
sudo apt update && sudo apt upgrade -y


# Packet installation
sudo apt install -y bat lsd console-data htop micro socat lsof docker.io zsh \
apt-show-versions python3-pip python3-pyftpdlib nmap tor proxychains tmux \
docker-compose minidlna python3-fastapi python3-pwntools python3-uvicorn xclip \
tree


# User in docker group
sudo usermod -aG docker "$USER"


# Shell (Bash) and prompt
sudo chsh -s /usr/bin/bash "$USER"
sudo chsh -s /bin/bash root
pip install powerline-shell --break-system-packages
sudo pip install powerline-shell --break-system-packages
cp shell/.bashrc ~
sudo cp /root/.bashrc /root/.bashrc.backup
sudo rm -f /root/.bashrc
sudo ln -s /home/"$USER"/.bashrc /root
mkdir -p ~/.config/powerline-shell
cp shell/config.json ~/.config/powerline-shell
sudo ln -s /home/"$USER"/.local/bin/powerline-shell /usr/bin/powerline-shell


# Minidlna
mkdir -p /mnt/videos
sudo cp minidlna/minidlna.conf /etc/
sudo chown -R minidlna:minidlna /mnt/videos
sudo chmod -R 755 /mnt/videos
sudo systemctl start minidlna
sudo systemctl enable minidlna


# Tmux
cp tmux/.tmux.conf ~
tmux source-file ~/.tmux.conf
