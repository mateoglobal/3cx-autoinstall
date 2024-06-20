#!/bin/bash

# Definir el color cyan
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # Sin color (reset)

# Actualizar
sleep 4
echo -e "${CYAN}--> Actualización del sistema${NC}"
sudo apt-get update
sudo apt-get upgrade -y

# Modificar sshd
sleep 4
echo -e "${CYAN}--> Configuración de sshd${NC}"
# Aquí va tu configuración de sshd original

# iptables
sleep 4
echo -e "${CYAN}--> Configuración de iptables y sshd${NC}"
# Aquí va tu configuración de iptables original

# Dependencias 3CX
sleep 4
echo -e "${CYAN}--> Instalación de dependencias${NC}"
sudo apt install -y gnupg2 wget

# Clave GPG y repositorio 3CX
sleep 4
echo -e "${CYAN}--> Añadiendo la clave GPG del repositorio de 3cx${NC}"
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -

sleep 4
echo -e "${CYAN}--> Añadiendo el repositorio de 3CX...${NC}"
sleep 1 && echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

sleep 4
echo -e "${CYAN}--> Actualizando los repositorios...${NC}"
sudo apt update

# Dependencias adicionales
sleep 4
echo -e "${CYAN}--> Instalando Dependencias adicionales...${NC}"
sudo apt install net-tools dphys-swapfile -y

# Finalización
sleep 4
echo -e "${CYAN}--> Recuerda que el próximo inicio de sesión por SSH será a través del puerto 8891${NC}"
echo "Presiona Enter para instalar 3CX PBX..."

# Mensaje con colores
sleep 4
echo -e "${CYAN}Introduce el comando ${GREEN}sudo apt install 3cxpbx -y${NC} ${CYAN}para terminar la instalación de 3CX${NC}"
