####
#General aliases
####
alias db="mysql -uroot -proot"
alias e="emacs"
alias grep="grep --color=auto"
alias ipython="ipython --autoedit-syntax --deep-reload --no-confirm-exit"
alias i=ipython
alias killjob='kill $(jobs -p)'
alias ll="ls -ltr"
alias la="ls -a"
alias lla="ls -latr"
which xdg-open 1>/dev/null && alias open="xdg-open" # use open like in mac osx
alias v=vim
alias screen="screen -xRR -e^Pp"
alias screenn="/usr/bin/screen -e^Pp"

####
#Ruby specific
####
alias rake="bundle exec rake"

#####
#Git aliases
#####
alias a="git add $@"
alias b="git branch $@"
alias c="git commit $@"
alias ch="git checkout $@"
alias d="git diff $@"
alias l="git log $@"
alias pop="git stash pop"
alias re="git rebase $@"
alias r="git remote -v $@"
alias stash="git stash"
alias s="git status $@"
