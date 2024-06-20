#!/bin/bash

# Definir el color cyan
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # Sin color (reset)

# Actualizar
echo -e "${CYAN}--> Actualización del sistema${NC}"
sleep 4
sudo apt-get update
sudo apt-get upgrade -y

# Modificar sshd
echo -e "${CYAN}--> Configuración de sshd${NC}"
sleep 4
# Aquí va tu configuración de sshd original

# iptables
echo -e "${CYAN}--> Configuración de iptables y sshd${NC}"
sleep 4
# Aquí va tu configuración de iptables original

# Dependencias 3CX
echo -e "${CYAN}--> Instalación de dependencias${NC}"
sleep 4
sudo apt install -y gnupg2 wget

# Clave GPG y repositorio 3CX
echo -e "${CYAN}--> Añadiendo la clave GPG del repositorio de 3cx${NC}"
sleep 4
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -

echo -e "${CYAN}--> Añadiendo el repositorio de 3CX...${NC}"
sleep 4
sleep 1 && echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

echo -e "${CYAN}--> Actualizando los repositorios...${NC}"
sleep 4
sudo apt update

# Dependencias adicionales
echo -e "${CYAN}--> Instalando Dependencias adicionales...${NC}"
sleep 4
sudo apt install net-tools dphys-swapfile -y

# Aviso ssh
echo -e "${CYAN}--> Recuerda que el próximo inicio de sesión por SSH será a través del puerto 8891${NC}"
sleep 1

# Mensaje con colorines
echo -e "${CYAN}Introduce el comando ${GREEN}sudo apt install 3cxpbx -y${NC} ${CYAN}para terminar la instalación de 3CX${NC}"
