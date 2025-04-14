#!/bin/bash

set -e

echo "🔧 Eliminando posibles instalaciones previas de Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "📦 Instalando dependencias..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔐 Agregando clave GPG de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📄 Agregando repositorio oficial de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Actualizando e instalando Docker y Docker Compose..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🚀 Iniciando y habilitando el servicio Docker..."
sudo systemctl start docker
sudo systemctl enable docker

echo "👤 Añadiendo tu usuario al grupo 'docker'..."
sudo groupadd docker || true
sudo usermod -aG docker $USER

echo "✅ Instalación completada."
echo "🔄 Para aplicar los cambios de grupo, cierra la sesión o ejecuta: newgrp docker"
echo "🧪 Prueba con: docker run hello-world"
