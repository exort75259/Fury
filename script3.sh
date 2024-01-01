#!/bin/bash

echo "Введите имя файла для проверки: "
read filename

if [ -e "$filename" ]; then
	    echo "Файл $filename существует."
    else
	        echo "Файл $filename не существует."
fi

