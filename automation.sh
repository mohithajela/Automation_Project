#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
timestamp=$(date '+%d%m%Y-%H%M%S') 
myname="mohit"
s3_bucket="upgrad-mohit12"
tar cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
size=$(du -sh /tmp/${myname}-httpd-logs-${timestamp}.tar | head -n1 | awk '{print $1;}')
echo $size
echo "<tr> <td>httpd-logs</td> <td>${timestamp}</td> <td>tar</td> <td>${size} </td> </tr>">> /var/www/html/inventory.html
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar


if [ ! -f /etc/cron.d/automation ]; then

   echo  "* * * * * root /root/Automation_Project/automation.sh"> /etc/cron.d/automation

fi
