#!/bin/bash
set -e

# Подключение к мастеру и получение данных
export PGPASSWORD='kali'
pg_basebackup -h 172.25.0.2 -D $PGDATA -U repl_user -P -v --wal-method=stream --write-recovery-conf
unset PGPASSWORD

export PATH=$PATH:/usr/lib/postgresql/15/bin
pg_ctl restart -D $PGDATA

# Дополнительная конфигурация если нужна
echo "primary_conninfo = 'host=172.25.0.2 port=5432 user=repl_user password=kali'" >> $PGDATA/recovery.conf
