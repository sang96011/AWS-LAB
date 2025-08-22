#!/bin/bash

#This script assumes the following lines were already run as part of userdata before it is called:
#yum -y update
#yum install -y httpd mariadb-server
#amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 wget
#systemctl enable httpd
#systemctl start httpd
#systemctl enable mariadb
#systemctl start mariadb
#wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-200-ACACAD-20-EN/mod10-challenge/cafe-app.sh
#chmod +x cafe-app.sh
#./cafe-app.sh
echo '<html><h1>Hello From Your Web Server!</h1></html>' > /var/www/html/index.html
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo '<?php phpinfo(); ?>' > /var/www/html/phpinfo.php
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-200-ACACAD-20-EN/mod8-challenge/setup.tar.gz
tar -zxvf setup.tar.gz
# wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-200-ACACAD-20-EN/mod8-challenge/db.tar.gz
# update folder db/sql/set-root-password.sql
wget https://github.com/sang96011/AWS-LAB/raw/refs/heads/main/db.tar.gz
tar -zxvf db.tar.gz
wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-200-ACACAD-20-EN/mod8-challenge/cafe.tar.gz
tar -zxvf cafe.tar.gz -C /var/www/html/
# Update AWSSDK
rm /var/www/html/cafe/AWSSDK/aws.phar
wget https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.phar
mv aws.phar /var/www/html/cafe/AWSSDK/aws.phar
cd db
./set-root-password.sh
./create-db.sh
# Update parameter /cafe/dbUrl = publicDNS -> move to cafe-parameter
# publicDNS=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
# aws ssm put-parameter --name "/cafe/dbUrl" --type "String" --value $publicDNS --description "Database URL" --overwrite
#region=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone|sed 's/.$//')
#privIp=$(ifconfig|grep 'inet '|grep -v 127.0.0.1|awk '{print $2}')
#aws ssm put-parameter --name "/cafe/db+Url" --type "String" --value $privIp --overwrite --region $region
#aws ssm put-parameter --name "/cafe/dbPassword" --type "String" --value 'Re:Start!9' --overwrite --region $region
#aws ssm put-parameter --name "/cafe/dbName" --type "String" --value 'cafe_db' --overwrite --region $region
#aws ssm put-parameter --name "/cafe/dbUser" --type "String" --value 'root' --overwrite --region $region
