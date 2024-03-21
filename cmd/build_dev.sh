#!/bin/bash

# Збірка проекту
go build 
if [ $? -ne 0 ]; then
    echo "Error: Build failed"
    exit 1
fi

cd ..

# Перевірка чи існує директорія 'Release' у поточній директорії
if [ ! -d "Release" ]; then
    mkdir Release
fi

# Переміщення виконавчого файлу та копіювання файлу конфігурації
if [ -d "Release" ]; then
    mv cmd/cmd Release/
    cp res/dev.yaml Release/
    # Перейменуваня файлів
    mv Release/dev.yaml Release/config.yaml
    mv Release/cmd Release/nosoD

    echo "Build completed successfully"
else
    echo "Error: Directory 'Release' not found"
    exit 1
fi
