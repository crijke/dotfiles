ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git brew macos python docker node npm)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# iterm2
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# set local variables in way that remote server usually understand
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# general / homebrew
export EDITOR='mvim -v'
alias vim="mvim -v"
alias ws="webstorm ."
alias wse="webstorm1 ."

# homebrew
export PATH=~/.bin:/opt/homebrew/sbin:/opt/homebrew/bin:$PATH
export HOMEBREW_NO_GITHUB_API=true

# go
export PATH=/usr/local/go/bin:$PATH

# python
export PATH=/opt/homebrew/opt/python/libexec/bin:$PATH

# ruby
eval "$(rbenv init - zsh)"

# serverless
export PATH="$HOME/.serverless/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# node
# NODE_OPTIONS=--max_old_space_size=8192
nvm use --lts > /dev/null
echo
echo node $(node -v)
echo npm $(npm -v)

# postgres
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# rust
source "$HOME/.cargo/env"


# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# thefuck
eval $(thefuck --alias)


# work env switcher
alias workenv='node ~/.dotfiles/bin/workenv/dist/index.js'
workenv list


# project specific settings
source ~/.zshrc_projects

echo
fortune
echo
#echo && fortune |  cowsay

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/crijke/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
