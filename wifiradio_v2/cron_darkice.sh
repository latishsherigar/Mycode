#!/bin/bash
SERVICE="darkice"
while [ true ]; do

  if pgrep -x "$SERVICE" >/dev/null
  then
     echo "$SERVICE is running"
  else
     echo "$SERVICE stopped"
    /home/pi/darkice.sh &	
    # uncomment to start nginx if stopped
    # systemctl start nginx
    # mail  
  fi

  sleep 30

done
