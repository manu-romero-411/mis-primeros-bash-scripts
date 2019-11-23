#!/bin/bash
CARPETA=$(pwd)
if [[ $USER != root ]]; then
	echo "Recuerda ejecutar el script como root"
	exit 1
else
function parte1(){
	apt-get install -y --purge xserver-xorg xserver-xorg-core xinit xorg xserver-xorg-input-all
	apt-get install -y parole
	apt-get autoremove --purge -y blueman bluez avahi-daemon software-center app-install-data gimp xfce4-taskmanager abiword gnumeric gmusicbrowser xfburn
	apt-get autoremove --purge -y
	add-apt-repository -y ppa:xubuntu-dev/xfce-4.12 
	add-apt-repository -y ppa:noobslab/apps
	add-apt-repository -y ppa:noobslab/icons
	add-apt-repository -y ppa:noobslab/themes
	add-apt-repository -y ppa:kalgasnik/lightdm-gtk-greeter-settings-daily-xubuntu
	sudo add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free'
	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
	#add-apt-repository -y ppa:mc3man/trusty-media
	#add-apt-repository -y ppa:libreoffice/libreoffice-5-1
	add-apt-repository -y ppa:linrunner/tlp
	apt-get update
	apt-get dist-upgrade -y
	echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
	apt-get install -y xubuntu-restricted-extras xubuntu-restricted-addons
	apt-get install -y lm-sensors lxtask sox gnome-session-canberra geogebra synaptic gdebi visualboyadvance-gtk dosbox zsnes libreoffice libreoffice-l10n-es myspell-es vlc gnome-disk-utility gparted unetbootin wine1.6 playonlinux sysvinit-backlight tlp tlp-rdw cpufrequtils lightdm-gtk-greeter-settings fonts-noto fonts-roboto fonts-crosextra-carlito fonts-crosextra-caladea wmctrl xdotool opera-stable
	apt-get install -y cheese kolourpaint4 kde-l10n-es --no-install-recommends
	}
function parte2(){
	dpkg -i $CARPETA/DEBS/kega-fusion_3.63-2_i386.deb
	dpkg -i $CARPETA/DEBS/lightdm-gtk-greeter_1.9.0-0ubuntu1_i386.deb
	cp $CARPETA/EJECUTABLES/xfce4-appearance-settings /usr/bin
	cp -r $CARPETA/TEMAS/SONIDOS/winxp /usr/share/sounds/winxp
	cp $CARPETA/EJECUTABLES/logout-sound /etc/init.d
	echo display-stopped-script=/etc/init.d/logout-sound >> /etc/lightdm/lightdm.conf
	echo vm.swappiness=10 >> /etc/sysctl.conf
	echo vm.vfs_cache_pressure=50 >> /etc/sysctl.conf
	if [ $(uname -m) = "x86_64" ]; then
		cp $CARPETA/EJECUTABLES/xbcg64 /usr/bin
	else
		cp $CARPETA/EJECUTABLES/xbcg32 /usr/bin
	fi
	su -l usuario -c "xfconf-query -c xsettings -p /Net/SoundThemeName -s winxp;\
			cp $CARPETA/ARCHIVOS-ACELERAR-LOGIN/.Xdefaults ~;\
			cp $CARPETA/ARCHIVOS-ACELERAR-LOGIN/.xinputrc ~;\
			cp $CARPETA/ARCHIVOS-ACELERAR-LOGIN/.xsessionrc ~;\
			cp $CARPETA/ARCHIVOS-CONFIGURACION/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/.;\
			cp $CARPETA/ARCHIVOS-CONFIGURACION/Script-de-arranque.desktop ~/.config/autostart;\
			cp $CARPETA/PLANTILLAS/* ~/Plantillas
			cp $CARPETA/ARCHIVOS-ESCRITORIO/* ~/.local/share/applications
			cp $CARPETA/ARCHIVOS-ESCRITORIO/Equipo.desktop"
	echo "El sistema operativo ha sido autoconfigurado. Queda solucionar algunos errores (si los ha habido), y lo del greeter. Seria interesante instalar Palemoon."
	sleep 1
	echo " "
	echo "El sistema se reiniciará,"
	sleep 5
	init 6
	}
	if [ -z $1 ]; then
		parte1; parte2
	elif [ $1 = parte1 ]; then
		parte1
	elif [ $1 = parte2 ]; then
		parte2
	else
		exit 1
	fi
fi
exit 0