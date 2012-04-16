alias _count="sort | uniq -c | sort -n "
alias favorite_cmds="history|tr -s ' '|cut -d' ' -f3- |tr '|' '\n' |_count"

####
#General aliases
####
alias ..="cd .."
alias ...="cd ../.."
alias db="mysql -uroot -proot"
alias e="emacs"
alias fin="find . -iname"
alias grep="grep --color=auto"
alias killjobs='kill $(jobs -p)' # to kill individual job, do: $ kill %1
alias ll="ls -ltr"
alias la="ls -a"
alias lla="ls -latr"
which xdg-open 1>/dev/null && alias open="xdg-open" # use open like in mac osx
alias v=vim
alias screen="screen -xRR -e^Pp"
alias screenn="/usr/bin/screen -e^Pp"

####
#Language specific
####
alias rake="bundle exec rake"
#alias ipython="ipython --autoedit-syntax --deep-reload --no-confirm-exit"
alias i=ipython

#####
#Git aliases
#####
alias a="git add"
alias b="git branch"
alias c="git commit"
alias ch="git checkout"
alias d="git diff"
alias dc="git diff --cached"
alias l="git log --color=auto --decorate"
alias p="git push"
alias pop="git stash pop"
alias f="git fetch"
alias re="git rebase"
alias r="git remote -v"
alias stash="git stash"
alias s="git status -sb"


