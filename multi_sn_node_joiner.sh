#!/bin/bash
SAFENET="dreamnet"
CONFIG_URL="https://nx23255.your-storageshare.de/s/F7e2QaDLNC2z94z/download/dreamnet.config"
NODE_NUM=7
USER=$(whoami)

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))

for CURRENT_NODE in  $(seq $NODE_NUM)
do
SAFE_PORT=$((12000+$CURRENT_NODE))
CURRENT_ROOT_DIR=$HOME/.safe/node/local_node$CURRENT_NODE/
CURRENT_LOG_DIR=$HOME/.safe/node/local_node$CURRENT_NODE/
mkdir $CURRENT_ROOT_DIR

echo -n "#!/bin/bash
RUST_LOG=sn_node=trace,qp2p=info \
        $HOME/.safe/node/sn_node \
        --local-addr '$LOCAL_IP':$SAFE_PORT \
        --public-addr '$PUBLIC_IP':$SAFE_PORT \
        --skip-auto-port-forwarding \
        --root-dir '$CURRENT_ROOT_DIR' \
        --log-dir '$CURRENT_LOG_DIR' & disown" \
| tee $HOME/.safe/node/start-node$CURRENT_NODE.sh

chmod u+x $HOME/.safe/node/start-node$CURRENT_NODE.sh

echo -n "[Unit]
Description=Safe Local Node $CURRENT_NODE
[Service]
User=$USER
ExecStart=$HOME/.safe/node/start-node$CURRENT_NODE.sh
Type=forking
[Install]
WantedBy=multi-user.target"\
| sudo tee /etc/systemd/system/sn_node$CURRENT_NODE.service

sudo systemctl start sn_node$CURRENT_NODE.service

done
echo ""
echo "End of multi sn node joiner script. Starting vdash!"
echo ""
$HOME/.cargo/bin/vdash $HOME/.safe/node/local_node*/sn_node.log
