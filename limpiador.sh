##!/bin/bash

# 1. Validación de Directorio
DIR="${1:-.}"
[ ! -d "$DIR" ] && echo "Error: El directorio no existe." && exit 1
cd "$DIR" || exit

# 2. Creación de estructura (Silenciosa)
mkdir -p IMGS DOCS TXTS PDFS VACIOS

# 3. Contadores
imgs=0; docs=0; txts=0; pdfs=0; vacios=0

# 4. Clasificación de archivos
# Use nullglob para evitar errores si no hay archivos de un tipo
shopt -s nullglob

for file in *; do
    # Saltamos si es un directorio (incluyendo los recién creados)
    [ -d "$file" ] && continue
    
    if [ ! -s "$file" ]; then
        mv "$file" VACIOS/ && ((vacios++))
    else
        case "${file,,}" in # ,, convierte a minúsculas para mayor compatibilidad
            *.jpg|*.png|*.gif) mv "$file" IMGS/ && ((imgs++)) ;;
            *.docx|*.odt)      mv "$file" DOCS/ && ((docs++)) ;;
            *.txt)             mv "$file" TXTS/ && ((txts++)) ;;
            *.pdf)             mv "$file" PDFS/ && ((pdfs++)) ;;
        esac
    fi
done

# 5. Gestión de elementos vacíos (Carpetas y Archivos)
# Se busca elementos vacíos excluyendo el punto actual
mapfile -t vacios_lista < <(find . -mindepth 1 -empty)

echo -e "\n--- INFORME DE ORDENACIÓN ---"
echo " Imágenes: $imgs | DOCS: $docs | TXTS: $txts |  PDFs: $pdfs"
echo " Elementos vacíos detectados: ${#vacios_lista[@]}"

if [ ${#vacios_lista[@]} -gt 0 ]; then
    echo -e "\nLista de elementos vacíos:"
    printf " - %s\n" "${vacios_lista[@]}"
    
    read -p "¿Eliminar estos elementos? (s/n): " respuesta
    if [[ "$respuesta" =~ ^[Ss]$ ]]; then
        for item in "${vacios_lista[@]}"; do rm -rf "$item"; done
        echo "Limpieza completada."
    else
        echo "  Operación cancelada."
    fi
fi

