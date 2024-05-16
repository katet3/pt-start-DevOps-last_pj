#!/bin/bash
set -Eeo pipefail

# Запуск основного entrypoint скрипта PostgreSQL, который также инициализирует базу данных
/usr/local/bin/docker-entrypoint.sh postgres &


echo "${RM_USER}:${RM_PASSWORD}" | chpasswd
echo 'PermitRootLogin yes'       >> /etc/ssh/sshd_config
echo "Port ${RM_PORT}"           >> /etc/ssh/sshd_config


# Запуск SSH демона
service ssh start

# Подождем, пока PostgreSQL полностью не запустится
wait $!

