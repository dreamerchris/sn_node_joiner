#!/bin/bash
sudo apt -qq update >/dev/null
sudo apt -qq install -y snapd build-essential moreutils >/dev/null
sudo snap install curl
sudo snap install rustup --classic
rustup toolchain install stable
cargo install vdash
