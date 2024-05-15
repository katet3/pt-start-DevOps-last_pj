#!/bin/bash
set -e

# Путь к директории с данными
PGDATA="/var/lib/postgresql/data"

# Копирование настроек из конфигурационного файла
cat /tmp/standby.conf >> $PGDATA/postgresql.conf

export PATH=$PATH:/usr/lib/postgresql/15/bin/
pg_ctl stop -D $PGDATA
rm -rf $PGDATA/*

# Подключение к мастеру и получение данных
export PGPASSWORD=${DB_REPL_PASSWORD}
pg_basebackup -h ${DB_HOST} -D $PGDATA -U ${DB_REPL_USER} -P -v --wal-method=stream --write-recovery-conf
chown -R postgres:postgres $PGDATA
unset PGPASSWORD

pg_ctl start -D $PGDATA
