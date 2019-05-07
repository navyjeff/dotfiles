#--------------------------------------------------------------------------------
# ~/.bash_profile
#--------------------------------------------------------------------------------
# Makes sure bashrc is sourced even in a login shell.
[[ -f ~/.bashrc ]] && . ~/.bashrc

#--------------------------------------------------------------------------------
# Shell settings
#--------------------------------------------------------------------------------
# Enables the use of C-s for `isearch`.
stty -ixon

# Common aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias em='emacs -nw'

# SSH without breaking `TERM`.
alias ssh="TERM=xterm-256color ssh"

# Support for 256 colors and italic text in terminal themes and editors.
export TERM=xterm-24bit

#--------------------------------------------------------------------------------
# History
#--------------------------------------------------------------------------------
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=500000
export HISTFILESIZE=500000
shopt -s histappend

# Save history immediately after a command.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#--------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------
# Changes theme for xfce4-terminal.
#
# Usage:
# ```bash
# terminal-theme dark
# terminal-theme light
# ```
function terminal-theme {
  case $1 in
    "dark")
      sed                                      \
        -n -e '/^ColorBackground=/!p'          \
        -e '$aColorBackground=#1c1c1c1c1c1c'   \
        -i ~/.config/xfce4/terminal/terminalrc

      sed                                      \
        -n -e '/^ColorForeground=/!p'          \
        -e '$aColorForeground=#ffffff'         \
        -i ~/.config/xfce4/terminal/terminalrc

      export PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
      echo "export PS1=\"$PS1\"" > ~/.extend.bash_profile
      clear
      ;;
    "light")
      sed                                      \
        -n -e '/^ColorBackground=/!p'          \
        -e '$aColorBackground=#ffffff'         \
        -i ~/.config/xfce4/terminal/terminalrc

      sed                                      \
        -n -e '/^ColorForeground=/!p'          \
        -e '$aColorForeground=#000000'         \
        -i ~/.config/xfce4/terminal/terminalrc

      export PS1='\[\033[00;32m\][\u@\h\[\033[01;30m\] \W\[\033[00;32m\]]\$\[\033[00m\] '
      echo "export PS1=\"$PS1\"" > ~/.extend.bash_profile
      clear
      ;;
    *)
      echo "Usage: terminal-theme [dark|light]"
  esac
}

#--------------------------------------------------------------------------------
# TMUX
#--------------------------------------------------------------------------------
# Creates a new tmux session for each non-tmux shell.
[[ $TMUX == "" ]] && [[ $(type -p tmux) ]] && tmux new-session
