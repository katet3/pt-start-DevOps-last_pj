#!/bin/bash
set -e

# Путь к директории с данными PostgreSQL
PGDATA="/var/lib/postgresql/data"

# Останавливаем PostgreSQL для безопасного изменения конфигураций
pg_ctl -D $PGDATA stop

# Заменяем плейсхолдеры в SQL-скрипте
sed -i "s/%DB_REPL_USER%/${DB_REPL_USER}/g" /tmp/init_db.sql
sed -i "s/%DB_REPL_PASSWORD%/${DB_REPL_PASSWORD}/g" /tmp/init_db.sql

# Выполнение модифицированного SQL-скрипта
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /docker-entrypoint-initdb.d/init_db.sql

# модифицируем pg_hba.conf
echo "local   all             all                                     trust" > $PGDATA/pg_hba.conf
echo "host    replication  ${DB_REPL_USER}       172.25.0.4/16           scram-sha-256" >> $PGDATA/pg_hba.conf

# Копируем модифицированный postgresql.conf
cat /tmp/postgresql.conf >> $PGDATA/postgresql.conf

# Перезапускаем PostgreSQL
pg_ctl -D $PGDATA start
