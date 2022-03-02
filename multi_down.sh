#!/bin/bash
safe node killall
NODE_NUM=20
for CURRENT_NODE in  $(seq $NODE_NUM)
do
sudo systemctl stop sn_node${CURRENT_NODE}.service
done
