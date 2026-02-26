#!/bin/bash

while true
do
    read -s -p "Introduce contraseña: " pass1
    echo
    read -s -p "Confirma contraseña: " pass2
    echo

    if [ "$pass1" = "$pass2" ]; then
        echo "OK - Contraseña correcta"
        break
    else
        echo "ERROR - No coinciden, intenta otra vez"
    fi
done