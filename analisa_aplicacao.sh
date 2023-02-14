#!/bin/bash

folder="/home/kali/dpck"
folder_dpck_cli_sh="/home/kali/dependency_check/dependency-check/bin/dependency-check.sh --scan"
folder_projects="/home/kali/analise_projetos"

if [ ! -d "$folder" ]; then
  echo "A pasta $folder não existe. Por favor, crie-a antes de executar este script."
  exit 1
fi

while true; do
    last_file=$(ls -t "$folder" | head -1)
    
    if [ -n "$last_file" ]; then
        file_name="${last_file%.*}"
        file_extension="${last_file##*.}"
        first_word=$(echo "$file_name" | cut -d '-' -f 1)
        
        if [[ "$first_word" == *"java"* ]]; then
            echo "O zip e do tipo java: $last_file"
            date_file=$(date +"%Y-%m-%d_%H-%M-%S")
            java_folder="$folder_projects/java/$file_name"
            date_folder="$java_folder/$date_file"
            zip_file="$date_folder/$file_name.$file_extension"

            mkdir -p "$date_folder"
            mv "$folder/$last_file" "$zip_file"
            unzip "$zip_file" -d "$date_folder"
            
            $folder_dpck_cli_sh "$date_folder/target"
        fi
    fi

    sleep 1
done
