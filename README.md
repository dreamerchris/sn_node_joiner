I have an idea about having multiple nodes from one machine without podman or docker

how to use for dreamnet:

tested in debian 10/11 and manjaro

1. 
a. debian: `sudo apt-get install -y git` or if you dont have sudo as root run first `apt install sudo`

b. manjaro `sudo pacman -Syy && sudo pacman -S --noconfirm git`

and now either one liner:

2. a. 
use this one liner for dreamnet - with 20 nodes (needs ports open 12001-12020) also check if dreamnet is live at safenetforum.org or use b option

debian `git clone https://github.com/dreamerchris/dream_sn_node_joiner.git && cd dream_sn_node_joiner && sh dep_installer_debian.sh && sh multi_sn_node_joiner.sh`

manjaro `git clone https://github.com/dreamerchris/dream_sn_node_joiner.git && cd dream_sn_node_joiner && sh dep_installer_manjaro.sh && sh multi_sn_node_joiner.sh`

what it does is:

-adds dreamnet with network.config

-switches to dreamnet

-launches 35 nodes

-the script runs vdash to see the info of your nodes with gui! ( use left/right arrows to switch node and q for exit)

and if you want to restart the nodes:

`sh multi_down.sh && sh multi_sn_node_joiner.sh`

or manually

2. b. 

`git clone https://github.com/dreamerchris/dream_sn_node_joiner.git`

then `cd dream_sn_node_joiner` folder

`sh dep_installer_debian.sh` or `sh dep_installer_manjaro.sh`

maybe `nano multi_sn_node_joiner.sh` to edit the network config or the node count etc

then run `sh multi_sn_node_joiner.sh`

the script runs vdash to see the info of your nodes with gui! ( use left/right arrows to switch node and q for exit)

if you want to stop all nodes run `sh multi_down.sh`



## how to run your own network from your debian/manjaro machine!

On debian:

`sudo apt-get update && sudo apt-get install -y git`

`git clone https://github.com/dreamerchris/dream_sn_node_joiner.git && cd dream_sn_node_joiner`

(make sure you port forward 12000-12035)

`sh dep_installer_debian.sh && sh launch_n_multi_joiner.sh`

^^ this will:
- install the dep and safe cli
- add genesis node and create mynet config
- add 35 nodes

run `sh multi_down.sh` to remove the nodes! 



On manjaro:

`sudo pacman -Syy && sudo pacman -S --noconfirm git`

`git clone https://github.com/dreamerchris/dream_sn_node_joiner.git && cd dream_sn_node_joiner`

(make sure you port forward 12000-12035)

`sh dep_installer_manjaro.sh && sh launch_n_multi_joiner.sh`

^^ this will:
- install the dep and safe cli
- add genesis node and create mynet config
- add 35 nodes

run `sh mutli_down.sh` to remove the node!
