alias ...='cd ../..'
alias ..='cd ..'
alias .='pwd'
alias cp='cp -i'
alias emacs='emacs -nw'
alias semacs='sudo emacs -nw'
alias firefox='firefox &> /dev/null &'
alias ll='ls -l'
alias mv='mv -i'
alias rm='rm -i'
alias s='cd ~-'
alias savepackages='dpkg --get-selections > .packages'
alias update='sudo apt-get update && sudo apt-get dist-upgrade'

if [ "$TERM" != "dumb" ]; then
    alias ls='ls -h --color=auto'
fi

# svn
alias svndiff='svn diff --diff-cmd diff -x -b'
alias svnst='svn st | grep ^[ACDM]'

# git
alias gitdiff='git diff --color'
alias gitrm='git status | grep deleted | cut -f2 | cut -f5 -d" " | xargs git rm'
alias gitsize='git-ls-files | xargs du -ch'
alias gitst='git status | less'
