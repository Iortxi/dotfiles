#!/bin/bash


# Check user NOT root
if [ $UID -eq 0 ]; then
  echo "[!] Do not execute this as root"
  exit 1
fi


# Browser selector
navegadores=("Firefox ESR" "Google Chrome")
num_navegadores="${#navegadores[@]}"

# Option panel
for i in "${!navegadores[@]}"; do
  echo "[$i] ${navegadores[$i]}"
done
echo

declare -i navegador
echo -n "[?] Select a browser to install (number): "
read navegador

# Option check, browser number in "navegador"
while true; do
  if [ $navegador -lt 0 -o $navegador -ge $num_navegadores ]; then
    break
  else
    echo
    echo -n "[!] You must select a valid browser to install (number): "
    read navegador
  fi
done


# Icono de bateria del systray para portatiles (-l -> labtop)
if [ -n "$1" -a "$1" == "-l" ]; then
  sed -i 's/#cbatticon -u 5 &/cbatticon -u 5 &/g' .config/qtile/autostart.sh
  sed -i 's/#cbatticon -u 5 &/cbatticon -u 5 &/g' .config/spectrwm/autostart.sh
fi


# System update
sudo apt update && sudo apt upgrade -y


# Packet installation
sudo apt install -y spectrwm pamixer bat lsd console-data feh rofi picom htop \
cbatticon pasystray flameshot micro thunar pavucontrol arandr kcalc vlc socat \
brightnessctl apt-show-versions pulseaudio-utils docker.io lsof python3-pip git \
python3-pyftpdlib nmap tor proxychains docker-compose


# Usuario en grupo docker
sudo usermod -aG docker "$USER"


# Spanish keyboard
sudo setxkbmap -layout 'es,es' -model latin1


# Python dependencies
pip install termcolor --break-system-packages


# Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/Obsidian-1.7.7.AppImage -O obsidian
chmod +x obsidian
sudo mv obsidian /usr/bin


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


# Spectrwm
sudo cp configs/spectrwm.conf /etc/
sudo cp configs/spectrwm.desktop /usr/share/xsessions


# Qtile
sed -i 's/iortxi/$USER/g' .config/qtile/scripts/qtile.sh
pip install qtile --break-system-packages
sudo pip install qtile --break-system-packages
sed -i 's/qtile start/\/home\/$USER\/.config\/qtile\/scripts\/qtile.sh/g' configs/qtile.desktop
sudo cp configs/qtile.desktop /usr/share/xsessions
sudo ln -s /home/$USER/.local/bin/qtile /usr/bin/qtile


# Fonts: 'UbuntuMono Nerd Font' and 'Hack Nerd Font'
mkdir -p ~/.local/share/fonts
cp fuente/* ~/.local/share/fonts


# Kitty Terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s /home/$USER/.local/kitty.app/bin/kitty /usr/bin/kitty
sudo ln -s /home/$USER/.local/kitty.app/bin/kitten /usr/bin/kitten


# Wallpapers
cp -r wallpapers ~


# Browser
case $navegador in
  # Firefox ESR (default)
  0)
    if ! which firefox &>/dev/null
      sudo apt install -y firefox
    ;;

  # Google Chrome
  1)
    if ! which google-chrome &>/dev/null
      wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
      sudo dpkg -i google-chrome-stable_current_amd64.deb
      rm -f google-chrome-stable_current_amd64.deb

      sed -i 's/mod], "Space", lazy.spawn("firefox")),/([mod], "Space", lazy.spawn("google-chrome-stable")),/' .config/qtile/settings/keys.py
      sed -i 's/program\[firefox\] = firefox/program\[google-chrome-stable\] = google-chrome-stable/' configs/spectrwm.conf
      sed -i 's/bind\[firefox\] = MOD+space/bind\[google-chrome-stable\] = MOD+space/' configs/spectrwm.conf
    ;;

esac


# Visual Studio Code
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
mv 'download?build=stable&os=linux-deb-x64' 'vscode.deb'
sudo dpkg -i vscode.deb
rm -f vscode.deb


# .config directory
cp -r .config/* ~/.config


# Sudo without password
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers


# Grub without timeout
sudo sed -i 's/GRUB_TIMEOUT.*/GRUB_TIMEOUT=-1/g' /etc/default/grub
sudo update-grub
