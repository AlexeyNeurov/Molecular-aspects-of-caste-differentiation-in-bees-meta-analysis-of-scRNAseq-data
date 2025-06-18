#!/bin/bash

# Директории
TRIMMED_DATA="trimmed_data"
OUTPUT_DIR="quant"
REF_INDEX="test1/AMel3_1.idx"
TECHNOLOGY="10xv2"
THREADS=4

# Создание выходной директории, если она не существует
mkdir -p "$OUTPUT_DIR"

# Получение списка образцов
echo "Получение списка образцов из директории $TRIMMED_DATA..."
for file in "$TRIMMED_DATA"/*_1.fastq.gz; do
    # Извлечение имени образца
    sample_name=$(basename "$file" "_1.fastq.gz")

    # Определение входных файлов
    in1="$TRIMMED_DATA/${sample_name}_1.fastq.gz"
    in2="$TRIMMED_DATA/${sample_name}_2.fastq.gz"
    output="$OUTPUT_DIR/$sample_name"

    # Создание выходной директории для образца
    mkdir -p "$output"

    # Вывод информации о текущем этапе
    echo "Обработка образца: $sample_name"
    echo "Входные файлы: $in1, $in2"
    echo "Выходная директория: $output"

    # Запуск kallisto
    kallisto bus \
        -i "$REF_INDEX" \
        -x "$TECHNOLOGY" \
        -o "$output" \
        -t "$THREADS" \
        "$in1" "$in2"

    # Проверка кода выхода
    if [ $? -ne 0 ]; then
        echo "Ошибка при обработке образца $sample_name"
        exit 1
    fi

    echo "Обработка образца $sample_name завершена."
done

echo "Все образцы обработаны."

