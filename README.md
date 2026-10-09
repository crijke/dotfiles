# My Dotfiles

Personal configuration for macOS (primary) and Fedora, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

| Path                      | What it configures                                        |
| ------------------------- | --------------------------------------------------------- |
| `.zshrc`                  | zsh with oh-my-zsh, aliases, PATH and tool setup          |
| `.tmux.conf`              | tmux with `Ctrl-a` prefix, vi copy mode, session restore  |
| `.config/nvim/`           | Neovim, plugins managed by the built-in `vim.pack`        |
| `.vimrc`, `.vim/`         | Classic Vim setup with vim-plug                           |
| `.local/bin/at-root`      | Runs a command from the root of the current git repo      |
| `.local/bin/update_tools` | Updates Homebrew/dnf packages and Vim plugins             |
| `.local/bin/workenv/`     | Switches between personal and work npm/git/gradle configs |

## Install

```sh
git clone https://github.com/crijke/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer symlinks everything into `$HOME` with Stow. If a file already exists, Stow stops instead of overwriting it, so move the existing file out of the way and run the installer again. Afterwards, it offers to install oh-my-zsh and Neovim with its dependencies.

### Requirements

- GNU Stow
- [nvm](https://github.com/nvm-sh/nvm) and [pyenv](https://github.com/pyenv/pyenv), which `.zshrc` loads on startup
- Homebrew on macOS

### After installing

`.zshrc` expects a few things that are not part of this repo:

```sh
# machine-specific settings and secrets; create it even if it stays empty
touch ~/.zshrc_projects

# build the workenv switcher (its dist/ is not committed)
cd ~/.local/bin/workenv && npm install && npm run build
```

## workenv

`workenv` switches `~/.npmrc`, `~/.gitconfig` and `~/.gradle/gradle.properties` between a personal and a work setup by symlinking them from `~/.workenv/<env>/`:

```
~/.workenv/
├── personal/   .npmrc  .gitconfig  [gradle.properties]
└── work/       .npmrc  .gitconfig  [gradle.properties]
```

```sh
workenv personal   # or: workenv work
workenv list       # show the active environment
```

These files hold credentials and are deliberately kept out of this repo.

## Secret scanning

`install.sh` enables a pre-commit hook (`.githooks/pre-commit`) that runs [gitleaks](https://github.com/gitleaks/gitleaks) on staged changes and blocks commits containing secrets. Install it with `brew install gitleaks`.

## License

[MIT](LICENSE)
