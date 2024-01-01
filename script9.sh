#!/bin/bash

# Проверка наличия имени файла в качестве аргумента
if [ "$#" -ne 1 ]; then
	    echo "Использование: $0 "
	        exit 1
fi

filename=$1

# Проверка существования файла
if [ ! -f "$filename" ]; then
	    echo "Ошибка: Файл '$filename' не существует."
	        exit 1
fi

# Чтение и вывод содержимого файла
echo "Содержимое файла '$filename':"
cat "$filename"

