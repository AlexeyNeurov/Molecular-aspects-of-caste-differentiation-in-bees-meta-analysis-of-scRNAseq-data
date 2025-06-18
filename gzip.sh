#!/bin/bash

# Директория с входными файлами
input_dir="row_data"

# Проверка наличия файлов .fastq в директории
shopt -s nullglob
input_files=("$input_dir"/*.fastq)

if [ "${#input_files[@]}" -eq 0 ]; then
    echo "Нет файлов .fastq в директории $input_dir"
    exit 1
fi

# Цикл по всем входным файлам
for input_file in "${input_files[@]}"; do
    # Определение имени выходного файла
    output_file="${input_file}.gz"
    
    # Сжатие файла
    gzip -c "$input_file" > "$output_file"
    
    echo "Сжатие $input_file в $output_file"
done

