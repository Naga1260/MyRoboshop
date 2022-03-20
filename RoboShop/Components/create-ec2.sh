#!/bin/bash

if [ -z $1 ]; then
 echo -e \e[31mInput server name to proceed\e[0m
 exit 1
fi

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')

echo $AMI_ID


aws ec2 run-instance --image-id ${AMI_ID} --instance-type t2.micro "ResourceType=instance,Tags=[{Key=Name,Value={$COMPONENT}}]" | jq