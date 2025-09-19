ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git brew macos python docker node npm)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# MacOS
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
alias openobsidian=open

# Fedora
# alias dnfu="sudo dnf upgrade --refresh"
# alias dnfds="sudo dnf distro-sync"
# alias openobsidian=xdg-open

# set local variables in way that remote server usually understand
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fastfetch
alias ff="fastfetch"

# editors
export EDITOR='mvim -v'
alias vim="mvim -v"
alias ws="webstorm ."
alias wse="webstorm1 ."
alias vi="code-insiders ."
alias v="code ."
alias c="cursor ."
alias we="webstorm1 ."
alias w="webstorm ."
alias s="windsurf ."
alias i="idea ."
alias claude="/Users/crijke/.claude/local/claude"
alias tm="task-master"

# path
export PATH=~/.local/bin:$PATH

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"

# serverless
export PATH="$HOME/.serverless/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# node
nvm use --lts > /dev/null
echo
echo "node   " $(node -v)
echo "npm    " $(npm -v)
echo "python " $(pyenv global)

# docker
fpath=(/Users/crijke/.docker/completions $fpath)
autoload -Uz compinit
compinit

# work env switcher
alias workenv='node ~/.dotfiles/bin/workenv/dist/index.js'
workenv list

# project specific settings
source ~/.zshrc_projects


