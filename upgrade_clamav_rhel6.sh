#!/bin/bash
#@lex2019

cd /home/user/opt/rpms/
service clamd stop
mkdir /var/lib/bkp_clamav_old
mv /var/lib/clamav/* /var/lib/bkp_clamav_old/
echo ''
echo 'Old Clamav has been save in /var/lib/bkp_clamav_old'		[ OK ]
echo  ''
echo  'Update been installed...'
echo  ''
rpm -Uvh --force clamav-0.100.1-1.el6.x86_64.rpm clamav-db-0.100.1-1.el6.x86_64.rpm clamd-0.100.1-1.el6.x86_64.rpm json-c-0.11-13.el6.x86_64.rpm

echo  ''
echo  ''
rm -f /var/lib/clamav/daily.*

#Import the latest update of freshclam - update 2018/09
cp daily.cld /var/lib/clamav/
echo 'The viral definition database has been copied'			[ OK ]

# Comment a line in clamd.conf to fix an error when service start

sed -i '/AllowSupplementaryGroups/s/^/#/g' /etc/clamd.conf

#start service clamd (can take more than 2 min)
echo  ''
sudo service clamd start
echo  ''
echo 'Clam AntiVirus has started'			[ OK ]
echo  ''
sudo chkconfig clamd on
echo  ''
echo 'Latest Clam AntiVirus packets have been succesfull installed'			[ OK ]	
echo  ''
rpm -qa --last |grep clam

exit
