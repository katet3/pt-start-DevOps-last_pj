#!/bin/bash
set -e

# Запуск основного entrypoint скрипта PostgreSQL, который также инициализирует базу данных
/usr/local/bin/docker-entrypoint.sh postgres &

# Запуск SSH демона
service ssh start

# Подождем, пока PostgreSQL полностью не запустится
wait $!

