#!/usr/bin/env bash

#
#variables
current=`pwd`

#chmod -R 775 $sysDir
#chmod -R 775 tools

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


#xxxxxxx
fixPytom () {
  export LC_ALL="C"
		#virtualenv2 venv
	source venv/bin/activate
  echo "   Done"
  tput setaf 6
  echo "   python2 virtualenv activated"
  tput setaf 7
}

virt () {
  if [[ -d virtualenv ]]; then
    #statements
    source "$current/virtualenv/bin/activate";
    echo "  Done"
    echo "  Virtualenv2 activado"
  else
    virtualenv
  fi
}
virtualenv () {
  if [[ "$(python --version | awk '{print $2}' | awk -F '.' '{print $1}')" -ne 2 ]];
  then
      if [[ "$(command -v 'virtualenv2')" ]]; then
          virtualenv2 "$current/virtualenv";
          source "$current/virtualenv/bin/activate";
          clear
          echo "  Done"
          echo "  Virtualenv2 activado"
          echo "  Move up to see details"
      else
          echo "Please install 'virtualenv2', or make 'python' point to python2";
          exit 1;
      fi
  fi
}
#xxxxxxx
syncR () {
    repo sync --force-broken --force-sync --detach --no-clone-bundle
    clear
    echo
    echo "  Sync Done"
    echo "  Move up to see details"
}
#xxxxxxx
jackVM () {
  re='^[0-9]+$'
while :

do
  tput setaf 3
	echo "   Cuanta memoria quieres asignar?:"
  tput setaf 7
	read numero
	if [[ $numero =~ $re ]];then
#    break
 echo "   Escogiste "$numero"gb for jack compiler"
# echo "JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx"$numero"g""
  export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx"$numero"g"
 ./prebuilts/sdk/tools/jack-admin kill-server
 ./prebuilts/sdk/tools/jack-admin start-server
 clear
 echo
 echo "   Done"
 echo "   jack Virtual memory set to "$numero"gb"
 echo "   Move up to see details"
    break
  else
		echo "   Please use only numbers"
	fi
done
}

clearOut () {
#  make clean
if [[ -d out ]]; then
	#statements
	cd out
	can=`find . | wc -l`
	if [[ "$can" > "1" ]]; then
		#statements
    cd ..
    echo
    make clean
	else
    echo
		echo "   El directorio OUT esta limpio, no es necesario limpiarlo"
	fi
fi
clear
  echo
  echo "   Done"
    echo " Move up to see details"

}
model () {

if [ ! $2 ];
    then
    echo    What is your device code name?
      read device
else
      device=$2
fi
echo "   elegiste $device"
source build/envsetup.sh;
}

compile () {
  logfile="$device-$(date +%Y%m%d).log"
  lunch mk_$device-userdebug && time mka bacon 2>&1 | tee $logfile
  if [ $? -eq 0 ]; then
  printf "   Build Suceeded";
    else
tput setaf 1
  printf "   Build failed, check the log at ${logfile}\n";
tput setaf 7
  exit 1;
  fi
  echo -e "   Stopping jack server";
  ./prebuilts/sdk/tools/jack-admin stop-server;
  clear
  echo
  echo "   Done"
  echo "   Move up to see details"
}

openOut () {
  if [[ -d out ]]; then
  #statements
  echo
    xdg-open out/target/product/$device
    clear
  echo
fi
}
#xxxxxxx
checkdir () {
if [[ -d  output ]]; then
 echo "--output folder found."
 echo
   else
   echo "--output folder not found."
   echo "--Creando directorio..."
   echo
	mkdir -p output
	echo "-Directorio ((output)) creado"
	echo
fi
localMode="true" #si se culple el bloque anterior se Establece localMode a TRUE
}
#2
extr () {

  if [[ condition ]]; then
    #statements
    xxxxxxx
  fi
}

empaq () {

  if [[ condition ]]; then
    #statements
    xxxxxxx
  fi
}
#00)
quit () {
	exit 0
}

restart () {
	echo
	echo "###############################################################################"
	echo -e "######                   \e[1;36m      Maguz-Rom-Tools  \e[0m                         ######"
	echo -e "######        \e[1;31m By: Maguz1024. mail: Oskr.developer1024@gmail.com \e[0m        ######"
	echo "###############################################################################"
	echo
	echo -e "\E[34;47m----MENU:"; tput sgr0
	echo "  ____________________________________________________________________________ "
  echo "  0000 "
	echo " | 000                                                                        |"
  echo "-| 0)| Activate Python2 virtualen (Arch Linux).                               |"
	echo "-| 1)| Syncronizar Repositorio. (Sync repo)                                   |"
	echo "-| 2)| Establece JACK_SERVER_VM. (Set JACK_SERVER virtual memory)             |"
	echo "-| 3)| Limpiar directorio OUT. (Clear OUT directory)                          |"
	echo "-| 4)| Modelo de terminal a Compil. (Sevice code name)                        |"
	echo "-| 5)| Compilar.       (Compile)                                              |"
  echo "-| 6)| Abrir OUT directorio.    (Open OUT directory)                          |"
	echo "-|00)| Exit MaguzTool.         (Exit)                                         |"
	echo " '----------------------------------------------------------------------------'"
  echo "-------------------------------------------------------------------------------"
  echo
  tput setaf 6
	printf "%s" "  Enter selection: "
	read ANSWER
	reset
	case "$ANSWER" in
    0000) virt ;;
    000) virtualenv ;;
     0) fixPytom ;;
		 1) syncR ;;
		 2) jackVM ;;
		 3) clearOut ;;
		 4) model ;;
		 5) compile ;;
     6) openOut ;;
		"00"|"exit")   quit ;;
		 *)
      echo
			echo -e "\e[1;31m ERROR \e[0m unknown command: \e[1;31m '$ANSWER' \e[0m"
		;;
	esac
}

Start ----------------------------------------
echo "  Starting Maguz-Rom-Tools..."
# Terminal Dimensions
printf '\033[8;48;80t'
#PATH="$PATH:$PWD/other"
reset

# clear
reset
while [ "1" = "1" ] ;
do
	restart
done

exit 0
