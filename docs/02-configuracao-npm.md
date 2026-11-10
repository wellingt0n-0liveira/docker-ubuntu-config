# Configuração de Proxy Reverso e SSL Wildcard (NPM + Cloudflare)

Este documento detalha a configuração do **Nginx Proxy Manager (NPM)** para expor serviços do Homelab com HTTPS seguro, utilizando certificados wildcard gerados via **Cloudflare DNS Challenge**.

## 📋 Pré-requisitos
- Domínio registrado (ex: `oniromante.com.br`).
- Conta gratuita na Cloudflare com o domínio configurado.
- NPM rodando em Docker (IP do host: `192.168.1.249`).
- Serviços configurados na mesma rede Docker (`homelab_network`).

---

## 🌐 1. Configuração de DNS (Cloudflare e AdGuard)

### No AdGuard Home (Local)
Para que os dispositivos da rede local encontrem os serviços sem sair para a internet, criamos uma regra de reescrita:
- **Domínio:** `*.oniromante.com.br`
- **Resposta:** `192.168.1.249` (IP do NPM)

### Na Cloudflare (Externo)
Criamos um registro do tipo `A` para apontar o domínio para o IP público (ou para o túnel, caso use Cloudflare Tunnel).
- **Nome:** `*` (Wildcard)
- **Conteúdo:** `192.168.1.249` (Nota: Se for acessar de fora, use o IP público ou Tunnel).

---

## 🔐 2. Gerando o Certificado SSL (O Segredo do Sucesso)

**O Problema:** O desafio HTTP-01 padrão do Let's Encrypt falha em redes locais (IPs privados como 192.168.x.x).
**A Solução:** Usar o **DNS Challenge** na Cloudflare. Isso permite gerar um certificado curinga (`*.oniromante.com.br`) que cobre todos os subdomínios de uma vez.

### Passo a Passo no NPM:
1. Vá em **SSL Certificates** > **Add SSL Certificate** > **Let's Encrypt**.
2. **Domain Names:** Digite `oniromante.com.br` e `*.oniromante.com.br`.
3. Ative a opção **Use a DNS Challenge**.
4. **DNS Provider:** Selecione `Cloudflare`.
5. **Credentials File Content:** Cole o token da API da Cloudflare no seguinte formato:
   ```text
   dns_cloudflare_api_token = SEU_TOKEN_AQUI
