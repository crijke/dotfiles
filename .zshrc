ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git brew macos python docker node npm)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# Detect OS
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    # macOS
    test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
    alias openobsidian=open
    export EDITOR='mvim -v'
    alias vim="mvim -v"
elif [[ "$OS" == "Linux" ]]; then
    # Fedora
    alias dnfu="sudo dnf upgrade --refresh"
    alias dnfds="sudo dnf distro-sync"
    alias openobsidian=xdg-open
    export EDITOR='vim'
fi

# set local variables in way that remote server usually understand
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fastfetch
alias ff="fastfetch"

# editors

alias w="webstorm . 2> /dev/null &"
alias ws="webstorm . 2> /dev/null &"
alias vi="code-insiders ."
alias v="code ."
alias c="cursor ."
alias s="windsurf ."
alias i="idea ."
#alias claude="/Users/crijke/.claude/local/claude"
alias tm="task-master"

export PATH="/Users/crijke/.codeium/windsurf/bin:$PATH"
export PATH="/Users/crijke/.antigravity/antigravity/bin:$PATH"

# tools
alias ldo="lazydocker"
alias lgit="lazygit"

# vscode shell integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# path
export PATH=~/.local/bin:$PATH

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

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
alias workenv='node ~/.local/bin/workenv/dist/index.js'
workenv list

# project specific settings
source ~/.zshrc_projects

# opencode
export PATH=/Users/crijke/.opencode/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/opt/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/opt/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

