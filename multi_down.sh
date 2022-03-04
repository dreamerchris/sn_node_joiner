#!/bin/bash
nohup safe node killall >/dev/null 2>&1
NODE_NUM=20
for CURRENT_NODE in  $(seq $NODE_NUM)
do
sudo systemctl stop sn_node${CURRENT_NODE}.service
sudo systemctl disable sn_node${CURRENT_NODE}.service
done
sudo systemctl daemon-reload
sudo systemctl reset-failed
