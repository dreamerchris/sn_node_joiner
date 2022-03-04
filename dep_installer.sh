#!/bin/bash
sudo apt -qq update >/dev/null
sudo apt -qq install -y snapd build-essential moreutils >/dev/null
sudo snap install curl
sudo snap install rustup --classic
rustup toolchain install stable
cargo install vdash

rm -rf "$HOME"/.safe # clear out any old files

#get the CLI
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/master/resources/scripts/install.sh | bash
echo ""
echo ""
echo ""
echo $(safe --version) "install complete"

hash -r

safe node install
echo ""
echo ""
echo ""
echo $(safe node bin-version) "install complete"

echo "all deps installed! go run sh multi_sn_node_joiner.sh"
