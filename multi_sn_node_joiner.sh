#!/bin/bash
SAFENET="dreamnet"
CONFIG_URL="https://nx23255.your-storageshare.de/s/F7e2QaDLNC2z94z/download/dreamnet.config"
NODE_NUM=10
USER=$(whoamin)


curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/main/resources/scripts/install.sh | bash

hash -r
safe node install

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))

for CURRENT_NODE in {1..$NODE_NUM}
do
SAFE_PORT=12000 + $CURRENT_NODE

CURRENT_ROOT_DIR=~/.safe/node/local_node$CURRENT_NODE/
CURRENT_LOG_DIR=~/.safe/node/local_node$CURRENT_NODE/

echo -n "#!/bin/bash
RUST_LOG=safe_network=trace,qp2p=info \
	~/.safe/node/sn_node \
	--max-capacity $VAULT_SIZE \
	--local-addr "$LOCAL_IP":$SAFE_PORT \
	--public-addr "$PUBLIC_IP":$SAFE_PORT \
	--skip-auto-port-forwarding \
	--root_dir "$CURRENT_ROOT_DIR" \
	--log-dir "$CURRENT_LOG_DIR" & disown"\
| tee ~/.safe/node/start-node$CURRENT_NODE.sh

chmod u+x ~/.safe/node/start-node$CURRENT_NODE.sh
	
echo -n "[Unit]
Description=Safe Local Node $CURRENT_NODE
[Service]
User=$USER
ExecStart=/home/$USER/.safe/node/start-node$CURRENT_NODE.sh
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target"\
|sudo tee /etc/systemd/system/sn_node$CURRENT_NODE.service

sudo systemctl start sn_node$CURRENT_NODE.service

done

echo "end of multi sn node joiner script"