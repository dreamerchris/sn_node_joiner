#!/bin/bash

echo "apt update"
sudo apt -qq update >/dev/null && echo "apt update success!" || echo "ERROR apt update failed"

echo "installing snapd build-essential moreutils tree unzip"
sudo apt -qq install -y snapd build-essential moreutils tree unzip >/dev/null && echo "snapd build-essential moreutils tree unzip installed!" || echo "ERROR some or all failed to install! (snapd build-essential moreutils tree unzip)"

echo "installing curl through snap"
sudo snap install curl && echo "curl installed!" || echo "ERROR curl failed to install!"

echo "installing rust through snap"
sudo snap install rustup --classic && echo "rust first install command success!" || echo "ERROR first rust install command failed!"
PATH=$PATH:$HOME/.safe/cli:/usr/local/bin/:/snap/bin
echo "continue to installing rust"
rustup toolchain install stable && echo "rust second install command success!" || echo "ERROR second rust install command failed!"

echo "installing vdash"
cargo install vdash && echo "vdash installed!" || echo "ERROR vdash failed to install"

#get the CLI
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/master/resources/scripts/install.sh | bash
echo ""
echo ""
echo ""
echo $(safe --version) "install complete"



$HOME/.safe/cli/safe node install || /usr/local/bin/safe node install
echo ""
echo ""
echo ""
echo $(safe node bin-version) "install complete"

echo "all deps installed! go run sh multi_sn_node_joiner.sh"
