#!/bin/bash
mkdir -p \
	$HOME/github-tmp \
	$HOME/.safe/cli \
	$HOME/.safe/node

git clone https://github.com/maidsafe/safe_network.git $HOME/github-tmp/
cd $HOME/github-tmp
cargo build --release
cp $HOME/github-tmp/target/release/safe $HOME/.safe/cli/
cp $HOME/github-tmp/target/release/sn_node $HOME/.safe/node/
tree  $HOME/.safe

PATH=$PATH:/$HOME/.safe/cli

echo "now launch single_sn_node_joiner or multi_sn_node_joiner"
