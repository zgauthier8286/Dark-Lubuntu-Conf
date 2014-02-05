#!/bin/bash
# Mon script de "post installation" de GNU/Linux Lubuntu
#
# Khancyr
# GPL
#
# Syntaxe: # chmod +x postinstall.sh
# 		sudo ./postinstall.sh
#
#
#=============================================================================
# Liste des applications à installer: A adapter a vos besoins
#
LISTE=""
# Developpement
LISTE=$LISTE" build-essential git gitk gedit "
# Multimedia
#LISTE=$LISTE" "
# Network
#LISTE=$LISTE" "
# Systeme
LISTE=$LISTE" lm-sensors hardinfo hddtemp conky-all openbox-themes  grub-customizer ubuntu-tweak"
# Web
#LISTE=$LISTE"akawoken-icon-theme  "

REMOVE_LISTE="xpad leafpad pidgin pidgin-data pidgin-microblog sylpheed* transmission* audacious* xfburn xscreensaver ace-of-penguins"

#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo "Le script doit être lancé en root: # sudo $0" 1>&2
  exit 1
fi

# Ajout des depots
#-----------------

LUBUNTUVERSION=`lsb_release -cs`
echo -e "\e[44m \e[1;31m Ajout des depots pour Ubuntu $LUBUNTUVERSION \e[0m\n"

echo -e "\e[44m \e[1;31m Backup des sources originelles \e[0m\n"
cp /etc/apt/sources.list /etc/apt/sources.list.backup

#GRUB-CUSTOMIZER
echo -e "\e[44m \e[1;31m Ajout de Grub-customizer \e[0m\n"
if ls /etc/apt/sources.list.d/ |grep "danielrichter2007-grub-customizer" >/dev/null
then echo -e "\e[44m \e[1;31m Déja Ajouté !\e[0m\n"
else add-apt-repository ppa:danielrichter2007/grub-customizer
fi


#Ubuntu-Tweak
echo -e "\e[44m \e[1;31m Ajout d'Ubuntu-Tweak \e[0m\n"
if ls /etc/apt/sources.list.d/ |grep "tualatrix-ppa" >/dev/null
then echo -e "\e[44m \e[1;31m Déja Ajouté !\e[0m\n"
else add-apt-repository ppa:tualatrix/ppa
fi


# Mise a jour 
#------------

echo -e "\e[44m \e[1;31m Mise a jour de la liste des depots \e[0m\n"
apt-get -y update

echo -e "\e[44m \e[1;31m Mise a jour du systeme \e[0m\n"
apt-get -y upgrade


# Suppression des packet inutiles
#------------

apt-get -y purge $REMOVE_LISTE

# Mise a jour 
#------------

echo -e "\e[44m \e[1;31m Mise a jour de la liste des depots \e[0m\n"
apt-get -y update

echo -e "\e[44m \e[1;31m Mise a jour du systeme \e[0m\n"
apt-get -y upgrade

# Suppression des packet inutiles
#------------

apt-get -y autoremove --purge
apt-get -y autoclean --purge

# Mise a jour 
#------------

echo -e "\e[44m \e[1;31m Mise a jour de la liste des depots \e[0m\n"
apt-get -y update

echo -e "\e[44m \e[1;31m Mise a jour du systeme \e[0m\n"
apt-get -y upgrade

# Installations additionnelles
#-----------------------------

echo -e "\e[44m \e[1;31m Installation des logiciels suivants: $LISTE \e[0m\n"

apt-get -y install $LISTE

echo "========================================================================"
echo
echo -e "Liste des logiciels installés: \e[31m $LISTE \e[0m\n"
echo
echo "========================================================================"
echo
echo "Le script doit relancer votre session pour finaliser l'installation."
echo "Assurez-vous d’avoir fermé tous vos travaux en cours avant de continuer."
echo "Appuyer sur ENTER pour relancer votre session (ou CTRL-C pour annuler)"
read ANSWER
service lightdm restart

# Fin du script
#---------------
