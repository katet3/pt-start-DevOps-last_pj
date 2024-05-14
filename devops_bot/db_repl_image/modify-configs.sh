#!/bin/bash
set -e


# Путь к директории с данными
PGDATA="/var/lib/postgresql/data"

cat /tmp/standby.conf >> $PGDATA/postgresql.conf

export PATH=$PATH:/usr/lib/postgresql/15/bin/
pg_ctl stop -D $PGDATA
rm -rf $PGDATA/*


# Подключение к мастеру и получение данных
export PGPASSWORD='kali'
pg_basebackup -h 172.25.0.2 -D $PGDATA -U repl_user -P -v --wal-method=stream --write-recovery-conf
chown -R postgres:postgres $PGDATA
unset PGPASSWORD

pg_ctl start -D $PGDATA
