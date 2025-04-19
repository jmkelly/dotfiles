#!/bin/bash

# Use the latest Ubuntu 24.04 LTS as the base 
# shell script to setup a base dev setup on host

sudo apt update && sudo apt install -y curl git #git most likely will already be installed, but just in case it isn't
sudo add-apt-repository ppa:dotnet/backports -y

TEMP_DIR=/tmp/dotfiles

mkdir -p $TEMP_DIR
mkdir -p $HOME/.config/wezterm

# clone my dotfiles which to a tmp directory for moving configs around
#
git clone https://github.com/jmkelly/dotfiles.git $TEMP_DIR && \
	#backup existing nvim config just in case if it exists
[ -d $HOME/.config/nvim ] && mv $HOME/.config/nvim $HOME/.config/nvim_bak_$(date +%Y%m%d%H%M%S)
		

cp $TEMP_DIR/.config/nvim $HOME/.config/nvim -R && \
cp $TEMP_DIR/.wezterm.lua $HOME/.config/wezterm/wezterm.lua && \
cp $TEMP_DIR/.tmux.conf $HOME/.tmux.conf && \
cp $TEMP_DIR/nord.png $HOME/.config/wezterm/nord.png

echo "installed neovim config to $HOME/.config/nvim"
echo "installed wezterm config to $HOME/.config/wezterm"
echo "installed tmux config to $HOME/.tmux.conf"

#install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
echo "installed wezterm"

# Update the package list and install necessary packages
# we are install dotnet sdk 8 and 9 so we have both the LTS and current version
sudo apt-get update && sudo apt-get install -y software-properties-common wget npm fontconfig unzip ripgrep fd-find dotnet-sdk-9.0 dotnet-sdk-8.0 wezterm tmux && sudo rm -rf /var/lib/apt/lists/*
echo "installed packages"

# Install a Nerd Font (e.g., FiraCode Nerd Font)
FONT_NAME=JetBrainsMono
FONT_VERSION=v3.2.1

sudo mkdir -p /usr/share/fonts/nerdfonts && 
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/$FONT_NAME.zip -O /tmp/$FONT_NAME.zip && 
	sudo unzip /tmp/$FONT_NAME.zip -d /usr/share/fonts/nerdfonts/ &&  fc-cache -fv && 
	sudo rm /tmp/$FONT_NAME.zip

echo "installed nerd font $FONT_NAME $FONT_VERSION"


# install lazygit from source
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
sudo rm lazygit.tar.gz

echo "installed lazygit $LAZYGIT_VERSION"


NEOVIM_VERSION=0.10.4
INSTALL_DIR=/opt/nvim
ARCH=x86_64
FOLDER=nvim-linux-$ARCH
TAR=$FOLDER.tar.gz
OUTFILE=$TEMP_DIR/$TAR

URL=https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/$TAR

# Download and extract
	wget -q $URL -O $OUTFILE && 
	tar xzf $OUTFILE -C $TEMP_DIR && 
	sudo mv $TEMP_DIR/$FOLDER $INSTALL_DIR

# Create a symlink
sudo ln -sf $INSTALL_DIR/bin/nvim /usr/bin/nvim
echo installed neovim to $INSTALL_DIR


#install powershell
PWSH_VERSION=7.4.6
wget "https://github.com/PowerShell/PowerShell/releases/download/v$PWSH_VERSION/powershell_$PWSH_VERSION-1.deb_amd64.deb"
sudo dpkg -i powershell_$PWSH_VERSION-1.deb_amd64.deb
sudo rm powershell_$PWSH_VERSION-1.deb_amd64.deb

echo "installed powershell $PWSH_VERSION"
#
# GCM_VERSION=2.6.0
# GCM_APP="gcm-linux_amd64.$GCM_VERSION.deb"
# wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v$GCM_VERSION/$GCM_APP
# sudo dpkg -i $GCM_APP
# sudo rm $GCM_APP
# git-credential-manager configure
#
# git config --global credential.credentialStore cache
# #set the github creds by logging into github
# git-credential-manager github login

#cleanup
rm $TEMP_DIR -rf

echo "✅ Dev environment setup complete."

