# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Personal Configuration
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export PATH="$PATH:/opt/nvim-linux64/bin"

alias ip="echo $(curl -s ifconfig.me)"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias gc="git branch --merged main | grep -v 'main' | xargs -n 1 git branch -d"

# Custom Functions
killport () {
  lsof -t -i :$1 | xargs kill -9
}

# Other configurations
unset LESS

# Sourcing powerlevel10k config if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
