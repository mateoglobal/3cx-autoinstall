#!/bin/bash

# Definir el color cyan
CYAN='\033[0;36m'
NC='\033[0m' # Sin color (reset)

# Función para interactuar con el instalador de 3CX y aceptar el EULA
function interact_with_3cx_installer {
    expect << EOF
        spawn sudo apt install 3cxpbx -y
        expect "Do you accept the 3CX EULA? (yes/no) "
        send "yes\r"
        expect "Press \\[Tab\\] to move to OK and \\[Enter\\] to continue: "
        send "\t\r"
        expect eof
EOF
}

# Actualizar
echo -e "${CYAN}--> Actualización del sistema${NC}"
sudo apt-get update
sudo apt-get upgrade -y

# Modificar sshd
echo -e "${CYAN}--> Configuración de sshd${NC}"
# Aquí va tu configuración de sshd original

# iptables
echo -e "${CYAN}--> Configuración de iptables y sshd${NC}"
# Aquí va tu configuración de iptables original

# Dependencias 3CX
echo -e "${CYAN}--> Instalación de dependencias${NC}"
sudo apt install -y gnupg2 wget

# Clave GPG y repositorio 3CX
echo -e "${CYAN}--> Añadiendo la clave GPG del repositorio de 3cx${NC}"
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -

echo -e "${CYAN}--> Añadiendo el repositorio de 3CX...${NC}"
sleep 1 && echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

echo -e "${CYAN}--> Actualizando los repositorios...${NC}"
sudo apt update

# Dependencias adicionales
echo -e "${CYAN}--> Instalando Dependencias adicionales...${NC}"
sudo apt install net-tools dphys-swapfile -y

# Instalación 3CX
echo -e "${CYAN}--> Instalando 3CX...${NC}"
interact_with_3cx_installer

# Finalización
echo -e "${CYAN}--> Instalación completada.${NC}"
echo -e "${CYAN}--> Recuerda que el próximo inicio de sesión por SSH será a través del puerto 8891${NC}"
