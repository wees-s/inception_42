FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    default-mysql-client \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Corrige PHP-FPM para escutar na porta 9000 (obrigatório pro NGINX)
RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Diretório correto do WordPress
WORKDIR /var/www/html

# Baixa e extrai WordPress direto no diretório certo
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xvf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

# Permissões corretas (evita 403)
RUN chown -R www-data:www-data /var/www/html

# Script de inicialização
COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]