alias _count="sort | uniq -c | sort -n "
alias favorite_cmds="history|tr -s ' '|cut -d' ' -f3- |tr '|' '\n' |_count"

####
#General aliases
####
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ..="cd .."
alias ...="cd ../.."
alias db="mysql -uroot -proot"
alias e="emacs"
alias fin="find . -iname"
alias fn="find . -name"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias g="fg"
alias grep="grep --color=auto"
if [ "$ZSH_NAME" = "zsh" ] ; then
  alias killjobs='kill ${${(v)jobstates#*:*:}%=*}'
else
  alias killjobs='kill `jobs -p`' # to kill individual job, do: $ kill %1
fi
[ "`uname`" = "Darwin" ] && alias ls='ls -G' || alias ls='ls --color=auto'
alias ll="ls -ltr"
alias la="ls -a"
alias lla="ls -latr"
which xdg-open 1>/dev/null && alias open="xdg-open" # use open like in mac osx
alias v=vim
alias vmod='vim -p $(git status -s|grep "^ *M"|cut -d" " -f3-|xargs) '
alias screen="screen -xRR -e^Pp"
alias screenn="/usr/bin/screen -e^Pp"
alias tn="tail -n"

####
#Language specific
####
alias pry="bundle exec pry"
#alias rake="bundle exec rake"

#alias ipython="ipython --autoedit-syntax --deep-reload --no-confirm-exit"
alias i="ipython"
alias ic="ipythongui console --profile=empty --pylab"
alias ie="ipythongui console --existing --profile=empty --pylab"
alias nb="ipythongui notebook --pylab=inline --profile=empty"

#####
#Git aliases
#####
alias a="git add"
alias b="git branch"
alias c="git commit"
alias ch="git checkout"
alias d="git diff --color=auto"
alias dc="git diff --cached --color=auto"
alias dum="d upstream/master"
alias newu='d upstream/master $(git merge-base upstream/master HEAD) --stat'
alias gg="git grep --color=auto"
alias l="git log --color=auto --decorate --stat --graph --all"
alias p="git push"
alias pop="git stash pop"
alias f="git fetch"
alias fu="git fetch upstream"
alias pull="git pull"
alias pullf="pull --ff-only"
alias re="git rebase"
alias rea="re -i --autosquash"
alias rea2="git commit -a --fixup HEAD ; rea HEAD~2"
alias re2='st |grep -E "^No local changes to save$" && a=0 || a=1 ; git rebase -i HEAD~2 ;  [ "$a" -eq "1" ] && pop'
alias re3='st |grep -E "^No local changes to save$" && a=0 || a=1 ; git rebase -i HEAD~10 ;  [ "$a" -eq "1" ] && pop'
alias r="git remote -v"
alias st="git stash"
alias s="git status -sb"

alias reu="re upstream/master"
alias red="re origin/development"
alias rem="re origin/master"

alias freu='st |grep -E "^No local changes to save$" && a=0 || a=1 ; fu ; reu ; [ "$a" -eq "1" ] && pop'
alias fred='st |grep -E "^No local changes to save$" && a=0 || a=1 ; f ; red ; [ "$a" -eq "1" ] && pop'
alias frem='st |grep -E "^No local changes to save$" && a=0 || a=1 ; f ; rem ; [ "$a" -eq "1" ] && pop'
alias fremp='frem ; git push'
alias submodule_update='git stash |grep -E "No local changes to save$" && a=0 || a=1 ; git submodule foreach "(git pull --ff-only)"  2>/dev/null ; git commit -am "update submodules" 1>/dev/null ; [ "$a" -eq "1" ] && git stash pop 1>/dev/null'


# OS Specific
if test "`uname`" = "Linux" ; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi
