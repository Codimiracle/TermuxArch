#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# If you are encountering issues with the system-image.tar.gz file regarding download time, repository website connection and/or md5 checksum error, edit this script and change $mirror to your desired geographic location in knownconfigurations.sh.  Before editing this file, ensure termux-wake-lock is running during script operation and that you have a stable Internet connection. 
################################################################################

printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n 🕛 \033[36;1m< 🕛 \033[1;34mThis setup script will attempt to set Arch Linux up in your Termux environment.  When successfully completed, you will be enjoying the bash prompt in Arch Linux in Termux on your smartphone or tablet.  If you do not see 🕐 one o'clock below, check your Internet connection and run this script again.  "
if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
	printf "Termux package requirements for Arch Linux: \033[36;1mOK  \n\n"
else
	printf "\n\n\033[36;1m"
	apt-get -qq update && apt-get -qq upgrade -y
	apt-get -qq install bsdtar proot wget --yes 
	printf "\n 🕧 < 🕛 \033[1;34mTermux package requirements for Arch Linux: \033[36;1mOK  \n\n"
fi
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.md5 
printf "\n"
if md5sum -c setupTermuxArch.md5 ; then
	printf "\n 🕐 \033[36;1m< 🕛 \033[1;34mInstallation script download: \033[36;1mOK  \n\n\033[36;1m"
	bsdtar -xf setupTermuxArch.tar.gz
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
else
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
	printmd5syschkerror
fi
if md5sum -c termuxarchchecksum.md5 ; then
	. archsystemconfigs.sh
	. knownconfigurations.sh
	. necessaryfunctions.sh
	. printoutstatements.sh
	rm archsystemconfigs.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm termuxarchchecksum.md5
	printf "\n\033[36;1m 🕜 < 🕛 \033[1;34mInstallation script integrity: \033[36;1mOK  \n\033[0m"
else
	rm archsystemconfigs.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm termuxarchchecksum.md5
	printmd5syschkerror
fi

printmd5syschkerror ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update your copy of setupTermuxArch.sh.  If you have updated it, this kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended, especially if you are using a new copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on your system.  There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way this means,  \"Try again, initialization was not successful.\"  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

# Main Block
callsystem 
$HOME/arch/root/bin/setupbin.sh ||: 
termux-wake-unlock
rm $HOME/arch/root/bin/setupbin.sh
printfooter
$HOME/arch/$bin ||: 
printtail
exit 

