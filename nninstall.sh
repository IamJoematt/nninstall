#!/bin/bash

clear
echo "This installs newznab apache sql sphinx mediainfo ffmpeg and everything that is needed to your ubuntu install.\n\nSetup will continue in a few seconds.\n"
echo "After successfull install please go to http://localhost/install/\n\n"
echo "\033[1;31mYOU MUST HAVE YOUR SVN USERNAME AND PASSWORD TO FINISH THIS INSTALL.\033[1;37m\n"
echo "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License version 2, as published by the Free Software Foundation.\n"

echo "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
echo "See the GNU General Public License for more details.\n"


echo "Please be Patient ...."

sleep 8
clear



rootcheck ()
{
echo "Checking for root before we begin...."

if ! [ $(id -u) = 0 ]; then
echo "You must be root to do this DOH...." 1>&2
exit 100
fi 
echo "\033[1;32mElevated privileges confirmed.\nBeginning configurations...\033[1;37m"
sleep 2
}

update () 
{
echo "Updating Please Wait....." 
apt-get -q=3 update
clear
}

disclaimer ()
{
echo "               Please Wait"
echo "--------------------------------------------"
sleep 3
clear
echo "DISCLAIMER"
echo " # This script is made available to you without any express, implied or "
echo " # statutory warranty, not even the implied warranty of "
echo " # merchantability or fitness for a particular purpose, or the "
echo " # warranty of title. The entire risk of the use or the results from the use of this script remains with you."

echo "---------------------------------------------------------------------------------------------------------------"
echo "Do you Agree?"
echo "y=YES n=NO"

}
while [ 1 ]
do
    disclaimer
    read CHOICE
    case "$CHOICE" in
          "y")
               clear
              #Installing Prerequirements

                    echo "Installing Prerequirements......"

#                    apt-get install -y -q=3 openssh-server
						apt-get install -y -q=3 build-essential checkinstall
						mkdir -p /var/www/newznab
						chmod 777 /var/www/newznab
						apt-get install -y -q=3 php5
						apt-get install -y -q=3 php5-dev
						apt-get install -y -q=3 php-pear
						apt-get install -y -q=3 php5-gd
						apt-get install -y -q=3 php5-mysql
						apt-get install -y -q=3 php5-curl
						apt-get -y install -q=3 mysql-server mysql-client libmysqlclient-dev
						apt-get -y install -q=3 apache2
						a2dissite default
						a2ensite newznab
						a2enmod rewrite
						service apache2 restart
						apt-get -y install -q=3 python-software-properties
						add-apt-repository -y  ppa:jon-severinsson/ffmpeg
						add-apt-repository -y  ppa:shiki/mediainfo
					echo "Prerequirements installed...."
				sleep 5
			clear 
			break
          ;;
          "n")     
               exit
          ;; 
      esac
 done         











sphinx ()
{
echo "Do you want to install Sphinx?"
echo "y=YES n=NO"
}
while [ 1 ]
do sphinx
read CHOICE
case "$CHOICE" in


					"y")
clear
		echo "Installing Sphinxsearch..."
sleep 3
#		add-apt-repository -y ppa:builds/sphinxsearch-stable
#		apt-get -q=3 update
		apt-get install -y -q=3 sphinxsearch
	echo "Sphinx is now installed....."
sleep 2
clear
break
;;
					"n")
echo "Skipping Sphinx install"
sleep 2 && clear && break

;;					

esac

done


echo "Installing ffmpeg x264 mediainfo unrar lame..."

apt-get -q=3 update
apt-get -y install -q=3 ffmpeg
apt-get -y install -q=3 x264
apt-get -y install -q=3 mediainfo
apt-get -y install -q=3 unrar
apt-get -y install -q=3 lame
clear
echo "ffmpeg x264 mediainfo unrar lame is now installed..."
sleep 5 

clear


 service apache2 stop
 service mysql stop



echo "Installing Subversion..."
apt-get -y install -q=3 subversion
clear
echo "Subversion is now installed..."
sleep 5

clear




echo "Installing Newznab+"
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

sleep 1
clear
cp /etc/php5/apache2/php.ini /etc/php5/apache2/php.bak
cp /etc/php5/cli/php.ini /etc/php5/cli/php.bak

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


phpmyadmin()
{
echo "Do you want to install Phpmyadmin?"
echo "y=YES n=NO"
}
while [ 1 ]
do
phpmyadmin
read CHOICE
case "$CHOICE" in
									"y")
									echo "Installing PhpMyadmin..."
									echo "Make sure you put a checkmark in the apache2 checkbox before hitting enter"
									sleep 5
									apt-get install -y -q=3 phpmyadmin
									echo "PhpMyadmin is installed..."
									sleep 3
									clear
									break
;;			
					"n")
					clear
					echo "Skipping PhpMyadmin install"
					break
;;			

		esac

done



clear
echo -n -e "Do you want to install Jonnyboy's tmux scripts?\n   (y or no.)\n"
read choice
 
if [ "$choice"=="y" -o "$choice"=="Y" ]
then
cd /var/www/newznab/misc/update_scripts/nix_scripts/
git clone https://github.com/jonnyboy/newznab-tmux.git tmux
cd tmux
cp config.sh defaults.sh
fi

clear
echo "Installing apc chaching "
apt-get install -y -q=3 php-apc
cp /usr/share/doc/php-apc/apc.php /var/www/newznab/www/admin/apc.php
clear
echo "Apc caching is now installed"
echo "Server restart is required to activate APC"
sleep 4


clear
echo "-----------------------------------------------"
echo "Make sure to edit the defaults.sh to your likeing if you choose to run Jonny's script then go into the scripts folder and run ./svn_update.sh"
echo "\033[1;31mDO NOT SKIP THAT STEP YOU HAVE BEEN WARNED!!!\033[1;37m"
sleep 10
clear





echo "Install Complete...."
echo "Go to http://localhost/install to finish NN+ install."
echo "For questions and problems log on to #newznab or #newznab-tmux on Synirc and look for zombu2"
echo "Good Luck."
exit 100




