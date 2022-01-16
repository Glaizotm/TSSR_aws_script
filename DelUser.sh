#!/bin/bash

fileList=$1
profile="wf3"
group="TSSR_1068"
for line in $(cat $fileList)
do

    user=$(echo $line |cut -d ',' -f1)
    email=$(echo $line |cut -d ',' -f2)
    credential="file_"$user"_credential"
    # récupératation de la clef dans le fichier json généré a la création
    keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")  

    #suppressier de l'utilisateur du groupe
    aws iam --profile $profile remove-user-from-group --group-name $group --user-name $user
    # suppresssion de l'acces key  
    aws iam --profile $profile delete-access-key --user-name $user --access-key-id $keyId
    
    #suppression du login profile
    aws iam --profile $profile delete-login-profile --user-name $user
    # suppression de l'utilisateur
    aws iam --profile $profile delete-user --user-name $user 




done
