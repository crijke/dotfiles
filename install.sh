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

install_git_hooks() {
  git -C "$DOTFILES_DIR" config core.hooksPath .githooks

  if ! command -v gitleaks >/dev/null 2>&1; then
    echo "warning: gitleaks not found; commits to this repo will be blocked until it is installed" >&2
  fi
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

install_neovim_deps() {
  read -r -p "Install Neovim and its dependencies via Homebrew? [y/N] " reply
  if [[ ! "$reply" =~ ^[Yy]$ ]]; then
    return
  fi

  if ! command -v brew >/dev/null 2>&1; then
    echo "error: Homebrew is not installed or not on PATH" >&2
    return 1
  fi

  brew install neovim tree-sitter-cli ripgrep fd fzf

  # language servers installed by mason need these runtimes
  for cmd in node npm ruby gem; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "warning: $cmd not found; some language servers will fail to install" >&2
    fi
  done
}

install_dotfiles
install_git_hooks
install_oh_my_zsh
install_neovim_deps
