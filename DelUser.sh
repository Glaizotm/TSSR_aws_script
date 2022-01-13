#!/bin/bash

fileList=$1
for user in $(cat $fileList)
do
    credential="file_"$user"_credential"
    echo $credential
    keyId=$(grep KeyId $credential |cut -d: -f2 |sed "s/\ \"//g" |sed "s/\",//g")  
    echo $user $keyId

    aws iam remove-user-from-group --group-name GroupeTest --user-name $user
    aws iam delete-access-key --user-name $user --access-key-id $keyId
    aws iam delete-user --user-name $user 
done

