#!/usr/bin/env bash
su ec2-user

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

sudo apt update
sudo apt upgrade -y

sudo apt install -y nfs-common

# EFS mount

unencryptedDnsName=$(aws ssm get-parameter --name /efs/unencrypted/dnsname --query Parameter.Value --output text)
encryptedDnsName=$(aws ssm get-parameter --name /efs/encrypted/dnsname --query Parameter.Value --output text)

mkdir ~/efs-mount-point
mkdir ~/efs-mount-point-encrypted

sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $unencryptedDnsName:/   ~/efs-mount-point
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $encryptedDnsName:/   ~/efs-mount-point-encrypted
