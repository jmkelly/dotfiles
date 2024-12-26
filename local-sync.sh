#!/bin/bash

# Use the latest Ubuntu LTS as the base image
# from ubuntu:24.04
# shell script to setup a base dev setup on host

#some setup
#clone my neovim config quick start

NVIM_DIR=$HOME/.config/nvim
CONFIG=$HOME/dotfiles
mkdir -p $HOME/.config/wezterm
#git clone https://github.com/jmkelly/dotfiles.git $TEMP_DIR && \
#backup existing nvim config just in case
if [ -d "$NVIM_DIR" ]; then	
  mv $NVIM_DIR $NVIM_DIR_bak_$(date +%Y%m%d%H%M%S)
fi

cp $CONFIG/.config/nvim $NVIM_DIR -R 
cp $CONFIG/.wezterm.lua $HOME/.config/wezterm/wezterm.lua 
cp $CONFIG/.tmux.conf $HOME/.tmux.conf 
cp $CONFIG/nord.png $HOME/.config/wezterm/nord.png

