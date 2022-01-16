#!/bin/bash

profile="wf3"
ec2tags=$1
listeFile="listeInstance"


aws ec2 --profile $profiles describe-instances --filters "Name=tag:Name,Values=*$ec2tags*" --query "Reservations[].Instances[].InstanceId" |sed '/\[/d' |sed '/\]/d' |sed 's/[",\,]//g' | sed 's/^[ \t]*//g' > $listeFile

for instance in $(cat $listeFile) 
do

    echo $instance
    aws ec2 --profile $profiles stop-instances --instance-ids $instance

done

rm $listeFile
