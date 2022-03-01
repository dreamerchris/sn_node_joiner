#!/bin/bash
NEWUSER=node15
sudo useradd -m -p yXl5LjtaUeOcM -s /bin/bash $NEWUSER
sudo usermod -a -G sudo $NEWUSER
sudo -i -u $NEWUSER bash << EOF
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/main/resources/scripts/install.sh | bash;
EOF
if test -f /tmp/sn_node*; then sudo chown -R $NEWUSER /tmp/sn_node*; fi
su $NEWUSER -c 'safe node install'
