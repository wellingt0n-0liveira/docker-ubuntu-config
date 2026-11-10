# 🏠 Homelab: BookStack + NPM + SSL Wildcard

Este repositório centraliza a documentação e a infraestrutura como código (IaC) para o meu Homelab. O objetivo principal é rodar uma instância do **BookStack** (para documentação da comunidade Linux) de forma segura, acessível via HTTPS e protegida por um Proxy Reverso.

## 🚀 Stack Utilizada
*   **[Nginx Proxy Manager](https://nginxproxymanager.com/)** - Proxy reverso e gestão de certificados SSL.
*   **[BookStack](https://www.bookstackapp.com/)** - Plataforma de documentação e wiki.
*   **[MariaDB](https://mariadb.org/)** - Banco de dados relacional.
*   **Cloudflare** - Gestão de DNS e emissão de certificado SSL Wildcard (`*.oniromante.com.br`) via DNS Challenge.
*   **AdGuard Home** - Resolução de DNS local e reescrita de domínios para a rede interna.

## 📁 Estrutura do Repositório
*   `docs/` - Documentação detalhada de arquitetura, configurações e troubleshooting.
*   `docker/` - Arquivos de infraestrutura (Docker Compose e variáveis de ambiente).
*   `scripts/` - Scripts de automação e utilidades.

## 🛠️ Pré-requisitos
*   Docker e Docker Compose instalados.
*   Domínio configurado na Cloudflare.
*   Rede Docker criada (`homelab_network`).

## ⚡ Como Iniciar

1. Clone o repositório:
   ```bash
   git clone https://github.com/SEU_USUARIO/NOME_DO_REPOSITORIO.git
   cd NOME_DO_REPOSITORIO/docker
