# Использование официального образа PostgreSQL
FROM postgres:15

RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

# Опционально: настройка переменных окружения для базы данных
# ENV POSTGRES_DB=mydatabase
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=Qq12345

# Копируем SQL скрипт в папку /docker-entrypoint-initdb.d в контейнере
COPY init_db.sql /docker-entrypoint-initdb.d/

# Копирование конфигурационного файла и скрипта инициализации
COPY standby.conf /tmp/standby.conf
#COPY setup-replication.sh /docker-entrypoint-initdb.d/
#RUN chmod +x /docker-entrypoint-initdb.d/setup-replication.sh

#CMD ["postgres", "-c", "config_file=/etc/postgresql/standby.conf"]
#COPY additional-config.conf /tmp/
COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/modify-configs.sh
