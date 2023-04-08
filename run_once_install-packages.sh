#!/bin/sh
sudo apt install zsh

if [ -d ~/.oh-my-zsh ]; then
  echo "oh-my-zsh is already installed"
else
  echo "installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
