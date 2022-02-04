

keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")
secret=$(grep SecretAccessKey $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")

#     # ajout d' un utilisateur a la CLI
#     echo "set key"
#     aws configure set aws_access_key_id $keyId --profile temp
#     echo "set secret"
#     aws configure set aws_secret_access_key $secret --profile temp
