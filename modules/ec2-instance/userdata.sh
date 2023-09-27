#!/usr/bin/env bash
su ubuntu

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

sudo apt update
sudo apt upgrade -y

sudo apt install -y unzip nfs-common

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# EFS mount
unencryptedDnsName=$(aws ssm get-parameter --name /efs/unencrypted/dnsname --query Parameter.Value --output text)
encryptedDnsName=$(aws ssm get-parameter --name /efs/encrypted/dnsname --query Parameter.Value --output text)

mkdir ~/efs-mount-point
mkdir ~/efs-mount-point-encrypted

sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $unencryptedDnsName:/   ~/efs-mount-point
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $encryptedDnsName:/   ~/efs-mount-point-encrypted
