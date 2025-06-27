#!/bin/bash

# Mostrar opciones
echo "Selecciona un emulador:"
echo "1 -> Medium_Phone_API_35"
echo "2 -> Small_Phone"
echo "3 -> Tablet"

# Leer entrada del usuario
read -p "Ingresa el número de la opción (1, 2 o 3): " opcion

# Asociar opción con ID del emulador
case $opcion in
    1)
        emulador_id="Medium_Phone_API_35"
        ;;
    2)
        emulador_id="Small_Phone"
        ;;
    3)
        emulador_id="Tablet"
        ;;
    *)
        echo "Opción no válida."
        exit 1
        ;;
esac

# Lanzar el emulador
echo "Lanzando emulador: $emulador_id"
flutter emulators --launch "$emulador_id"

# Esperar unos segundos para que el emulador arranque
sleep 5

# Ejecutar la app en modo DEBUG explícitamente
echo "Ejecutando en modo DEBUG..."
flutter run --debug
