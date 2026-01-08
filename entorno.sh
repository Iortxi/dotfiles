#!/bin/bash

##########################
# ROOT CHECK
##########################
if [ $UID -eq 0 ]; then
  echo "[!] Do NOT execute this as root"
  exit 1
fi


##########################
# BROWSER SELECTOR
##########################
navegadores=("Firefox ESR" "Google Chrome")
num_navegadores="${#navegadores[@]}"

# Option panel
for i in "${!navegadores[@]}"; do
  echo "[$i] ${navegadores[$i]}"
done

declare -i navegador
echo -n "[?] Select a browser to install (number): "
read navegador

# Option check, browser int number in "navegador"
while true; do
  if [ $navegador -lt 0 -o $navegador -ge $num_navegadores ]; then
    echo -n "[!] You must select a valid browser to install (number): "
    read navegador
    echo
  else
    break
  fi
done
echo



##########################
# KEYBOARD LAYOUT
##########################
echo -n "[?] Select a keyboard layout to use (default 'es'): "
read keyboard_layout
if [ -z "$keyboard_layout" ]; then
  keyboard_layout="es"
fi

setxkbmap $keyboard_layout,$keyboard_layout
sed -i "s/es,es/$keyboard_layout,$keyboard_layout/g" .config/qtile/autostart.sh .config/spectrwm/autostart.sh
echo



##########################
# SUDO WITHOUT PASSWORD
##########################
echo -n "[?] Do you want your user to be able to execute sudo without password (Y/n): "
read keyboard_layout
keyboard_layout=`echo "$keyboard_layout" | awk '{print tolower($0)}'`
if [ "$keyboard_layout" == "y" -o -z "$keyboard_layout" ]; then
  echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
fi
echo



##########################
# SHELL SELECTOR
##########################
shells=("Bash" "Zsh")
num_shells="${#shells[@]}"

# Option panel
for i in "${!shells[@]}"; do
  echo "[$i] ${shells[$i]}"
done


declare -i shell
echo -n "[?] Select a shell to use (number): "
read shell

# Option check, shell int number in "shell"
while true; do
  if [ $shell -lt 0 -o $shell -ge $num_shells ]; then
    echo -n "[!] You must select a valid shell to use (number): "
    read shell
    echo
  else
    break
  fi
done




##########################
# BATTERY ICON (LABTOPS)
##########################
if [ -n "$1" -a "$1" == "-l" ]; then
  sed -i 's/#cbatticon -u 5 &/cbatticon -u 5 &/g' .config/qtile/autostart.sh
  sed -i 's/#cbatticon -u 5 &/cbatticon -u 5 &/g' .config/spectrwm/autostart.sh
fi



##########################
# SYSTEM UPDATE
##########################
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y



##########################
# PACKETS INSTALLATION
##########################
sudo apt install -y spectrwm pamixer bat lsd console-data feh rofi picom htop \
cbatticon pasystray flameshot micro thunar pavucontrol arandr kcalc vlc socat \
brightnessctl apt-show-versions pulseaudio-utils docker.io lsof python3-pip git \
python3-pyftpdlib nmap tor proxychains docker-compose torsocks unzip wget curl \
zip 7zip gzip tmux zsh



##########################
# USER IN DOCKER GROUP
##########################
sudo usermod -aG docker "$USER"



##########################
# PYTHON DEPENDENCIES
##########################
pip install termcolor --break-system-packages



##########################
# OBSIDIAN INSTALLATION
##########################
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/Obsidian-1.7.7.AppImage -O obsidian
chmod +x obsidian
sudo mv obsidian /usr/bin



##########################
# SHELLS SETUP
##########################
# Starship and powerline-shell installation
sudo curl -sS https://starship.rs/install.sh | sh
pip install powerline-shell --break-system-packages
sudo pip install powerline-shell --break-system-packages

# .rc files
cp shell/bash/.bashrc ~
cp shell/zsh/.zshrc ~
sudo rm -f /root/.bashrc /root/.zshrc
sudo ln -s ~/.bashrc /root/.bashrc
sudo ln -s ~/.zshrc /root/.zshrc

# Powerline-shell setup
sudo ln -s ~/.local/bin/powerline-shell /usr/bin/powerline-shell
# User
cp shell/bash/.bash_powerline_shell ~
cp shell/zsh/.zsh_powerline_shell ~
cp shell/bash/config.json ~/.config/powerline-shell

# Root
sudo mkdir -p /root/.config/powerline-shell
sudo ln -s ~/.bash_powerline_shell /root/.bash_powerline_shell
sudo ln -s ~/.zsh_powerline_shell /root/.zsh_powerline_shell
sudo ln -s ~/.config/powerline-shell/config.json /root/.config/powerline-shell/config.json

# Starship setup
cp shell/zsh/starship.toml ~/.config/starship.toml
sudo ln -s ~/.config/starship.toml /root/.config/starship.toml

# Shell selector
case $shell in
  # Bash
  0)
    sudo chsh -s /bin/bash "$USER"
    sudo chsh -s /bin/bash root
    sed -i 's/shell zsh/shell bash/g' .config/kitty/kitty.conf
    ;;

  # Zsh
  1)
    sudo chsh -s /usr/bin/zsh "$USER"
    sudo chsh -s /usr/bin/zsh root
    ;;
esac



##########################
# SPECTRWM
##########################
sudo cp configs/spectrwm.conf /etc/
sudo cp configs/spectrwm.desktop /usr/share/xsessions



##########################
# QTILE
##########################
pip install qtile --break-system-packages

sed -i "s/USER/$USER/g" .config/qtile/scripts/qtile.sh configs/qtile.desktop
sudo cp configs/qtile.desktop /usr/share/xsessions
sudo ln -s /home/$USER/.local/bin/qtile /usr/bin/qtile



##########################
# FONTS
##########################
#'UbuntuMono Nerd Font' and 'Hack Nerd Font'
mkdir -p ~/.local/share/fonts
cp fuente/* ~/.local/share/fonts



##########################
# KITTY TERMINAL
##########################
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s /home/$USER/.local/kitty.app/bin/kitty /usr/bin/kitty
sudo ln -s /home/$USER/.local/kitty.app/bin/kitten /usr/bin/kitten



##########################
# WALLPAPERS
##########################
cp -r wallpapers ~



##########################
# BROWSER
##########################
case $navegador in
  # Firefox ESR
  0)
    if ! which firefox-esr &>/dev/null; then
      sudo apt install -y firefox-esr
    fi

    # Labtop zoom touch support
    if [ -n "$1" -a "$1" == "-l" ]; then
      echo "MOZ_USE_XINPUT2 DEFAULT=1" | sudo tee -a /etc/security/pam_env.conf
      #set "dom.w3c_touch_events.enabled" to 1 (default is 2) in "about:config" in firefox, PONER EN README
    fi
    ;;

  # Google Chrome
  1)
    if ! which google-chrome &>/dev/null; then
      wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
      sudo dpkg -i google-chrome-stable_current_amd64.deb
      rm -f google-chrome-stable_current_amd64.deb

      # Shortcuts and keybindings changes to Chrome
      sed -i 's/firefox/google-chrome-stable/g' .config/qtile/settings/keys.py configs/spectrwm.conf
    fi
    ;;
esac



##########################
# VSCODE
##########################
wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
mv 'download?build=stable&os=linux-deb-x64' 'vscode.deb'
sudo dpkg -i vscode.deb
rm -f vscode.deb



##########################
# .config DIRECTORY
##########################
cp -r .config/* ~/.config



##########################
# GRUB WITHOUT TIMEOUT
##########################
sudo sed -i 's/GRUB_TIMEOUT.*/GRUB_TIMEOUT=-1/g' /etc/default/grub
sudo update-grub


echo "[*] Setup completed!"
echo "Reboot your computer and enjoy! :D"
