#!/bin/bash

# Check user NOT root
if [ $UID -eq 0 ]; then
  echo "[!] Do not execute this as root"
  exit 1
fi


# System update
pkg update && pkg upgrade -y


# Packet installation
pkg install -y bat micro lsd python3 python3-pip python3-pyftpdlib nmap tmux \
tor proxychains python3-fastapi python3-uvicorn tree zsh htop socat


# Termux boot
mkdir -p ~/.termux/boot
cp boot/boot.sh ~/.termux/boot


# Proxychains config file
ln -s /data/data/com.termux/files/usr/etc/proxychains.conf ~/proxychains.conf


# Shell (Bash) and prompt
sudo chsh -s /usr/bin/bash "$USER"
sudo chsh -s /bin/bash root
pip install powerline-shell --break-system-packages
sudo pip install powerline-shell --break-system-packages
cp shell/.bashrc ~
sudo cp /root/.bashrc /root/.bashrc.backup
sudo rm -f /root/.bashrc
sudo ln -s /home/"$USER"/.bashrc /root
cp shell/config.json ~/.config/powerline-shell
sudo ln -s /home/"$USER"/.local/bin/powerline-shell /usr/bin/powerline-shell


# Tmux
cp tmux/.tmux.conf ~
tmux source-file ~/.tmux.conf
