if status is-interactive
# aliases
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .......='cd ../../../../'
alias .......='cd ../../../../'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vim='nvim'
alias ls='ls --color=auto'
alias lsa='ls -a'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias lf='ls -lF'
alias lt='ls --human-readable --size -1 -S --classify'

alias df='df -h' # list drives in neat manner
alias du='du -h' # 
alias gh='history | grep' #grep history

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias root='sudo -i'
alias su='sudo -i'

alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias logout='sudo logout'
alias suspend='sudo systemctl suspend'
alias bye='sudo systemctl poweroff'
alias hibernate='sudo systemctl hibernate'


# please
# alias please='sudo'


#debian
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"
alias update='sudo apt-get update && sudo apt-get upgrade'

# shortcuts
alias docs ='cd ~/Documents'
alias pics ='cd ~/Pictures'
alias vids ='cd ~/Videos'
alias music='cd ~/Music'
alias todo='nvim ~/Documents/todo'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

end
