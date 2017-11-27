#!/usr/bin/env bash
#
#
#
#
#
#
#
#
#variables
current1=`pwd`
cd ..
current2=`pwd`
cd $current1
echo "$current1" >> path.p
echo "$current2" >> path.p
miss="Puedes descargalo desde (https://github.com/oscardeveloper/maguz-rom-tools)"

comp () {

  if [[ ! -d tools ]]; then
    echo
    echo "ERROR- falta el Directorio (tools)"
    echo $miss
  fi
  if [[ ! -f Maguz-RomTool.desktop ]]; then
    echo "ERROR- falta el archivo (Maguz-RomTool.desktop)"
    echo $miss
  fi
  if [[ ! -f mz.png ]]; then
    echo "ERROR- falta el archivo (mz.png)"
    echo $miss
  fi
  if [[ ! -f romtool.sh ]]; then
    echo "ERROR- falta el archivo (romtool.sh)"
    echo $miss
  fi
  if [[ ! -f start.sh ]]; then
    echo "ERROR- falta el archivo (start.sh)"
    echo $miss
  fi
  if [[ ! -f st ]]; then
    echo "ERROR- falta el archivo (st)"
    echo $miss
  fi
}

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
AccesoDir () {
  #crear acceso directo
  echo "  ________________________________________________________________________ "
  echo " |                 Ingresa la ruta para el Acceso directo.                |"
  echo " |                        Ejemplo: /home/USER/Desktop                     |"
  echo " |________________________________________________________________________|"
  echo
    printf "Ruta:"
    read INPUT
    echo
    echo "---Crear Acceso Directo en: "$INPUT""
      cd $INPUT
  if [[ ! -f Maguz-RomTool.desktop ]] ; then
      cd $current1
        sed -i 's.xxx1.'${current1}'.g' Maguz-RomTool.desktop
        sed -i 's.xxx2.'${current1}'.g' Maguz-RomTool.desktop
        cp -f st start.sh
    echo -e "cd ${current1} \n ./romtool.sh \n Terminal=true \n" >> start.sh
        cp -f Maguz-RomTool.desktop ~/.local/share/applications/
        sudo chmod +x Maguz-RomTool.desktop start.sh
        cp -f Maguz-RomTool.desktop $INPUT/
        sed -i 's.'${current1}'.xxx1.g' Maguz-RomTool.desktop
        sed -i 's.'${current1}'.xxx2.g' Maguz-RomTool.desktop
    echo "---Done--"
        tput setaf 6
    echo "---((Acceso directo creado en:$INPUT))--"
        tput setaf 7
    echo "---Move up to see details"
  else
    echo
    echo -e " \e[1;31mERROR.\e[0m"
  tput setaf 3
    echo " ---El Acceso Directo ya existe en:$INPUT."
      tput setaf 7
  fi
}
#
selp () {
cd /usr/bin
    PY=`ls -l python | cut -d ">" -f 2`
    tput setaf 3
    echo "---"$PY" encontrado---"
    tput setaf 7
if [[ $PY = *python3 ]]; then
      py3
    elif [[  $PY = *python2 ]]; then
      py2
fi
cd $current1
    echo "$PY" > py.ver

}
#
py3 () {
cd /usr/bin
echo
tput setaf 6
  echo "---Cambiar a python2 (y/N)?"
  printf "%s" "-Enter selection: "
  tput setaf 7
  read INPUT
if [[ $INPUT = y ]]; then
  sudo ln -sf python2 python
  clear
  tput setaf 6
  echo "---Done python2 Activado"
  tput setaf 7
  else
    echo "---elegiste no"
  fi
cd $current1
}
#
py2 () {
cd /usr/bin
echo
tput setaf 6
echo "---Cambiar a python3 (y/N)?"
printf "%s" "-Enter selection: "
tput setaf 7
    read INPUT
    if [[ $INPUT = y ]]; then
    sudo ln -sf python3 python
    clear
    tput setaf 6
    echo "---Done python3 Activado"
      tput setaf 7
    else
      echo "---elegiste no cambiar"
    fi
cd $current1
}

virt () {

  if [[ -d virtualenv ]]; then
    #statements
    export LC_ALL="C"
    source "$current2/virtualenv/bin/activate";
    echo "---Done---"
    echo
    tput setaf 6
    echo " --Virtualenv2 Activado--"
    tput setaf 7
  else
    virtualenv
  fi
}
virtualenv () {
  if [[ "$(python --version | awk '{print $2}' | awk -F '.' '{print $1}')" -ne 2 ]];
  then
  if [[ "$(command -v 'virtualenv2')" ]]; then
          virtualenv2 "$current2/virtualenv";
          source "$current2/virtualenv/bin/activate";
          clear
    echo "  Done"
  tput setaf 6
    echo "---Virtualenv2 Activado--"
  tput setaf 7
    echo "---Move up to see details"
      else
  tput setaf 3
    echo "---Please install 'virtualenv2', or make 'python' point to python2";
  tput setaf 7
          exit 1;
  fi
  fi
}
#s
syncR () {
    repo sync --force-broken --force-sync --detach --no-clone-bundle
    clear
    echo
    tput setaf 6
    echo "---Repositorio Sincronizado--"
    tput setaf 7
    echo "---Move up to see details"
}
#
jackVM () {
  re='^[0-9]+$'
  while :

  do
  tput setaf 3
	   echo "---Cuanta memoria quieres asignar?:--"
  tput setaf 6
	read numero
  tput setaf 7
	if [[ $numero =~ $re ]];then
#    break
 tput setaf 6
      echo "---Escogiste "$numero"gb for jack compiler--"
 tput setaf 7
 cd $current2
  export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx"$numero"g"
    ./prebuilts/sdk/tools/jack-admin kill-server
    ./prebuilts/sdk/tools/jack-admin start-server
 clear
      echo
      echo "---Done"
 tput setaf 6
      echo "---jack Virtual memory set to "$numero"gb--"
 tput setaf 7
      echo "---Move up to see details"
    break
  else
    tput setaf 1
		  echo "---Please use only numbers"
    tput setaf 7
	fi
done
cd $current1
}
#
clearOut () {
#  make clean
cd $current2
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
    tput setaf 6
		  echo "---El directorio OUT ya esta limpio, no es necesario limpiarlo--"
    tput setaf 7
	fi
  fi
clear
      echo
  tput setaf 6
    echo "---Done---"
  tput setaf 7
      echo "---Move up to see details"
  cd  $current1
}
#
model () {
cd  $current2
  if [ ! $2 ];
    then
      tput setaf 3
      echo "---What is your device code name?--"
    tput setaf 6
      read device
      tput setaf 7
  else
      device=$2
  fi
    source build/envsetup.sh;
  clear
      echo
  tput setaf 6
      echo "---Done---"
      echo "---Elegiste el Modelo $device--"
  tput setaf 7
      echo "---Move up to see details---"
cd  $current1
}
#
compile () {
cd  $current2
  logfile="$device-$(date +%Y%m%d).log"
  lunch mk_$device-userdebug && time mka bacon 2>&1 | tee $logfile
  if [ $? -eq 0 ]; then
      printf "---Build Suceeded---";
  else
tput setaf 1
      printf "---Build failed, check the log at ${logfile}\n---";
tput setaf 7
      exit 1;
  fi
      echo -e "---Stopping jack server---";
  ./prebuilts/sdk/tools/jack-admin stop-server;
  clear
      echo
      echo "---Done---"
      echo "---Move up to see details---"
  cd  $current1
}
#
openOut () {
  cd $current2
  if [[ -d out ]]; then
      echo
    xdg-open out/target/product/$device
    clear
      echo
  fi
cd $current1
}
#
checkdir () {
  if [[ -d  output ]]; then
      echo "---output folder found.---"
      echo
  else
      echo "---output folder not found.---"
      echo "---Creando directorio...---"
      echo
	mkdir -p output
	     echo "---Directorio ((output)) creado---"
	     echo
  fi
localMode="true" #si se culple el bloque anterior se Establece localMode a TRUE
}
#
desVirt () {
  if [[ -d "$current2/virtualenv" ]]; then
#      echo -e "   virtualenv detected, deactivating!";
        deactivate;
        rm -rf "$current2/virtualenv";
        echo
        tput setaf 6
        echo "---Virtualenv2 Desactivado---"
          tput setaf 7
  else
      echo
      tput setaf 6
      echo "---Virtualenv2 ya esta Desactivado---"
  fi
      tput setaf 7
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
	echo -e "  \E[34;47m.---------------MENU------------------------------------EXTRA------------."; tput sgr0
  tput setaf 6
  echo "--|___|                               |0 |Cambiar version de python 2/3    |--"
  echo "--| 0 | Crear Acceso Directo          |                                    |--"
  echo "--| 1)| Activar Python2 virtualen.    |->(Arch Linux).                     |--"
	echo "--| 2)| Syncronizar Repositorio.      |->(Sync repo)                       |--"
	echo "--| 3)| Establece JACK_SERVER_VM.     |->(Set JACK_SERVER virtual memory)  |--"
	echo "--| 4)| Limpiar directorio OUT.       |->(Clear OUT directory)             |--"
	echo "--| 5)| Modelo de terminal a Compilar.|->(Device code name)                |--"
	echo "--| 6)| Compilar.                     |->(Compile)                         |--"
  echo "--| 7)| Desactivar Python2 virtualen. |->(Arch Linux).                     |--"
  echo "--| 8)| Abrir OUT directorio.         |->(Open OUT directory)              |--"
  echo "--| 9)| Chequear archivos.            |->(                  )              |--"
	echo "--|00)| Exit MaguzTool.               |                                    |--"
  echo -e "  \E[34;47m'------------------------------------------------------------------------'"; tput sgr0
  #echo "------------------------------------------------------------------------------"
  tput setaf 7
  echo
  tput setaf 6
	printf "%s" "---Enter selection: "
  tput setaf 3
	read ANSWER
  tput setaf 7
	reset
	case "$ANSWER" in
     0000) selp ;;
     0) AccesoDir ;;
     1) virt ;;
		 2) syncR ;;
		 3) jackVM ;;
		 4) clearOut ;;
		 5) model ;;
		 6) compile ;;
     7) desVirt ;;
     8) openOut ;;
     9) comp ;;
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
printf '\033[8;30;80t'
#PATH="$PATH:$PWD/other"
reset
# clear
reset
while [ "1" = "1" ] ;
do
	restart
done

exit 0
