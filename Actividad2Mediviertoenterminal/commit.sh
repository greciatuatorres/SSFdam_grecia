#!/bin/bash

MENSAJE="$1"

git add .
git commit -m "$MENSAJE"
git push
