#!/usr/bin/env bash


function install_dotfiles {
  stow .
}


function install_oh_my_zsh {
  read -p "install zsh? [yn]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
    chsh -s `which zsh`
    ln -svf "$PWD/zshrc" "$HOME/.zshrc"
  fi
}

install_dotfiles
install_oh_my_zsh

