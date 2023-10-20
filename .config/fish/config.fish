if status is-interactive

# Color script
# bash ~/.config/scripts/pacman-ghosts.sh
### aliases

# todo
alias todo='nvim TODO'
alias TODO='nvim TODO'
# cd
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .......='cd ../../../../'
alias .......='cd ../../../../'

# misc
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vim='nvim' # it's just simply better
alias ls='ls --color=auto'
alias lsa='ls -a'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'
alias lf='ls -lF'
alias lt='ls --human-readable --size -1 -S --classify'
alias df='df -h' # list drives in neat manner
alias du='du -h' 
alias gh='history | grep' #grep history
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias root='sudo -i'
alias su='sudo -i'
alias timeshift='sudo -E timeshift-gtk'
alias matrix='cmatrix'
alias fetch='neofetch'

# systemctl 
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias logout='sudo logout'
alias suspend='sudo systemctl suspend'
alias bye='sudo systemctl poweroff'
alias hibernate='sudo systemctl hibernate'

# funny
alias please 'sudo (history --merge -- | tail -n 1)'
alias rtfm='man'
# alias wtf='which'
alias gtfo='exit'
alias bork='rm -rf'
alias yolo='git push -f'
alias moo='cow say'
alias upupdowndownleftrightleftrightba='echo super secret command'
alias haxor='sudo -i'
alias gimme='git clone'
alias taskman='btop'

# arch
alias update='sudo pacman -Syu'
alias upgrade='sudo pacman -Syu'
alias remove='sudo pacman -Rns'
alias search='sudo pacman -Ss'
alias install='sudo pacman -S'
alias downgrade='sudo downgrade'

# shortcuts
alias dl ='cd ~/Downloads'
alias docs ='cd ~/Documents'
alias pics ='cd ~/Pictures'
alias vids ='cd ~/Videos'
alias music='cd ~/Music'
alias todo='nvim ~/Documents/todo'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# python 
alias pydoc='python -m pydoc' # like man pages for python

# neovim aliases
alias journal="nvim -u ~/.config/nvim/journal.vim"
alias TODO="nvim -u ~/.config/nvim/journal.vim ~/.config/nvim/todo.txt"
alias todo="nvim -u ~/.config/nvim/journal.vim ~/.config/nvim/todo.txt"


# metronome
function metronome
    if count $argv > /dev/null
        set bpm $argv[1]
        play -n -c1 synth 0.004 sine 2000 pad (awk "BEGIN { print 60/$bpm -.004 }") repeat -
    else
        echo "Usage: metronome <bpm>"
    end
end

# Pink Noise with Volume Control
alias pinknoise='play -n synth pinknoise vol 0.15' # Adjust 0.5 for your preferred volume (0.0 to 1.0)

# Brown Noise with Volume Control
alias brownnoise='play -n synth brownnoise vol 0.15'

# White Noise with Volume Control
alias whitenoise='play -n synth whitenoise vol 0.15'

# speedtest 
alias speedtest='speedtest-cli --secure'

# wiki-tui
alias wiki='wiki-tui'

# color shell scripts
alias pokemon='pokemon-colorscripts -r'
alias ghosts='bash ~/.config/scripts/pacman-ghosts.sh'
alias blocks='bash ~/.config/scripts/blocks.sh'
alias bar='bash ~/.config/scripts/color-bars.sh'

# pipes alias
alias pipes='pipes-rs'
alias pipes2='pipes-rs -p 25 -t .2 -b true'

### Exports
export EDITOR='nvim'
export PAGER='nvim'
export MANPAGER='nvim +Man!'
export VISUAL='nvim'
export YAY_PAGER='less'

fish_config theme choose "Dracula Official"


end
