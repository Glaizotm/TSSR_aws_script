#!/bin/bash


profile="wf3"
fileList=$1
pass="#MerciWf3!"
group="TSSR_1068"
for line in $(cat $fileList)
do

    # Récupératio des info User Et email dans la ligne en cour de traitement
    user=$(echo $line |cut -d ',' -f1)
    email=$(echo $line |cut -d ',' -f2)
    # nom du fichier  qui contiendra les credential
    credential="file_"$user"_credential"

    # création de l'utilisateur
    aws iam --profile $profile create-user --user-name $user
    # creation de l'acces key et sauvegarde des info dans le fichier credential
    aws iam --profile $profile create-access-key --user-name $user > $credential

    # récupération de la clef d'identification 

    aws iam --profile $profile create-login-profile --user-name $user --password $pass
    aws iam --profile $profile add-user-to-group --group-name $group --user-name $user

    # recupération des infos d'acces
    keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")
    secret=$(grep SecretAccessKey $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")


    cat << EOF > tempMail
To:$email
Subject:Compte AWS

Votre compte aws a été créé
login : $user
Passwd : $pass
AccessKey : $keyId
SecretKey : $secret

EOF

    sudo ssmtp $email < tempMail


done




