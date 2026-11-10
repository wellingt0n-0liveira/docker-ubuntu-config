# Arquitetura de Rede do Homelab

Este documento descreve a topologia da rede local (LAN) e como o tráfego flui desde a internet até os serviços internos.

## 🌐 Topologia Geral

O fluxo de uma requisição externa (ou interna) segue esta ordem:

1.  **AdGuard Home (DNS Local):** Resolve os domínios `*.oniromante.com.br` para o IP do Nginx Proxy Manager (192.168.1.249), evitando que o tráfego saia para a internet quando estamos na rede local.
2.  **Cloudflare (DNS Público/Túnel):** Para acessos externos, a Cloudflare gerencia o DNS e (opcionalmente) o Cloudflare Tunnel, escondendo o IP real da residência.
3.  **Nginx Proxy Manager (NPM - 192.168.1.249):** Atua como a "porta de entrada" (Proxy Reverso). Ele recebe todo o tráfego HTTP/HTTPS, gerencia os certificados SSL Wildcard (Let's Encrypt) e roteia para o container/máquina correto.
4.  **Serviços Internos:**
    *   **Proxmox VE:** 192.168.1.116 (Porta 8006)
    *   **BookStack:** Container Docker `bookstack` (Porta 80)

## 🗺️ Diagrama Visual (Em breve)

*(Aqui você pode usar a integração do Draw.io no BookStack ou inserir uma imagem exportada do diagrama da sua rede).*

## 🛡️ Segurança
*   Nenhuma porta do roteador está aberta para a internet (No NAT/Port Forwarding).
*   Acesso externo planejado exclusivamente via Cloudflare Tunnel.
*   Certificados SSL gerenciados via Cloudflare DNS Challenge (Wildcard).
