runs 20 nodes of sn_node (see safenetforum.org) as systemctl services

either one liner:
(works on debian you need sudo apt-get install git moreutils it will launch 20 nodes with port 12001-12020)
git clone https://github.com/dreamerchris/multi_sn_node_joiner.git && cd multi_sn_node_joiner && sudo chmod u+x multi_sn_node_joiner.sh && sh multi_sn_node_joiner.sh

or manually
git clone https://github.com/dreamerchris/multi_sn_node_joiner.git
then cd into multi_sn_node_joiner folder
then run sh multi_sn_node_joiner.sh

if you want to stop all nodes run multi_down.sh
