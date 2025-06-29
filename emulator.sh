#!/bin/bash

# Mostrar opciones
echo "Selecciona un emulador o plataforma:"
echo "1 -> Medium_Phone_API_35"
echo "2 -> Small_Phone"
echo "3 -> Tablet"
echo "4 -> Chrome"

# Leer entrada del usuario
read -p "Ingresa el número de la opción (1-5): " opcion

# Asociar opción con ID del emulador o plataforma
case $opcion in
    1)
        emulador_id="Medium_Phone_API_35"
        echo "Lanzando emulador: $emulador_id"
        flutter emulators --launch "$emulador_id"
        sleep 5
        echo "Ejecutando en modo DEBUG en dispositivo Android..."
        flutter run --debug
        ;;
    2)
        emulador_id="Small_Phone"
        echo "Lanzando emulador: $emulador_id"
        flutter emulators --launch "$emulador_id"
        sleep 5
        echo "Ejecutando en modo DEBUG en dispositivo Android..."
        flutter run --debug
        ;;
    3)
        emulador_id="Tablet"
        echo "Lanzando emulador: $emulador_id"
        flutter emulators --launch "$emulador_id"
        sleep 5
        echo "Ejecutando en modo DEBUG en dispositivo Android..."
        flutter run --debug
        ;;
    4)
        echo "Ejecutando en Chrome..."
        flutter run -d chrome --debug
        ;;

    *)
        echo "Opción no válida."
        exit 1
        ;;
esac
