#!/bin/bash

USERNAME="$1"
GITHUB="$2"
PASSWORD="*"

display_usage() {
        echo "This script must be run as root."
        echo -e "\nUsage: $0 Username GitHub \n"
        }

# if more/less than two arguments supplied, display usage
if [  $# -ne 2 ]; then
        display_usage
        exit 1
fi

# if not root, exit
if [ $(whoami) != 'root' ]; then
        echo "Must be root to run $0"
        exit 1;
fi

if id -u "$USERNAME" >/dev/null 2>&1; then
    userdel -r -f $USERNAME
    useradd -m -p $PASSWORD -s /bin/bash $USERNAME
    echo $USERNAME:$PASSWORD | chpasswd
    mkdir /home/$USERNAME/.ssh && chown $USERNAME:$USERNAME /home/$USERNAME/.ssh
    sudo -i -u $USERNAME bash << EOF
        ssh-import-id-gh $GITHUB
EOF

else
    useradd -m -p $PASSWORD -s /bin/bash $USERNAME
    echo $USERNAME:$PASSWORD | chpasswd
    mkdir /home/$USERNAME/.ssh && chown $USERNAME:$USERNAME /home/$USERNAME/.ssh
    sudo -i -u $USERNAME bash << EOF
        ssh-import-id-gh $GITHUB
EOF
fi
