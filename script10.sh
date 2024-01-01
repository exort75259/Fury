#!/bin/bash

watch_dir=~/watch
processed_dir=~/watch_processed

echo "Отслеживается директория: $watch_dir"

# Создаем директорию для обработанных файлов, если её еще нет
mkdir -p "$processed_dir"

# Массив для хранения уже обработанных файлов
processed_files=()

# Бесконечный цикл для непрерывного отслеживания директории
while true; do
	    # Получаем список файлов в директории
	        current_files=$(ls "$watch_dir")

		    # Проверяем каждый файл из списка на наличие новых файлов
		        for file in $current_files; do
				        if [[ ! " ${processed_files[@]} " =~ " $file " ]]; then
						            echo "Обнаружен новый файл: $file"
							                cat "$watch_dir/$file"

									            # Перемещаем файл в директорию обработанных файлов с расширением .back
										                mv "$watch_dir/$file" "$processed_dir/${file}.back"
												            echo "Файл переименован в ${file}.back"

													                # Добавляем файл в массив обработанных файлов
															            processed_files+=("$file")
																            fi
																	        done

																		    # Ждем 5 секунд перед следующей проверкой
																		        sleep 5
																		done

