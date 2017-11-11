#!/bin/bash

# Terminal Dimensions
printf '\033[8;48;80t'

# Make sure you're in repo source dir
	[ -d ".repo" ] || exit 1
# Fixes the fact that android needs python2, arch has 3 by default, and a newer flex version.
	export LC_ALL="C"
		virtualenv2 venv
	source venv/bin/activate

# Specify colors utilized in the terminal
normal='tput sgr0'              # White
red='tput setaf 1'              # Red
green='tput setaf 2'            # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'             # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'             # Cyan
white='tput setaf 7'            # White
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold Red
bldgrn=${txtbld}$(tput setaf 2) # Bold Green
bldblu=${txtbld}$(tput setaf 4) # Bold Blue
#bldylw=$(txtbld)$(tput setaf 3) # Bold Yellow
bldvlt=${txtbld}$(tput setaf 5) # Bold Violet
bldcya=${txtbld}$(tput setaf 6) # Bold Cyan
bldwht=${txtbld}$(tput setaf 7) # Bold White

clear
        echo -e "${bldred}          ___          ___     "
        echo -e "${bldred}         /  /\        /  /\    "
        echo -e "${bldred}        /  /::\      /  /::\   "
        echo -e "${bldred}       /  /:/\:\    /  /:/\:\  "
        echo -e "${bldred}      /  /:/~/:/   /  /:/~/:/  "
        echo -e "${bldred}     /__/:/ /:/___/__/:/ /:/___"
        echo -e "${bldred}     \  \:\/:::::/\  \:\/:::::/"
        echo -e "${bldred}      \  \::/~~~~  \  \::/~~~~ "
        echo -e "${bldred}       \  \:\       \  \:\     "
        echo -e "${bldred}        \  \:\       \  \:\    "
        echo -e "${bldred}         \__\/        \__\/    "
        echo -e "${bldred}                               "
        echo -e "${bldred}       RESURRECTION REMIX OS   "
        echo -e "${bldred}                               "
        echo -e "${bldred}       M A R S H M A L L O W   "
        echo -e "${bldred}                               "
        echo -e "${bldcya}           Building RR!        "
tput setaf 3
    sleep 1
    echo
    echo Setting up Build Environment...
    echo
	sleep 2
	#	make clean
	echo
tput setaf 6
	if [ ! $1 ];
	then
	echo "   Cuanta VM quieres asignar a jack server?"
	echo
	echo "   sets the amount of (VM)virtual memory for jack server"
	echo "   depending on the amount of ram memory of your pc"
	echo "   (use the numeric keypad to choose the number)"
tput setaf 4
	read memoria
	else
	memoria=$1
	fi
tput setaf 6
	echo -e "  You have chosen ${memoria}gb for jack compiler"
	echo "JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx${memoria}g""
tput setaf 7
	export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx${memoria}g"
	./prebuilts/sdk/tools/jack-admin kill-server
	./prebuilts/sdk/tools/jack-admin start-server
tput setaf 1
	echo "  Do you want Sync repo (Y/n)? "
	read INPUT
	if [[ x$INPUT ==  "xY" || x$INPUT ==  "xy" || x$INPUT ==  "x" ]] ; then
	echo "  elegiste syncronizar el repo"
		repo sync --force-broken --force-sync --detach --no-clone-bundle
		else
	echo "  elegiste no syncronizar el repo"
	fi
	clear
	echo
tput setaf 2
	source build/envsetup.sh
tput setaf 3
	echo
	if [ ! $2 ];
	then
	echo What is your device code name?
tput setaf 4
	read device
	else
	device=$2
	fi
tput setaf 3
	echo -e "You have chosen to build XXXXXX OS for ${bldred} ${device}"
	echo
	echo -e "${bldvlt}Building XXXXXX OS now!"
	echo
	sleep 2
tput setaf 2
	logfile="$device-$(date +%Y%m%d).log"
	lunch mk_$device-userdebug && time mka bacon 2>&1 | tee $logfile
	if [ $? -eq 0 ]; then
	printf "Build Suceeded";
	else
	printf "Build failed, check the log at ${logfile}\n";
	exit 1;
	fi

echo -e "Stopping jack server";
	./prebuilts/sdk/tools/jack-admin stop-server;
