ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git brew macos python docker node npm tmux)
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
alias w="at-root webstorm . 2> /dev/null &"
alias ws="at-root webstorm . 2> /dev/null &"
alias vi="at-root code-insiders ."
alias v="at-root code ."
alias c="at-root cursor ."
alias s="at-root windsurf ."
alias i="at-root idea ."
alias tm="task-master"

# tools
alias ldo="lazydocker"
alias lgit="lazygit"

#tmux
alias tns="tmux new -s"

export PATH="/Users/crijke/.codeium/windsurf/bin:$PATH"
export PATH="/Users/crijke/.antigravity/antigravity/bin:$PATH"
export PATH="/Users/crijke/.lmstudio/bin:$PATH"
export PATH="/Users/crijke/.antigravity-ide/antigravity-ide/bin:$PATH"
export PATH="/Users/crijke/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# shell integrations
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# worktrunk
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d $PYENV_ROOT/shims ]] && export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# serverless
export PATH="$HOME/.serverless/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# node
nvm use --lts > /dev/null

# docker
fpath=(/Users/crijke/.docker/completions $fpath)
autoload -Uz compinit
compinit

# shell welcome screen
echo
echo "ip     " $( ipconfig getifaddr en0)
echo "node   " $(node -v)
echo "npm    " $(npm -v)
echo "python " $(pyenv global)

# work env switcher
alias workenv='node ~/.local/bin/workenv/dist/index.js'
workenv list

# project specific settings
source ~/.zshrc_projects

