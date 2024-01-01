#!/bin/bash

# Проверка наличия имени файла в качестве аргумента командной строки
if [ "$#" -ne 1 ]; then
	    echo "Использование: $2"
	        exit 1
fi

filename=$1

# Проверка существования файла
if [ ! -f "$filename" ]; then
	    echo "Ошибка: Файл '$filename' не существует."
	        exit 1
fi

# Подсчет количества строк в файле
num_lines=$(wc -l < "$filename")
echo "В файле '$filename' $num_lines строк."

