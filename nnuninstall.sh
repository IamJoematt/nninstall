echo "This will Uninstall Newznab and everything associated with it from your machine"
echo "Caution you have 10 seconds to hit CTRL+C to terminate"
sleep 10
clear
echo "Now it s too late :)"



#echo "Checking for root before we begin...."

if ! [ $(id -u) = 0 ]; then
echo "You must be root to do this DOH...." 1>&2
exit 100
fi 
echo "\033[1;32mElevated privileges confirmed.\nBeginning configurations...\033[1;37m"
sleep 2
clear
echo "If you see an error removing phpmyadmin choose abort and uninstall will continue\nand phpmyadmin will be removed."
sleep 5
apt-get remove --purge -y -q=3 phpmyadmin php5 php5-dev php-pear php5-gd php5-mysql php5-curl mysql-server mysql-client mysql-common sphinxsearch libmysqlclient-dev apache2 python-software-properties ffmpeg x264 mediainfo unrar lame subversion  php-apc
apt-get autoremove -y -q=3
apt-get autoclean
rm -rf /etc/mysql
#find / -iname 'mysql*' -exec rm -rf {} \;
clear
rm -rf /var/www/newznab/
echo "All Gone you Fucked!!!"
sleep 5
