#!/bin/bash

# Cores para o terminal
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

echo -e "${GREEN}Iniciando a configuração do Homelab (NPM + BookStack)...${NC}"

# 1. Criar o arquivo .env se não existir
if [ ! -f docker/.env ]; then
    echo -e "${YELLOW}Criando arquivo docker/.env a partir do exemplo...${NC}"
    cp docker/.env.example docker/.env
    echo -e "${YELLOW}⚠️  ATENÇÃO: Edite o arquivo docker/.env com suas senhas e a APP_KEY!${NC}"
else
    echo "O arquivo docker/.env já existe. Pulando etapa."
fi

# 2. Criar as pastas de dados locais
echo "Criando pastas de dados (app_data, db_data, npm_data, npm_letsencrypt)..."
mkdir -p docker/app_data
mkdir -p docker/db_data
mkdir -p docker/npm_data
mkdir -p docker/npm_letsencrypt

# 3. Ajustar as permissões (O LinuxServer.io usa o UID/GID 1000 por padrão)
echo "Ajustando permissões das pastas (UID 1000)..."
sudo chown -R 1000:1000 docker/app_data docker/db_data docker/npm_data docker/npm_letsencrypt

echo -e "${GREEN}✅ Configuração inicial concluída com sucesso!${NC}"
echo "Próximos passos:"
echo "1. Edite o arquivo 'docker/.env' e preencha suas senhas."
echo "2. Gere uma chave para o BookStack (veja o README)."
echo "3. Entre na pasta docker e rode: docker compose up -d"
