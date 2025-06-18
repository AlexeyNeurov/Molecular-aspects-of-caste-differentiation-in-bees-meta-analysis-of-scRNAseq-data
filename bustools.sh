#!/bin/bash

# Папка, в которой находятся подкаталоги с матрицами
BASE_DIR="quant"

# Путь к файлам
WHITELIST="$BASE_DIR/10xv3_whitelist.txt"
OUTPUTTT="$BASE_DIR/outputtt.txt"

# Проверяем, существуют ли необходимые файлы
if [[ ! -f "$WHITELIST" ]]; then
    echo "Файл $WHITELIST не найден. Пожалуйста, проверьте путь."
    exit 1
fi

if [[ ! -f "$OUTPUTTT" ]]; then
    echo "Файл $OUTPUTTT не найден. Пожалуйста, проверьте путь."
    exit 1
fi

# Проходим по каждому подкаталогу в BASE_DIR
for dir in "$BASE_DIR"/*/; do
    # Проверяем, что это действительно директория
    if [ -d "$dir" ]; then
        echo "Обработка директории: $dir"

        # Путь к файлам
        MATRIX_EC="$dir/matrix.ec"
        TRANSCRIPTS="$dir/transcripts.txt"
        
        # Проверяем, существуют ли необходимые файлы в подкаталоге
        if [[ ! -f "$MATRIX_EC" ]]; then
            echo "Файл $MATRIX_EC не найден в директории $dir. Пропускаем."
            continue
        fi

        if [[ ! -f "$TRANSCRIPTS" ]]; then
            echo "Файл $TRANSCRIPTS не найден в директории $dir. Пропускаем."
            continue
        fi

        # Создаем папку genecount, если она не существует
        GENECOUNT_DIR="$dir/genecount"
        mkdir -p "$GENECOUNT_DIR"

        echo "Запуск bustools для директории: $dir"
        
        # Выполняем команду
        bustools correct "$WHITELIST" -p output.bus | \
        bustools sort -T tmp/ -t 4 -p - | \
        bustools count -o "$GENECOUNT_DIR/genes" -g "$OUTPUTTT" -e "$MATRIX_EC" -t "$TRANSCRIPTS" --genecounts - 

        echo "Завершено для директории: $dir"
    else
        echo "$dir не является директорией. Пропускаем."
    fi
done

echo "Обработка всех директорий завершена."

