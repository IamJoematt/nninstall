#!/bin/bash
clear
echo "This installs newznab apache sql sphinx mediainfo ffmpeg and everything that is needed to your ubuntu install."
echo 
echo "Setup will continue in a few seconds."
echo 
echo "After successfull install please go to http://localhost/install/"
echo
echo
echo
echo
echo
echo "\033[1;31mYOU MUST HAVE YOUR SVN USERNAME AND PASSWORD TO FINISH THIS INSTALL.\033[1;37m"

echo "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License version 2, as published by the Free Software Foundation."

echo "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
echo "See the GNU General Public License for more details."


echo "Please be Patient ...."

sleep 3
clear


#echo "Checking for root before we begin...."

if ! [ $(id -u) = 0 ]; then
echo "You must be root to do this DOH...." 1>&2
exit 100
fi 
 
#echo "\033[1;32mElevated privileges confirmed.\nBeginning configurations...\033[1;37m"
#sleep 2
#clear 
#echo "Check if libnotify-bin is installed"
#sleep 2
#hash notify-send 2>&- || 
#{
#echo >&2 "libnotify-bin is not present in your Ubuntu version"
#echo "Installing it now...."
#sleep 5
#add-apt-repository -y -q=3 ppa:leolik/leolik
#apt-get -q=3 update
#apt-get install -y -q=3 libnotify-bin
#}
echo "Updating Please Wait....." 
apt-get -q=3 update
#apt-get -q=3 dist-upgrade
 
 
#echo "Libnotify is installed"
echo "--------------------------------------------"
echo "Please Wait"
sleep 3

clear
echo "DISCLAIMER"
echo " # This script is made available to you without any express, implied or "
echo " # statutory warranty, not even the implied warranty of "
echo " # merchantability or fitness for a particular purpose, or the "
echo " # warranty of title. The entire risk of the use or the results from the use of this script remains with you."

echo "---------------------------------------------------------------------------------------------------------------"
echo -n -e "Do you understand?\n   (y or n)\n"
read choice
if [ "$choice"=="y" -o "$choice"=="Y" ]
then
clear
# Installing Prerequirements

echo "Installing Prerequirements......"
#notify-send -t 5000 "Installing prerequirements now..."

apt-get -q=3  update
apt-get install -y -q=3 openssh-server

sleep 3

apt-get install -y -q=3 build-essential checkinstall
sleep 3
mkdir -p /var/www/newznab
sleep 3
chmod 777 /var/www/newznab
sleep 3
apt-get install -y -q=3 php5
apt-get install -y -q=3 php5-dev
apt-get install -y -q=3 php-pear
apt-get install -y -q=3 php5-gd
apt-get install -y -q=3 php5-mysql
apt-get install -y -q=3 php5-curl


sleep 3

apt-get -y install -q=3 mysql-server mysql-client libmysqlclient-dev
sleep 1
apt-get -y install -q=3 apache2
sleep 1


a2dissite default
a2ensite newznab
a2enmod rewrite
service apache2 restart

sleep 1
apt-get -y install -q=3 python-software-properties
add-apt-repository -y  ppa:jon-severinsson/ffmpeg
add-apt-repository -y  ppa:shiki/mediainfo
echo "Prerequirements installed...."
sleep 5
fi

clear
#echo "-----------------------------------------------------------------------"
#echo -n -e "Do you want to install Sphinx?\n   (y or no.)\n"
#read choice
#if [ "$choice"=="y" -o "$choice"=="Y" ]
#then
#echo "Installing Sphinxsearch..."
#notify-send -t 5000 "Installing Sphinxsearch..."
#add-apt-repository -y ppa:builds/sphinxsearch-stable
#apt-get -q=3 update
#apt-get install -y -q=3 sphinxsearch
#echo "Sphinx is now installed....."
#fi

#sleep 2

#clear

echo "Installing ffmpeg x264 mediainfo unrar lame..."
#notify-send -t 2000 "Installing ffmpeg x264 mediainfo unrar lame..."

apt-get -q=3 update
apt-get -y install -q=3 ffmpeg
apt-get -y install -q=3 x264
apt-get -y install -q=3 mediainfo
apt-get -y install -q=3 unrar
apt-get -y install -q=3 lame
# apt-get -y install phpmyadmin

echo "ffmpeg x264 mediainfo unrar lame is now installed..."
sleep 5 

clear


# service apache2 stop
# service mysql stop

echo "Installing Subversion..."
#notify-send -t 2000 "Installing Subversion..."

apt-get -y install -q=3 subversion
echo "Subversion is now installed..."
sleep 5

clear


echo "Installing Newznab+"
#notify-send -t 2000 "Installing Newznab+"
svn co svn://svn.newznab.com/nn/branches/nnplus /var/www/newznab
chmod -R 777 /var/www/newznab
clear
echo "Newznab+ is now installed"

service apache2 start
service mysql start


service apache2 stop
service mysql stop
clear

echo "Modifying system Files....."
#notify-send -t 2000 "Modifying system files....."
sleep 1
clear
wget -O /home/newznab http://bandofbrothers.3owl.com/nn/newznab
mv /home/newznab /etc/apache2/sites-available/newznab
clear
wget -O /home/php.ini http://bandofbrothers.3owl.com/nn/apache/php.ini
mv /home/php.ini /etc/php5/apache2/php.ini
clear
wget -O /home/php.ini http://bandofbrothers.3owl.com/nn/cli/php.ini
mv /home/php.ini /etc/php5/cli/php.ini
clear

sudo a2dissite default
clear
sudo a2ensite newznab
clear
sudo a2enmod rewrite
clear

service apache2 start
clear
service mysql start
clear
echo "System files modified....."
sleep 3
clear

#echo "-----------------------------------------------------------------------------------------"
#echo "If you did not install Sphinx earlyer hit no"
#echo -n -e "Do you want to run and configure Sphinxsearch?\n   (y or no.)\n"
#read choice
#if [ "$choice"=="y" -o "$choice"=="Y" ]
#then

#cd /var/www/newznab/misc/sphinx
#php ./nnindexer.php generate
#sleep 15
#php ./nnindexer.php daemon
#sleep 15
#php ./nnindexer.php index full all
#sleep 35
#php ./nnindexer.php delta all
#sleep 35
#php ./nnindexer.php daemon --stop
#sleep 15
#php ./nnindexer.php daemon
#sleep 15
#echo "Sphinxsearch successfully started"
#sleep 5
#fi
#clear

echo "---------------------------------------------"
#echo "Do you want to install Phpmyadmin?" yn
#select yn in "Yes" "No"; do
#case $yn in
#[Yy]* ) make install; break;;
#[Nn]* ) exit;;
#* ) echo Please anser yes or no.";;
#esac
#done
 

echo "Installing PhpMyadmin..."
echo "Make sure you put a checkmark in the apache2 checkbox before hitting enter"
sleep 5
#notify-send -t 2000 "Installing PhpMyadmin..."
apt-get install -y -q=3 phpmyadmin
echo "PhpMyadmin is installed..."

sleep 3

clear


echo "---------------------------------------------"
#echo -n -e "Do you want to install Jonnyboy's tmux scripts?\n   (y or no.)\n"
#read choice
 
#if [ "$choice"=="y" -o "$choice"=="Y" ]
#then
cd /var/www/newznab/misc/update_scripts/nix_scripts/
git clone https://github.com/jonnyboy/newznab-tmux.git tmux
cd tmux
cp config.sh defaults.sh
#fi

clear
echo "-----------------------------------------------"
echo "Make sure to edit the defaults.sh to your likeing if you choose to run Jonny's script then go into the scripts folder and run ./svn_update.sh"
echo "\033[1;31mDO NOT SKIP THAT STEP YOU HAVE BEEN WARNED!!!\033[1;37m"
sleep 7
clear


echo "Install Complete...."
echo "Go to http://localhost/install to finish NN+ install."
#echo "After that you have to enable sphinx in your admin panel then generate your sphinx config."
echo "For questions and problems log on to #newznab or #newznab-tmux on Synirc and look for zombu2"
echo "Good Luck."
