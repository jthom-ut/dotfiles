#!/usr/bin/env zsh

echo "Welcome to Jonathan's dotfiles! Let's set things up."

echo "Updating package list..."
sudo apt-get update -y

echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo "Installing Ripgrep..."
sudo apt-get install ripgrep

echo "Setting zsh as default shell..."
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

source ~/.zshrc

echo "Installing powerlevel10k..."
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Installing packer..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "Linking configuration files [.zshrc, .p10k.zsh, init.lua, .gitconfig]..."
rm -rf ~/.zshrc
ln -s /workspaces/.codespaces/.persistedshare/dotfiles/zshrc ~/.zshrc
ln -s /workspaces/.codespaces/.persistedshare/dotfiles/p10k.zsh ~/.p10k.zsh
rm -rf ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim
ln -s /workspaces/.codespaces/.persistedshare/dotfiles/init.lua ~/.config/nvim/init.lua
rm -rf ~/.gitconfig
ln -s /workspaces/.codespaces/.persistedshare/dotfiles/gitconfig ~/.gitconfig

source ~/.zshrc

echo "Installing neovim plugins..."
# Done twice because it fails the first time 🤪
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "You're all done! 🍾"
