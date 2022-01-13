#!/bin/bash

fileList=$1
for user in $(cat $fileList)
do
    echo $user

    aws iam create-user --user-name $user
    aws iam create-access-key --user-name $user > "file_"$user"_credential"
    aws iam add-user-to-group --group-name GroupeTest --user-name $user
done

