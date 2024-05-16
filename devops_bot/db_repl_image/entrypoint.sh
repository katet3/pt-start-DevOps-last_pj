#!/bin/bash
set -Eeo pipefail

# Запуск основного entrypoint скрипта PostgreSQL, который также инициализирует базу данных
/usr/local/bin/docker-entrypoint.sh postgres &

# Подождем, пока PostgreSQL полностью не запустится
wait $!

