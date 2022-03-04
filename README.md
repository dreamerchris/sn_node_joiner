I have an idea about having multiple nodes from one machine without podman or docker


how to use:

tested in debian 10/11 and manjaro


1. a debian `sudo apt-get install -y git` 

1. b manjaro `sudo pacman -S git`

and now either one liner:

2. a. 
use this one liner for dreamnet - with 20 nodes (needs ports open 12001-12020) also check if dreamnet is live at safenetforum.org or use b option

for debian: `git clone https://github.com/dreamerchris/multi_sn_node_joiner.git && cd multi_sn_node_joiner && sh dep_installer_debian.sh && sh multi_sn_node_joiner.sh && vdash ~/.safe/node/local_node*/sn_node.log`

for manjaro: `git clone https://github.com/dreamerchris/multi_sn_node_joiner.git && cd multi_sn_node_joiner && sh dep_installer_manjaro.sh && sh multi_sn_node_joiner.sh && vdash ~/.safe/node/local_node*/sn_node.log`

what it does is:

- adds dreamnet with network.config

- switches to dreamnet

- launches 20 nodes

- the script runs vdash to see the info of your nodes with gui! ( use left/right arrows to switch node and q for exit)

and if you want to restart the nodes:

`sh multi_down.sh && sh multi_sn_node_joiner.sh`

or manually

2. b. 

- `git clone https://github.com/dreamerchris/multi_sn_node_joiner.git`

- then `cd multi_sn_node_joiner` folder

- `sh dep_installer_debian.sh` or `sh dep_installer_manjaro.sh`

- maybe `nano multi_sn_node_joiner.sh` to edit the network config or the node count etc

- then run `sh multi_sn_node_joiner.sh`

- the script runs vdash to see the info of your nodes with gui! ( use left/right arrows to switch node and q for exit)

if you want to stop all nodes run `sh multi_down.sh`
