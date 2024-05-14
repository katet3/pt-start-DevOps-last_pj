# Использование официального образа PostgreSQL
FROM postgres:15

RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

# Опционально: настройка переменных окружения для базы данных
ENV POSTGRES_DB=mydatabase
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=Qq12345

# Установка SSH и необходимых утилит
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo && \
    rm -rf /var/lib/apt/lists/*

# Настройка SSH
RUN mkdir /var/run/sshd
RUN echo 'root:1861' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Открытие порта SSH (стандартный порт 22)
EXPOSE 22

# Копирование конфигурационных файлов в контейнер
#COPY postgresql.conf /var/lib/postgresql/data/
#COPY pg_hba.conf /var/lib/postgresql/data/


# Права на файлы для пользователя postgres
#RUN chown postgres:postgres /var/lib/postgresql/data/postgresql.conf
#RUN chown postgres:postgres /var/lib/postgresql/data/pg_hba.conf


# Копирование SQL скрипта в папку /docker-entrypoint-initdb.d в контейнере
COPY init_db.sql /docker-entrypoint-initdb.d/


# Копирование скриптов конфигурации
COPY postgresql.conf /tmp/postgresql.conf

COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/modify-configs.sh

COPY view-log.sh /tmp/
RUN chmod +x /tmp/view-log.sh

# Копирование кастомного entrypoint скрипта
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
# Установка entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]