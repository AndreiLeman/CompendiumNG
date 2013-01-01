#!/bin/bash 
#version 1.1.2013

HOME_PATH=~/Compendium
CURRENT_BRANCH=M1

function pause() {
   read -p "$*"
}

echo "This script is helping continuous testing of Compendium NG under Linux. It is *NOT* meant to be used in productive settings!"
echo " "

if [ -x $HOME_PATH ]; then
	echo "*** WARNING! *** Compendium install directory [$HOME_PATH] already exists If you continue this will delete your current installation of Compendium and all of its content!";
	echo " ";
	echo "if you want to proceed press enter otherwise Ctrl-C ";
	pause 'Press [Enter] key to continue...';
	echo " ";
	echo "removing your current installation";
	rm -R ~/Compendium;
fi

echo "1. getting code updates from current development branch ($CURRENT_BRANCH)"
git pull origin $CURRENT_BRANCH

echo "2. preparing the code for installation"
mvn package

# Everything from below here is a copy from the install script (Install-linux.sh)

DIST=" \
Compendium.bat \
Compendium.dtd \
Compendium.sh \
License.html  \
Movies \
ReadMe.html \
Skins \
System \
Templates \
compendium.icns \
docs \
vpproject \
target/$JAR"


mkdir $HOME_PATH

for I in $DIST;
do
	echo "copying $I"
	cp -pr $I $HOME_PATH 
done

ln -s $HOME_PATH/$JAR $HOME_PATH/compendium.jar 

chmod u+x $HOME_PATH/Compendium.sh

# echo "add ~/Compendium to your \$PATH"
# echo "and run it Compendium.sh"

echo "Update and installation of CompendiumNG from the latest development branch complete."

