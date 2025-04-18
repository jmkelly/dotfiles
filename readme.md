# My Ubuntu 24.04 dev setup 

My setup is primary for my C# development. Could be adjusted for any dev with tweaks to the neovim config
It includes

## Install

On a clean ubuntu 24.04 install

#### BEWARE:  This script will remove any existing neovim, tmux, and wezterm configuration and will install software from the internet. Please read the script prior to running.  If you aren't comfortable installing this in your primary system, a virtual machine is a good place to test it out.

```
git clone https://github.com/jmkelly/dotfiles.git
cd dotfiles
./setup.sh
```


## App

- wezterm 
- lazygit
- neovim
    - rosyln language server
    - netcoredbg debugger
    - neotest-dotnet for tests in neovim that also support debugging
- git credential manager
- tmux
- dotnet-8-sdk

## Screenshots

![wezterm](Screenshot%20from%202024-12-05%2020-32-02.png)

![lazygit](Screenshot%20from%202024-12-05%2020-31-53.png)

![neovim](Screenshot%20from%202025-04-18%2015-30-41.png)

![neovim dotnet debugger](Screenshot%20from%202025-04-18%2015-27-04.png)



