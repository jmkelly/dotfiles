TEMP_DIR=/tmp/nvim
NEOVIM_VERSION=0.11.1
INSTALL_DIR=/opt/nvim
ARCH=x86_64
FOLDER=nvim-linux-$ARCH
TAR=$FOLDER.tar.gz
OUTFILE=$TEMP_DIR/$TAR

mkdir -p $TEMP_DIR
URL=https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/$TAR

# Download and extract
	wget -q $URL -O $OUTFILE && 
	tar xzf $OUTFILE -C $TEMP_DIR && 
	sudo rm -rf $INSTALL_DIR
	sudo mv $TEMP_DIR/$FOLDER $INSTALL_DIR

# Create a symlink
sudo ln -sf $INSTALL_DIR/bin/nvim /usr/bin/nvim
echo installed neovim to $INSTALL_DIR

# Clean up
rm -rf $TEMP_DIR
