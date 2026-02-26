#!/bin/bash

echo "1. Espacio libre en disco (%)"
echo "2. Espacio libre (tamaño)"
echo "3. Usuario actual y nombre de la máquina"
echo "4. Número de usuarios en la máquina"
echo "5. Espacio usado en tu carpeta"
echo ""
read -p "Elija una opción: " opcion

case $opcion in

1)
df -h --output=pcent /
;;

2)
df -h
;;

3)
whoami
hostname
;;

4)
cat /etc/passwd | wc -l
;;

5)
du -sh ~
;;

*)
echo "Opción no válida"
;;

esac
