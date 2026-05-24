#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_dotfiles() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow is not installed or not on PATH" >&2
    exit 1
  fi
  
  stow --dir="$DOTFILES_DIR" --target="$HOME" --restow .
}


install_oh_my_zsh() {
  read -r -p "Install oh-my-zsh? [y/N] " reply
  if [[ ! "$reply" =~ ^[Yy]$ ]]; then
    return
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
  fi

  if command -v zsh >/dev/null 2>&1 && [[ "${SHELL:-}" != "$(command -v zsh)" ]]; then
    chsh -s "$(command -v zsh)"
  fi
}

install_dotfiles
install_oh_my_zsh
