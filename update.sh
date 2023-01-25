#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
wget -q -O logo.sh https://raw.githubusercontent.com/asikmaster/packages-for-ubuntu/main/logo.sh && chmod +x logo.sh && sudo /bin/bash logo.sh && sleep 3
echo -e "Your FORTA UPDATE STARTED"
systemctl stop forta.service
echo -e "YOUR FORTA VERSION IS:"
forta version
echo -e "STOP FORTA SERVICE WAIT 10 sec"
sleep 10
cd $HOME
RD=$RANDOM
echo backup folder will be: /root/forta_backup_$RD && sleep 1
mkdir -p forta_backup_$RD
echo -e "Backup folder created"
cp -r .forta forta_backup_$RD/
cp /lib/systemd/system/forta.service forta_backup_$RD/
sleep 1
echo -e "Backup .forta and service created!"

apt update && sudo apt upgrade forta -y
cd $HOME
cp forta_backup_$RD/forta.service /lib/systemd/system/
echo -e "Restarting all services wait 5 sec"
sleep 1
systemctl daemon-reload
sleep 1
systemctl restart forta.service
sleep 3
forta version
sleep 3
echo -e "All containers will be avaible after 30sec! Please wait"
sleep 3
watch 'forta status'
