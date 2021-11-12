#!/bin/bash
# This shell script is just for reference to ensure it works outside of the cloud-init process and so it can be formatted into the cloudinit.yml
sudo apt update ; sudo apt install -y build-essential net-tools curl git software-properties-common irssi irssi-scripts screen openssh-server oidentd jq
sudo systemctl enable --now oidentd


# Retrieve irssi CONFIG from Github Gist: 
curl https://api.github.com/gists/e04c78bdb1d42608356f6efe309bd7d1 |jq ".files.config.content | fromjson" |& tee config

# create irc unprivileged user 
sudo -i
bash /home/ubuntu/users.sh ${var.irc_username} ${var.gh_username}
