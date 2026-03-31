FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    default-mysql-client \
    curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xvf latest.tar.gz && \
    mv wordpress /var/www/html && \
    rm latest.tar.gz

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]