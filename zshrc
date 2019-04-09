# zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="simple"
plugins=(git brew osx python docker node npm)
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

# homebrew
export PATH=~/.bin:/usr/local/sbin:/usr/local/bin:$PATH

# nodejs n
export N_PREFIX=~/.n
export PATH=$N_PREFIX/bin:$PATH

# java
export JAVA_HOME=$(/usr/libexec/java_home)

# python
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/miniconda3/etc/profile.d/conda.sh" ]; then
        . "~/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# go
export PATH=/usr/local/go/bin:$PATH

# docker
alias dockerstopa='docker stop $(docker ps -a -q)'
alias dockerrma='docker rm -f $(docker ps -aq)'
alias dockerrmia='docker rmi -f $(docker images -aq)'

# project specific settings
source ~/.zshrc_projects

# fortune
echo && fortune

