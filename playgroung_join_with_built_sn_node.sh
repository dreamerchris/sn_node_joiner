#!/bin/bash
SAFENET="playground"
CONFIG_URL="https://safe-testnet-tool.s3.eu-west-2.amazonaws.com/public-node_connection_info.config"
USER=$(whoami)

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

safe cat safe://hyfenryyban3rya95df67upomjse4wjaumy1awb94hs8oyfezjnpwykunu6zo > sn_node.zip

unzip sn_node.zip -d .

mkdir $HOME/.safe/node/

sudo cp sn_node $HOME/.safe/node/sn_node

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))

CURRENT_NODE=1
SAFE_PORT=12001
CURRENT_ROOT_DIR=$HOME/.safe/node/local_node$CURRENT_NODE/
CURRENT_LOG_DIR=$HOME/.safe/node/local_node$CURRENT_NODE/
rm -rf $CURRENT_ROOT_DIR
mkdir $CURRENT_ROOT_DIR

echo -n "#!/bin/bash
RUST_LOG=safe_network=trace,qp2p=info \
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


echo ""
echo "End of multi sn node joiner script. Starting vdash!"
echo ""

$HOME/.cargo/bin/vdash $HOME/.safe/node/local_node1/sn_node.log
