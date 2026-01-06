
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Aliases
alias ls='lsd'
alias cat='bat'
alias vi='micro'
alias vin='/usr/bin/vi'
alias catn='/usr/bin/cat'
alias l='ls'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias rm='rm -rf'
alias internet='ping -c 1 -W 1 8.8.8.8 &>/dev/null && echo "Hay internet :D" || echo "No hay internet D:"'
alias puertos='ss -tulnp | grep LISTEN'
alias tmux='tmux -f ~/.tmux.conf'
alias prxoxychains='prxoxychains4'


# Wait until internet works
bucle_internet() {
	while true; do
		ping -c 1 -W 1 8.8.8.8 &> /dev/null
		if [ $? -eq 0 ]; then
			echo "Ya hay internet :D"
			break
		fi
	done
}


# Funcion para ver la informacion detallada de los puertos abiertos de una IP
info_ip() {
	if [ -n "$1" -a -f "$1" -a -n "$2" ]; then
		awk -v ip="$2$" 'BEGIN {capture=0} /Nmap scan report for/ {if ($0 ~ ip) capture=1; else capture=0} capture' "$1" | /usr/bin/batcat -l java
	else
		echo -e "\n[!] Se debe pasar un fichero y una IP como argumentos\n"
	fi
}


# Funcion para unir todos los ficheros de escaneo de puertos en uno solo
unir_scan() {
	if [ -n "$1" -a -d "$1" -a -n "$2" -a ! -d "$2" ]; then
		find "$1" -name "*.nmap" | xargs /usr/bin/cat | grep -vE "^#.*$|^WARNING|Host is up|Service detection performed" | sponge "$2"
	else
		echo -e "\n[!] Se debe pasar un directorio y un fichero como argumentos\n"
	fi
}


# Funcion para extraer los puertos de una captura grepeable de nmap
extractPorts() {
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp
	rm -f extractPorts.tmp
}


# Powerline-shell
_update_ps1() {
  estado=$?
  if [ $UID -eq 0 ]; then
    # Root prompt
    PS1=$(powerline-shell $estado)"\n\[\033[01;31m\]~\[\033[00m\]> "
  else
    # Normal user prompt
    PS1=$(powerline-shell $estado)"\n\[\033[01;32m\]~\[\033[00m\]> "
  fi
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
