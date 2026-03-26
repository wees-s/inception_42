FROM debian:bookworm

RUN apt-get update && apt-get install mariadb-server -y

RUN rm -rf /var/lib/apt/lists/*

CMD service mariadb start