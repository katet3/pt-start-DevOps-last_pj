# Использование официального образа PostgreSQL
FROM postgres:15

RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

# Настройка переменных окружения для базы данных репликации
ENV POSTGRES_USER=${DB_REPL_USER}
ENV POSTGRES_PASSWORD=${DB_REPL_PASSWORD}
ENV POSTGRES_DB=${DB_DATABASE}

# Копируем SQL скрипт и конфигурационные файлы в контейнер
COPY init_db.sql /docker-entrypoint-initdb.d/
COPY standby.conf /tmp/standby.conf
COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/modify-configs.sh
