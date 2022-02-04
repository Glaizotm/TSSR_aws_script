#!/bin/bash

fileList=$1
profile="tssr1068"
group="TSSR_1068"
for line in $(cat $fileList)
do

    user=$(echo $line |cut -d ',' -f1)
    email=$(echo $line |cut -d ',' -f2)
    credential="file_"$user"_credential"
    # récupératation de la clef dans le fichier json généré a la création
    keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")  

    #Ajout de l'utilisateur du groupe
    aws iam --profile $profile add-user-to-group --group-name $group --user-name $user
done
