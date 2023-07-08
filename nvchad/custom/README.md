# Setting up with custom config in different directory to nvim config for nvchad

1.  Install neovim
2.  Following instructions at https://nvchad.com/docs/quickstart/install to install nvchad
3.  `git clone https://github.com/jmkelly/dotfiles.git` into `~` directory
4.  `cd ~/dotfiles/nvchad`
5.  `rm ~./config/nvim/lua/config -R`
6.  `ln -s custom/ ~/.config/nvim/lua/`
