#!/bin/bash

WAL_DIR="/var/log/postgresql"  # Путь к каталогу с файлами WAL
export PATH=$PATH:/usr/lib/postgresql/15/bin

# Максимальное количество файлов для обработки
MAX_FILES=10
COUNT=0

for WAL_FILE in $(ls -t $WAL_DIR); do  # Сортировка файлов по времени изменения, новые первые
    if [ -f "$WAL_DIR/$WAL_FILE" ] && [ $COUNT -lt $MAX_FILES ]; then
        echo "Содержимое файла $WAL_FILE:"
        # Вывод содержимого WAL файла с использованием pg_waldump, ограничив вывод до 50 строк
        pg_waldump "$WAL_DIR/$WAL_FILE" | tail -n 50
        echo "----------------------------------------------"
        ((COUNT++))
    fi
done

if [ $COUNT -eq 0 ]; then
    echo "Файлы WAL не найдены."
fi
