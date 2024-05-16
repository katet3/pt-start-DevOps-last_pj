# Используем официальный образ Python как базовый
FROM python:3.9-slim

# Установка зависимостей для psycopg2
RUN apt-get update && apt-get install -y \
libpq-dev \
gcc \
# Установка зависимостей для paramiko
build-essential \
libssl-dev \
libffi-dev \
python3-dev \
# Установка утилиты pg_config
postgresql-client \
&& rm -rf /var/lib/apt/lists/*


# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . /app

# Устанавливаем зависимости
RUN pip install -r requirements.txt

# Запускаем бота
ENTRYPOINT ["/bin/sh", "-c", "python3 bot.py"]
