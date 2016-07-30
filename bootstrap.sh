#!/usr/bin/env bash

projectDir="$1"
source "${projectDir}/.env"

if [ $DFWS_DEV = "1" ]; then
    sendfileStatus="off"
    nginxAction="stop"
else
    sendfileStatus="on"
    nginxAction="restart"
fi

sudo apt-get -y install build-essential nginx git

sudo rm -f /etc/nginx/sites-enabled/default \
&& sudo tee /etc/nginx/sites-available/dotafanwars_static > /dev/null <<EOF
server {
  listen ${DFWS_PORT};
  root ${projectDir};
  index index.html;
  server_name ${DFWS_HOST};
  sendfile ${sendfileStatus};
  charset utf-8;
  location / {
    try_files \$uri \$uri/ /index.html;
  }
}
EOF
sudo ln -sf /etc/nginx/sites-available/dotafanwars_static /etc/nginx/sites-enabled/dotafanwars_static \
&& sudo service nginx ${nginxAction}
