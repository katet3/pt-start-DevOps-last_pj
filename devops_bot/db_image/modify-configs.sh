#!/bin/bash
set -e

export PATH=$PATH:/usr/lib/postgresql/15/bin
pg_ctl -D /var/lib/postgresql/data stop

# Путь к директории с данными
PGDATA="/var/lib/postgresql/data"

# Конфигурации
KEY_STRING_2="host replication repl_user 172.25.0.4/16 scram-sha-256"

cat /tmp/postgresql.conf >> $PGDATA/postgresql.conf

# Добавление кастомной конфигурации в pg_hba.conf
if ! grep -q "$KEY_STRING_2" $PGDATA/pg_hba.conf; then
    echo "$KEY_STRING_2" >> $PGDATA/pg_hba.conf
fi

pg_ctl -D "/var/lib/postgresql/data" start