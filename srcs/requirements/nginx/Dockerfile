FROM debian:bookworm

# Argumento build-time para definir o domínio (usado no SSL)
ARG DOMAIN_NAME

# Instala nginx, openssl (pra gerar certificado) e ferramentas auxiliares
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get install -y netcat-openbsd && \
    apt install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Cria diretório onde ficarão os certificados SSL
RUN mkdir -p /etc/nginx/ssl

# Gera certificado SSL autoassinado (obrigatório no subject do projeto)
RUN openssl req -x509 -nodes -days 365 \
    -subj "/CN=${DOMAIN_NAME}" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

# Copia a configuração customizada do nginx (reverse proxy + TLS)
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Mantém o nginx rodando em foreground (necessário no Docker)
CMD ["nginx", "-g", "daemon off;"]