#!/bin/bash

samples=()
input_file="SRAlist.txt"

# Проверка существования входного файла
if [[ ! -f "$input_file" ]]; then
    echo "Входной файл '$input_file' не найден!"
    exit 1
fi

while IFS= read -r line; do
    trimmed_line=$(echo "$line" | xargs)
    if [ -n "$trimmed_line" ]; then
        samples+=("$trimmed_line")
    fi
done < "$input_file"

mkdir -p trans/row_dataa

# Проверка успешного создания директории
if [[ $? -ne 0 ]]; then
    echo "Не удалось создать директорию 'row_data'."
    exit 1
fi

# Обработка каждого образца
for sample in "${samples[@]}"; do
    echo "Запуск prefetch для образца: $sample"

    # Используем prefetch для загрузки данных
    if prefetch "$sample"; then
        echo "Данные успешно загружены для образца: $sample"

        echo "Запуск fasterq-dump для образца: $sample"

        # Используем fasterq-dump для конвертации в FASTQ
        if fasterq-dump "$sample" -O trans/row_dataa --progress; then
            echo "Файлы созданы: row_data/${sample}*.fastq"

            for fastq_file in trans/row_dataa/${sample}*.fastq; do
                if [ -f "$fastq_file" ]; then
                    gzip "$fastq_file"
                    echo "Файл сжат: ${fastq_file}.gz"
                    
                    # Удаление сырого файла после сжатия
                    rm "$fastq_file"
                    echo "Сырой файл удален: $fastq_file"
                else
                    echo "Файл не найден: $fastq_file"
                fi
            done
        else
            echo "Ошибка при запуске fasterq-dump для образца: $sample"
        fi
    else
        echo "Ошибка при загрузке данных с помощью prefetch для образца: $sample"
    fi
done

echo "Все операции завершены."

