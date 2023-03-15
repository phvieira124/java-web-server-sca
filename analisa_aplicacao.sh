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

#!/bin/bash

CODE="0.AX0AbKr1SsUheUirQTXFhSdr8-ptUj9NT8tFo3sbVOt5APABAL4.AgABAAIAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P8UPd5HPtfgp5lkhNzYduxu9BZ8DVjpUUblT-0wczxi9xw_lpzd7RUSm8HL37t7use_fJdE3JEZK2l9GI1W1O1TH3Rc8G6kzieOYiALCSaxoUCSc0lK7Ih7lq14h5VfTluV_zWvSLPvIX-BpMHVB8sikD8W6N19nOA3h-nXr0wFBTfwzqvalDHGY6DbD0Ve1ggjSt-XTaYGvbMw6iZH4f-mcMUNXjZXEvs_FkJBiJd7Ys4OfmG-McEeEJgr_vs7na-Xkkwx_A49MfgU1GTzgnWOx0AhghU2AccxWVdiBGe6HpLQVqm7S54oAik75RnIwzkvLDtqeP3IG97Hqjb6q7ErWMqHbkDsWAsPTdXZipKbUg8lXqkytAhX-pCqGMRjcIxMC0AIrBDWATBsH96npNJwbVzqRVGiFYSXx9CnoOSmU_51IqKAP9LcsSaN0lIZLM1gIIAgEx8mwtkb_IoYhGWkQuZKAGofoFlrZjTz89ijqVBX4FXqrbGIrvTpugZIrw84QF4u_6c8_9XmDtudUN4iNTYJGXqpXiTj5sj50jOksnM4HIyEfJcoCpyuIh8gFyELhOl_Pz0X0kn6Vp3RpyvwvX3T5gLlABCFw00K4F3NKMph0oQ7qvo9DpebJDosgp8xsjOyknQMM90_fLGLXdpNXpNm_IlYCDhW_UUizBXfMcS7lh7SXMkp4T-i61on6_aGKGWNd2yQunI8gpmTkbjfro6SJwjSj-hDYqF82EArDlImbmNkE3d-LWE1-z5wgoO1OeidMk01TFOzEn6U0Lhv7DfgA7eXb3hgvREWAtwQkxtSTJzmEYUwLl0cdxMpdStvQXkIFzLyf2Dy5iGLT5qg602UKNJ__R8A0H26BJrFgFGWetGApW4h5__mi6hDBWI0MplxPhvkxPY7psmGkRwvfpm9p2sM34RcL3gkF6ikYtNO8TxRgm3xSLf9_F2aMCY1LC9002qKwtE0VsL4V1mmKpwaFRVHm5l-luiDcyCagTpppFPfESUdIhdqTQ7_elgFv5LyuhLFNEC6M9jwfMvV6W6-SJEkt1_gP2AWNs52OZmkjFD2ZrwBnAV5t7020cgPxk2jprlITf-lns5BeY5WO6c0LLQRIfLoiFlPExftPXmRpS3_WN1PjtRKZjbhrUR17o64A2crF04H_QWAviS7iwjg5Ax7Q3Bo-1wjmgIbHnITrESEpjOI8PNVRf4sFuVXjt4aNJoondhj"

# Obtenha um token de acesso OAuth 2.0 válido
token=$(curl -s "https://login.microsoftonline.com/4af5aa6c-21c5-4879-ab41-35c585276bf3/oauth2/token" \
  --request POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "client_id=3f526dea-4f4d-45cb-a37b-1b54eb7900f0" \
  --data-urlencode "client_secret=80O8Q~AW6.M4pOHFnsrCRDCByUp0SMPvwGYoka8f" \
  --data-urlencode "redirect_uri=http://localhost:3000" \
  --data-urlencode "code=$CODE" \
  --data-urlencode "grant_type=authorization_code" | jq -r .access_token)


echo $token

# Chame a API do Graph para obter informações sobre as assinaturas
curl -s -H "Authorization: Bearer $token" "https://graph.microsoft.com/v1.0/subscriptions" | jq .

https://login.microsoftonline.com/4af5aa6c-21c5-4879-ab41-35c585276bf3/oauth2/authorize?client_id=3f526dea-4f4d-45cb-a37b-1b54eb7900f0&response_type=code&redirect_uri=http://localhost:3000&response_mode=query&resource=https://graph.microsoft.com&scope=Subscription.Read.All
