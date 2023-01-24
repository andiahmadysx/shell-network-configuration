#!/bin/bash
# Author : Andi Ahmad Yusup
# Email : andiahmadyusup@gmail.com
# Country : Indonesia

# Set Permission
chmod +x script.sh
# Create variable to loop the program
while_var=true

# Set while looping

while $while_var ; do
echo " "

echo "## Select Option ##"
echo "1. Show Ip Address"
echo "2. Show Connection"
echo "3. Add Connection"
echo "4. Delete Connection"
echo "5. Modify Connectin"
echo "6. Activate Connection"        
echo "7. Deactivate Connection"      
echo "8. Exit Program"

echo " "

# Create Input Option for user      
read -p "Select Option : " OPTION   

# Store recive value to case        
case $OPTION in
1 )
##
ifconfig
;;

2 )
##
nmcli connection show
;;

3 )
##
read -p "Ipv4 Address : " IP_ADDRESS
read -p "Device Name : " NAME
read -p "Ipv4 Gateway : " IP_GATEWAY
read -p "Ipv4 DNS : " DNS
read -p "Type : " TYPE
nmcli connection add ipv4.addresses $IP_ADDRESS ifname $NAME ipv4.gateway $IP_GATEWAY ipv4.dns $DNS type $TYPE
;;

4 )
##
read -p "Connection Name : " CON_NAME
read -p "Are you sure to delete $CON_NAME? [y/N] " ENSURE
if [[ $ENSURE =~ ^([yY][eE][sS]|[yY])$ ]]
then
nmcli connection delete $CON_NAME
else
echo "Exit Option..."
fi
;;

5 )
##
clear
read -p "Connection Name : " CONN_NAME
echo  "## Option to Modify ##"
echo "1. IP"
echo "2. Gateway"
echo "3. DNS"
echo "4. ALL"
read -p  "Select Option : " VALUE

case $VALUE in
1 )
read -p "New IP Address : " NEW_IP
nmcli connection modify $CONN_NAME ipv4.addresses $NEW_IP
;;
2 )
read -p "New Gateway : " NEW_GATEWAY
nmcli connection modify $CONN_NAME ipv4.gateway $NEW_GATEWAY
;;
3 )
read -p "New DNS : " NEW_DNS
nmcli connection modify $CONN_NAME ipv4.dns $NEW_DNS
;;
4 )
read -p "New IP Address :" NEW_IP
read -p "New Gateway : " NEW_GATEWAY
read -p "New DNS : " NEW_DNS
nmcli connection modify $CONN_NAME ipv4.addresses $NEW_IP ipv4.gateway $NEW_GATEWAY ipv4.dns $NEW_DNS
;;
esac
;;

6 )
##
read -p "Connection name to Activate : " ACTIVATE_NAME
nmcli connection up $ACTIVATE_NAME
;;
7 )
read -p "Connection name to Deactivate : " DEACTIVATE_NAME
nmcli connection down $DEACTIVATE_NAME
;;
8 )
##
clear
exit
esac

# Create Option if user want restart the program or exit the program
read -p "Restart Program?(y/N)" RESTART

if [[ $RESTART =~ ^([yY][eE][sS]|[yY])$ ]]
then
clear
else
clear
echo "Exiting Program"
exit
fi
done
