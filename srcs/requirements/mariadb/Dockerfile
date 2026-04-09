FROM debian:bookworm

# Instala o servidor MariaDB (banco de dados do WordPress)
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copia configuração customizada do MariaDB (bind-address, configs, etc)
COPY conf/custom_mdb.cnf /etc/mysql/mariadb.conf.d/

# Script responsável por inicializar o banco (criar DB, user, permissões)
COPY tools/init.sh /init.sh

# Garante permissão de execução do script
RUN chmod +x /init.sh

# Expõe a porta padrão do MariaDB
EXPOSE 3306

# Executa o script de inicialização (em vez de rodar mysqld direto)
CMD ["/init.sh"]