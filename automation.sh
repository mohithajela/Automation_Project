#!/bin/sh
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
timestamp=$(date '+%d%m%Y-%H%M%S') 
myname="mohit"
s3_bucket="upgrad-mohit12"
tar cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
