# Использование официального образа PostgreSQL
FROM postgres:15

# Создание папок для логирования и настройка прав доступа
RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

# Настройка переменных окружения для базы данных из .env файла
ENV POSTGRES_DB=${DB_DATABASE}
ENV POSTGRES_USER=${DB_USER}
ENV POSTGRES_PASSWORD=${DB_PASSWORD}

ENV RM_USER=${RM_USER}
ENV RM_PASSWORD=${RM_PASSWORD}
ENV RM_PORT=${RM_PORT}


# Установка SSH и необходимых утилит
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo && \
    rm -rf /var/lib/apt/lists/*

# Настройка SSH
RUN mkdir /var/run/sshd
RUN echo "${RM_USER}:${RM_PASSWORD}" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Установка порта SSH
RUN echo "Port ${RM_PORT}" >> /etc/ssh/sshd_config

# Исправление для входа в систему по SSH
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Открытие порта SSH
EXPOSE ${RM_PORT}

# Копирование SQL скрипта в папку /docker-entrypoint-initdb.d для инициализации базы данных
COPY init_db.sql /docker-entrypoint-initdb.d/

# Копирование конфигурационных скриптов
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
