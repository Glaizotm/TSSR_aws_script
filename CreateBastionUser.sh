#!/bin/bash

# Création d'une liste d'utilisateur avec acces ssh par clef sur un serveur 
#Creation d'un clef RSA + envoie la clef privé par mail

# ./CreateBastion fichierListeUser clefConnectionServeurBastion

# le fichier fichierListeUser cointient des ligne de la forme nonUser,Mail

clef=$2
fileList=$1
ipBastion="35.180.18.117"


for line in $(cat $fileList)
do

    user=$(echo $line |cut -d ',' -f1)
    email=$(echo $line |cut -d ',' -f2)

    ssh-keygen -N "" -t RSA -f /tmp/tempClef

    ssh -i $clef admin@$ipBastion sudo adduser --disabled-password --gecos \"\" $user
    scp -i $clef /tmp/tempClef.pub admin@$ipBastion:/tmp/
    ssh -i $clef admin@$ipBastion sudo mkdir /home/$user/.ssh
    ssh -i $clef admin@$ipBastion sudo mv /tmp/tempClef.pub /home/$user/.ssh/authorized_keys
    ssh -i $clef admin@$ipBastion sudo chown -R $user:$user /home/$user/.ssh 
    ssh -i $clef admin@$ipBastion sudo chmod 700 /home/$user/.ssh 
    ssh -i $clef admin@$ipBastion sudo chmod 600 /home/$user/.ssh/authorized_keys

    clefPriv=$(cat /tmp/tempClef)
    rm /tmp/tempClef*


cat << EOF > tempMail
To:$email
Subject:Acces Bastion

Votre compte Bastion a été créé
login : $user
ip : $ipBastion

Votre Clef Privé : 
$clefPriv

EOF

    sudo ssmtp $email < tempMail

done

