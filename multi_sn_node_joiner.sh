#!/bin/bash
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/main/resources/scripts/install.sh | bash
hash -r
if sudo chown -R $(whoami) /tmp/sn_node*|| echo "no worries about the previous error!";
then
safe node install && echo "node install success";
fi
