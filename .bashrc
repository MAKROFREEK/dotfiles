# ==========================================
# ~/.bashrc
# ==========================================

# ==========================================
# 1. AUTO-COMPLETIONS
# ==========================================
# Enable programmable completion features (if not already enabled in /etc/bash.bashrc)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ==========================================
# 2. PROMPT & COLORS
# ==========================================
# Color Definitions
RESET='\[\033[0m\]'
C_BRACKET='\[\033[1;37m\]' # Bold White
C_USER='\[\033[1;32m\]'    # Bold Green
C_HOST='\[\033[1;36m\]'    # Bold Cyan
C_DIR='\[\033[1;34m\]'     # Bold Blue

# Clean PS1 prompt using uppercase \W (current directory only)
export PS1="${C_BRACKET}[${C_USER}\u${RESET}@${C_HOST}\h ${C_DIR}\W${C_BRACKET}]${C_RESET}\$ "

# ==========================================
# 3. ALIASES
# ==========================================
# Color enhancements
alias ls='ls --color=auto -F'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Shortcuts & Utilities
alias fetch='fastfetch'
alias please='sudo !!'
# alias vimide='vim -u ~/.ide-vimrc' # An experiment really

# Safety net (interactive prompts)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ==========================================
# 4. EXPORTS & ENVIRONMENT
# ==========================================
export EDITOR='vim'
export VISUAL='vim'
export SUDO_EDITOR='vim'
export MANPAGER="vim -M +MANPAGER -"
export BROWSER='w3m'

# History Tweaks (Great for completion & navigation)
HISTCONTROL=ignoredups:erasedups  # No duplicate entries
HISTSIZE=10000                    # Larger memory history
HISTFILESIZE=20000                # Larger file history
shopt -s histappend               # Append to history, don't overwrite

# ==========================================
# 5. PATH
# ==========================================
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

