#!/bin/bash

read -p "Base: " base
read -p "Altura: " altura

for ((i=0; i<altura; i++))
do
    for ((j=0; j<base; j++))
    do
        echo -n "#"
    done
    echo
done