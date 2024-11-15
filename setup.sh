# Use the latest Ubuntu LTS as the base image
# from ubuntu:24.04
# shell script to setup a base dev setup on host
#install wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

# Update the package list and install necessary packages
sudo apt-get update && sudo apt-get install -y software-properties-common curl wget git npm fontconfig unzip ripgrep fd-find dotnet-sdk-8.0 wezterm && sudo rm -rf /var/lib/apt/lists/*

# Install a Nerd Font (e.g., FiraCode Nerd Font)
FONT_NAME=JetBrainsMono
FONT_VERSION=v3.2.1

sudo mkdir -p /usr/share/fonts/nerdfonts && \
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/$FONT_NAME.zip -O /tmp/$FONT_NAME.zip && \
    sudo unzip /tmp/$FONT_NAME.zip -d /usr/share/fonts/nerdfonts/ && \ fc-cache -fv && \
	sudo rm /tmp/$FONT_NAME.sip


# install lazygit from source
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
	#sudo rm lazygit* -R 


# install neovim and add to path
NEOVIM_VERSION=0.10.1
INSTALL_DIR=/opt/nvim

curl -LO https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage && \
	sudo chmod u+x nvim.appimage && \
	./nvim.appimage --appimage-extract && \
	mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# set up neovim configurations (optional, you can add more configurations as needed)
mkdir -p $HOME/.config/wezterm

#clone my neovim config quick start
sudo rm -rf $HOME/.config/nvim && sudo rm -rf $HOME/dotfiles  && \
	git clone https://github.com/jmkelly/dotfiles.git $HOME/dotfiles && \
	cp $HOME/dotfiles/.config/nvim $HOME/.config/nvim -R && \
	cp $HOME/dotfiles/.wezterm.lua $HOME/.config/wezterm/wezterm.lua && \
	cp $HOME/dotfiles/nord.png $HOME/.config/wezterm/nord.png

GCM_VERSION=2.6.0
GCM_APP="gcm-linux_amd64.$GCM_VERSION.deb"
wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v$GCM_VERSION/$GCM_APP
sudo dpkg -i $GCM_APP
