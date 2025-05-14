#!/bin/bash

# Caminho para o arquivo de imagem
IMAGE="/path/to/image.jpg"

# Wordlist com as senhas para tentar (uma por linha)
WORDLIST="/path/to/wordlist.txt"

# Loop pelas senhas da wordlist
while read -r password; do
    echo "[*] Tentando senha: $password"

    # Tenta extrair usando a senha
    steghide extract -sf "$IMAGE" -p "$password" -xf output.txt -f > /dev/null 2>&1

    # Verifica se a extração foi bem-sucedida
    if [ $? -eq 0 ]; then
        echo "[+] Senha encontrada: $password"
        exit 0
    fi
done < "$WORDLIST"

echo "[-] Nenhuma senha da wordlist funcionou."
