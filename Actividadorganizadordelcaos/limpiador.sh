#!/bin/bash

# Si no se pasa parámetro, usa el directorio actual
DIR="${1:-.}"

if [ ! -d "$DIR" ]; then
    echo "El directorio no existe."
    exit 1
fi

cd "$DIR" || exit

mkdir -p IMGS DOCS TXTS PDFS VACIOS

imgs=0
docs=0
txts=0
pdfs=0
vacios=0

# Mover archivos según extensión
for file in *; do
    if [ -f "$file" ]; then
        if [ ! -s "$file" ]; then
            mv "$file" VACIOS/
            ((vacios++))
        else
            case "$file" in
                *.jpg|*.png|*.gif)
                    mv "$file" IMGS/
                    ((imgs++))
                    ;;
                *.docx|*.odt)
                    mv "$file" DOCS/
                    ((docs++))
                    ;;
                *.txt)
                    mv "$file" TXTS/
                    ((txts++))
                    ;;
                *.pdf)
                    mv "$file" PDFS/
                    ((pdfs++))
                    ;;
            esac
        fi
    fi
done

# Buscar archivos y carpetas vacías
vacios_lista=()

while IFS= read -r line; do
    vacios_lista+=("$line")
done < <(find . -type f -empty -o -type d -empty)

echo "------------------------------------"
echo "INFORME:"
echo "Imágenes movidas: $imgs"
echo "Documentos movidos: $docs"
echo "Textos movidos: $txts"
echo "PDFs movidos: $pdfs"
echo "Archivos vacíos movidos: $vacios"
echo "------------------------------------"

if [ ${#vacios_lista[@]} -gt 0 ]; then
    echo "Elementos vacíos encontrados:"
    for item in "${vacios_lista[@]}"; do
        echo " - $item"
    done

    read -p "¿Deseas eliminarlos? (s/n): " respuesta

    if [[ "$respuesta" == "s" ]]; then
        for item in "${vacios_lista[@]}"; do
            rm -rf "$item"
        done
        echo "Elementos vacíos eliminados."
    else
        echo "No se eliminaron elementos."
    fi
fi