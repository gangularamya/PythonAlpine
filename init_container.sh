#!/usr/bin/env bash

cat >/etc/motd <<EOL 

  _____                               

  /  _  \ __________ _________   ____  

 /  /_\  \\___   /  |  \_  __ \_/ __ \ 

/    |    \/    /|  |  /|  | \/\  ___/ 

\____|__  /_____ \____/ |__|    \___  >

        \/      \/                  \/ 

A P P   S E R V I C E   O N   L I N U X



Documentation: http://aka.ms/webapp-linux

NodeJS quickstart: https://aka.ms/node-qs



EOL

cat /etc/motd



mkdir "$PM2HOME"

chmod 777 "$PM2HOME"

ln -s /home/LogFiles "$PM2HOME"/logs



# Get environment variables to show up in SSH session

eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)



echo "$@" > /opt/startup/startupCommand

node /opt/startup/generateStartupCommand.js

STARTUPCOMMAND=$(cat /opt/startup/startupCommand)

echo "Running $STARTUPCOMMAND"

eval "exec $STARTUPCOMMAND" &



# Ensure this happens after /sbin/init

( sleep 5 ; /etc/init.d/sshd restart ) &



# Needs to start as PID 1 for openrc on alpine

exec -c /sbin/init 