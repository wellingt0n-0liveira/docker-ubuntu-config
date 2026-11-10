#!/bin/bash
echo "Parando o BookStack e o Banco de Dados..."
docker compose stop bookstack bookstack_db

echo "Apagando pastas antigas..."
sudo rm -rf app_data db_data

echo "Subindo containers novamente..."
docker compose up -d

echo "Aguardando 30 segundos para o banco iniciar..."
sleep 30
docker compose restart bookstack
echo "Pronto!"
