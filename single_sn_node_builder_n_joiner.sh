mkdir -p \
	$HOME/github-tmp \
	$HOME/.safe/cli \
	$HOME/.safe/node

git clone https://github.com/maidsafe/safe_network.git ~/github-tmp/
cd ~/github-tmp
cargo build --release
cp ~/github-tmp/target/release/safe ~/.safe/cli/
cp ~/github-tmp/target/release/sn_node ~/.safe/node/
tree  $HOME/.safe
