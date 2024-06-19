#!/bin/bash

# Definir el color azul
BLUE='\033[0;34m'
NC='\033[0m' # Sin color (reset)

# Actualizar
echo -e "${BLUE}--> Actualizacion del sistema${NC}"
sudo apt-get update
sudo apt-get upgrade -y

# Modificar sshd
echo -e "${BLUE}--> Configuracion de sshd${NC}"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
sudo sed -i 's/#Port 22/Port 8891/g' /etc/ssh/sshd_config
sudo sed -i 's/#LoginGraceTime 2m/LoginGraceTime 30s/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/#StrictModes yes/StrictModes yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/g' /etc/ssh/sshd_config
sudo sed -i 's/#MaxSessions 10/MaxSessions 3/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config

# iptables
echo -e "${BLUE}--> Configuracion de iptables y sshd${NC}"
sudo iptables -P FORWARD DROP

sudo systemctl restart sshd

# Dependencias 3CX
echo -e "${BLUE}--> Instalación de dependencias${NC}"
sudo apt install -y gnupg2 wget

# clave GPG y repositorio
echo -e "${BLUE}--> Añadiendo la clave GPG del repositorio de 3cx${NC}"
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -

echo -e "${BLUE}--> Añadiendo el repositorio de 3CX...${NC}"
sleep 1 && echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

echo -e "${BLUE}--> Actualizando los repositorios...${NC}"
sudo apt update

# Dependencias 2
echo -e "${BLUE}--> Instalando Dependencias adicionales...${NC}"
sudo apt install net-tools dphys-swapfile -y

# Instalación 3CX
echo -e "${BLUE}--> Instalando 3CX...${NC}"
sudo apt install 3cxpbx -y

# Finalización
echo -e "${BLUE}--> Instalación completada.${NC}"
echo -e "${BLUE}--> Recuerda que el próximo inicio de sesión por SSH será a través del puerto 8891${NC}"
