#!/bin/bash

# Встановлення змінних для шляхів
CMD_DIR="cmd"
RELEASE_DIR="Release"
APPDATA_DIR="$RELEASE_DIR/AppData"
CONFIG_FILE="dev.yaml"

# Перехід до папки з проектом
cd "$CMD_DIR" || exit 1

# Збірка проекту
go build 
if [ $? -ne 0 ]; then
    echo "Error: Build failed"
    exit 1
fi

# Повернення до батьківської папки
cd ..

# Перевірка існування папки 'Release'
if [ ! -d "$RELEASE_DIR" ]; then
    mkdir "$RELEASE_DIR"
fi

# Переміщення виконавчого файлу та копіювання файлу конфігурації
if [ -d "$RELEASE_DIR" ]; then
    # Створення папки 'AppData'
    mkdir -p "$APPDATA_DIR"

    # Переміщення виконавчого файлу та копіювання файлу конфігурації
    mv "$CMD_DIR/cmd" "$RELEASE_DIR/"
    cp "res/$CONFIG_FILE" "$APPDATA_DIR/"

    # Перейменування файлу конфігурації
    mv "$APPDATA_DIR/$CONFIG_FILE" "$APPDATA_DIR/config.yaml"

    # Перейменування виконавчого файлу
    mv "$RELEASE_DIR/cmd" "$RELEASE_DIR/nosoD"

    echo "Build completed successfully"
else
    echo "Error: Directory 'Release' not found"
    exit 1
fi
