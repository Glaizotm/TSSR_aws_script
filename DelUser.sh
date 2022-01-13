#!/bin/bash

fileList=$1
for line in $(cat $fileList)
do

    user=$(echo $line |cut -d ',' -f1)
    email=$(echo $line |cut -d ',' -f2)
    credential="file_"$user"_credential"
    # récupératation de la clef dans le fichier json généré a la création
    keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")  

    #suppressier de l'utilisateur du groupe
    aws iam remove-user-from-group --group-name GroupeTest --user-name $user
    # suppresssion de l'acces key  
    aws iam delete-access-key --user-name $user --access-key-id $keyId
    
    #suppression du login profile
    aws iam delete-login-profile --user-name $user
    # suppression de l'utilisateur
    aws iam delete-user --user-name $user 




done
