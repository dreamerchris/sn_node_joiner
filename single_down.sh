#!/bin/bash
nohup safe node killall >/dev/null 2>&1

CURRENT_NODE=1

sudo systemctl stop sn_node${CURRENT_NODE}.service
sudo systemctl disable sn_node${CURRENT_NODE}.service

sudo systemctl daemon-reload
sudo systemctl reset-failed
