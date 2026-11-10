## ⚙️ 3. Configurando os Proxy Hosts

### Serviço 1: Proxmox (`proxmox.oniromante.com.br`)

O Proxmox exige configurações especiais devido ao seu certificado autoassinado e ao console VNC.

**Details:**

- **Scheme:** `https`
- **Forward Hostname/IP:** `192.168.1.116`
- **Forward Port:** `8006`
- **Websockets Support:** Ativado

**SSL:** Selecione o certificado wildcard. Ative o "Force SSL".

**Advanced (Custom Nginx Configuration):**

nginx

```
proxy_ssl_verify off;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
```


------

### Serviço 2: BookStack (`bookstack.oniromante.com.br`)

**Details:**

- **Scheme:** `http`
- **Forward Hostname/IP:** `bookstack` (Nome do container na rede Docker)
- **Forward Port:** `80`

**SSL:** Selecione o certificado wildcard. Ative o "Force SSL".

---

### 📄 Arquivo 3: `docs/03-troubleshooting.md`

Crie/edite com: `nano docs/03-troubleshooting.md`
Cole o conteúdo abaixo:

```markdown
# 🚨 Troubleshooting (Erros Comuns e Soluções)

Este documento registra os problemas enfrentados durante a configuração e como foram resolvidos.

## Erro 502 Bad Gateway no BookStack
**Causa:** O BookStack não subiu corretamente porque faltava a `APP_KEY` no `docker-compose.yml`. Além disso, as variáveis corretas para conexão do banco na imagem LinuxServer são `DB_USERNAME` e `DB_PASSWORD` (e não DB_USER/DB_PASS).
**Solução:** Gerar a chave, adicionar ao `.env` e recriar o container.

## Erro "Internal Error" ao gerar SSL (Let's Encrypt)
**Causa:** Let's Encrypt não consegue acessar IPs privados (192.168.x.x) via HTTP (desafio HTTP-01) porque a rede local não é acessível publicamente.
**Solução:** Utilizar o DNS Challenge com a API da Cloudflare (como descrito no documento de configuração do NPM).

## Erro 502 por Loop no NPM
**Causa:** Apontar um Proxy Host para o IP do próprio NPM (ex: `192.168.1.249`) na porta 80.
**Solução:** Apontar para o nome do container (`bookstack`) ou IP real do serviço na porta correta.

## Git Push Rejeitado (`fetch first`)
**Causa:** O repositório remoto (GitHub) possui commits (como README inicial) que o repositório local não possui.
**Solução:** Usar `git pull` antes do `push` ou, para sobrescrever, `git push --force`.

## Git Pull bloqueado (`unstaged changes`)
**Causa:** Você tentou fazer um `pull` com o `rebase` ativado, mas tinha arquivos modificados e não "commitados" no diretório local.
**Solução:** Rodar `git add .` e `git commit -m "..."` antes de tentar o `pull`.
