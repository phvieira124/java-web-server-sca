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

eyJ0eXAiOiJKV1QiLCJub25jZSI6Ik85eUNWTFEyejRoYUJpSzh3MHFwRXc1OWlQSTlSQndUY0VRdE4xUkVPMW8iLCJhbGciOiJSUzI1NiIsIng1dCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC80YWY1YWE2Yy0yMWM1LTQ4NzktYWI0MS0zNWM1ODUyNzZiZjMvIiwiaWF0IjoxNjc4ODg5NzEwLCJuYmYiOjE2Nzg4ODk3MTAsImV4cCI6MTY3ODg5NDYwOCwiYWNjdCI6MCwiYWNyIjoiMSIsImFpbyI6IkFZUUFlLzhUQUFBQWF0SG14WHZhSWZ3U2ZqTFRxSk1zWHhBL0JqUU51Ymk2ZDlHM2t4cG5zVERXSGRoL244MjdtSStqcllaNW8zalFkQ3lBOEQ2cnIwNXRLUHlsMHRvWVk3MmpBVjdjUEJxNy9kUGZpSXpud2FuaWdKYVFiVUt6M0kxcDNPMk9IYlNBRTVyM1JNUVRWaDcvaXdyWktBalhBZGFST2RvdmtpTnRPVkd2QW1nejJnST0iLCJhbHRzZWNpZCI6IjE6bGl2ZS5jb206MDAwNjAwMDBBRjc2NDkxOSIsImFtciI6WyJwd2QiLCJtZmEiXSwiYXBwX2Rpc3BsYXluYW1lIjoiZXhlbXBsby1hcHAiLCJhcHBpZCI6IjNmNTI2ZGVhLTRmNGQtNDVjYi1hMzdiLTFiNTRlYjc5MDBmMCIsImFwcGlkYWNyIjoiMSIsImVtYWlsIjoicGVkcm8uaGVucmlxdWV2QGhvdG1haWwuY29tIiwiZmFtaWx5X25hbWUiOiJWaWVpcmEiLCJnaXZlbl9uYW1lIjoiUGVkcm8gSGVucmlxdWUiLCJpZHAiOiJsaXZlLmNvbSIsImlkdHlwIjoidXNlciIsImlwYWRkciI6IjE5MS44Ljg3LjE0OCIsIm5hbWUiOiJQZWRybyBIZW5yaXF1ZSBWaWVpcmEiLCJvaWQiOiIzZWY3ZThkNC03YjhjLTQzOTItYTEzMy05NmYwYjYxMjg3ZDkiLCJwbGF0ZiI6IjgiLCJwdWlkIjoiMTAwMzIwMDFGN0E3QTREMCIsInJoIjoiMC5BWDBBYktyMVNzVWhlVWlyUVRYRmhTZHI4d01BQUFBQUFBQUF3QUFBQUFBQUFBQ2FBRUkuIiwic2NwIjoiU3Vic2NyaXB0aW9uLlJlYWQuQWxsIFVzZXIuUmVhZCIsInNpZ25pbl9zdGF0ZSI6WyJrbXNpIl0sInN1YiI6IlFMTktUVUR3RVlUZXozSmpmdnRnNkVZc0lLVGRBcmVRZmRza09wcml5dFkiLCJ0ZW5hbnRfcmVnaW9uX3Njb3BlIjoiU0EiLCJ0aWQiOiI0YWY1YWE2Yy0yMWM1LTQ4NzktYWI0MS0zNWM1ODUyNzZiZjMiLCJ1bmlxdWVfbmFtZSI6ImxpdmUuY29tI3BlZHJvLmhlbnJpcXVldkBob3RtYWlsLmNvbSIsInV0aSI6InpyNWlPdS1Sd0V1emo4d3cwY2xsQUEiLCJ2ZXIiOiIxLjAiLCJ3aWRzIjpbIjYyZTkwMzk0LTY5ZjUtNDIzNy05MTkwLTAxMjE3NzE0NWUxMCIsImI3OWZiZjRkLTNlZjktNDY4OS04MTQzLTc2YjE5NGU4NTUwOSJdLCJ4bXNfdGNkdCI6MTY1MTg1NjQwNH0.CfoD1jY0sL1c2sSnoDeRAUjyAF9Hd4E75oA4g0dXtmbuWYsYb0Yr1b5NlcTfHC0mPPX4T-MMxmT3DKRsb0gBm7z4w2slmklCr1IrnnvUhyKEPfmoMaoHg-kIY7hL1_MFFWriETYkCLnYjbe2x-UDE_QhYDApjrZnvMxYCJSAFKMSD3SqA7TzJa4nqfhdomwvnyhnH2pTaOSpnI_IvG0dLJfmxS6ctMIaX8GuLEC4N4leDo3ExENeInaCCEG6AKLTkWdNWy94a7C_XihWRCrf9LgLnS8ABqJVabX4MHBKAblYoVhgu2amYM05S3n1d0CepDJp6sBifNiSHUt9h-KtzQ
