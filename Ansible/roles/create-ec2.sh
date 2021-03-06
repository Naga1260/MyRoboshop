#!/bin/bash

if [ -z $1 ]; then
 echo -e \e[31mInput server name to proceed\e[0m
 exit 1
fi

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" | jq '.Images[].ImageId' | sed -e 's/"//g')
security_group=$(aws ec2 describe-security-groups --filters Name=group-name,Values=Allow-All-from-Public | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')

echo $AMI_ID
echo $security_group

IP_Address=$(aws ec2 run-instances \
  --image-id ${AMI_ID} \
  --instance-type t2.micro \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" \
  --security-group-ids $security_group \
  --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" \
  | jq '.instances[].PrivateIpAddress' | sed -e 's/"//g')