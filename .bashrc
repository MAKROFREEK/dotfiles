#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias please='sudo !!'
bind 'TAB:menu-complete'


export MANPAGER="vim +Man!"
export EDITOR='vim'
export VISUAL='vim'
export SUDO_EDITOR='vim'

# Colors
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"
GREEN="\[\e[32m\]"
GRAY="\[\e[90m\]"
RESET="\[\e[0m\]"

export PS1="${CYAN}\u${WHITE}@${GREEN}\h ${GRAY}>> ${RESET}"
