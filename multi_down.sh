#!/bin/bash
safe node killall
NODE_NUM=10
for CURRENT_NODE in {1..$NODE_NUM}
do
sudo systemctl stop sn_node$CURRENT_NODE.service
done