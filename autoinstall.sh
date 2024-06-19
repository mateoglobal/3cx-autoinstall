#!/bin/bash

# Actualizar
echo "Actualizacion del sistema"
sudo apt-get update
sudo apt-get upgrade -y

# Modificar sshd
echo "Configuracion de sshd"
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
echo "Configuracion de iptables y sshd"
sudo iptables -P FORWARD DROP

sudo systemctl restart sshd

# Dependencias 3CX
echo "Instalación de dependencias"
sudo apt install -y gnupg2 wget

# clave GPG y repositorio
echo "Añadiendo la clave GPG del repositorio de 3cx"
wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add -

echo "Añadiendo el repositorio de 3CX..."
sleep 1 && echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list

echo "Actualizando los repositorios..."
sudo apt update

# Dependencias 2
echo "Instalando Dependencias adicionales..."
sudo apt install net-tools dphys-swapfile -y

# Instalación 3CX
echo "Instalando 3CX..."
sudo apt install 3cxpbx -y

# Finalización
echo "Instalación completada."
echo "Recuerda que el próximo inicio de sesión por SSH será a través del puerto 8891"
