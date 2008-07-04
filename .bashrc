# my simple prompt
PS1="\u@\H [\W] $"

default_title() {
    echo -ne "\033]0;${USER}@${HOSTNAME} : ${PWD}\007"
    # Whenever displaying the prompt, write the previous line to disk
    history -a
}

# If this is an xterm set the title to user@host: dir
case "$TERM" in
    xterm*|rxvt*)
	PROMPT_COMMAND=default_title
	;;
    *)
	;;
esac

# aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# When changing directory small typos can be ignored by Bash
shopt -s cdspell

# Append each line to the history individually
shopt -s histappend

# Don't put duplicate lines in the history and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

export HISTSIZE=1000

# Ctrl+D conveniently exits Bash, sometimes too conveniently
export IGNOREEOF=1

export EDITOR='/usr/bin/emacs -nw'

export CDPATH='.:..:../..:~/dev'

# caps lock -> tab
xmodmap -e "clear Lock"
xmodmap -e "keycode 66 = Tab ISO_Left_Tab"

# extate setup
source /home/david/fulldetails/profile.sh
