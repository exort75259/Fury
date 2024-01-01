#!/bin/bash

echo "Введите предложение: "
read -r sentence

# Разделяем предложение на слова и сохраняем их в массив
read -ra words <<< "$sentence"

# Переворачиваем порядок слов в массиве
reversed_sentence=""
for ((i=${#words[@]}-1; i>=0; i--))
do
    reversed_sentence+=" ${words[i]}"
done

# Выводим перевернутое предложение
echo "Перевернутое предложение: $reversed_sentence"

