alias ...='cd ../..'
alias ..='cd ..'
alias .='pwd'
alias cp='cp -i'
alias emacs='emacs -nw'
alias ll='ls -l'
alias mv='mv -i'
alias rm='rm -i'
alias s='cd ~-'
alias svndiff='svn diff --diff-cmd diff -x -b'
alias svnst='svn st | grep ^M'
if [ "$TERM" != "dumb" ]; then
    alias ls='ls -h --color=auto'
fi
