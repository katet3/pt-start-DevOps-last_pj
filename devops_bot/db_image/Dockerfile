# Использование официального образа PostgreSQL
FROM postgres:15

# Создание папок для логирования и настройка прав доступа
RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

# Установка SSH и необходимых утилит
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo && \
    rm -rf /var/lib/apt/lists/*


# Копирование SQL скрипта в папку /docker-entrypoint-initdb.d для инициализации базы данных
COPY init_db.sql              /tmp/init_db.sql
RUN  chown postgres:postgres  /tmp/init_db.sql

# Копирование конфигурационных скриптов
COPY postgresql.conf /tmp/postgresql.conf

COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN  chmod +x          /docker-entrypoint-initdb.d/modify-configs.sh

COPY view-log.sh /tmp/
RUN  chmod +x    /tmp/view-log.sh

# Копирование кастомного entrypoint скрипта
COPY entrypoint.sh /usr/local/bin/
RUN  chmod +x      /usr/local/bin/entrypoint.sh

# Установка entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
