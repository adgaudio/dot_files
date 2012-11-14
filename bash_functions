####
# alexgaudio.com
####

function ag
{
    workon alexgaudio
    ( cd ~/.priv/projects/django/alexgaudio && ./dmanage.py runserver )
    cd ~/.priv/projects/django/alexgaudio
}

####
# GIT
####
function s
{
    if [ "$1" != "" ] ; then
        cd $1
    fi
    echo "pwd:" `pwd`
    echo "git status"
    echo
    git status
    if [[ "$1" != "" ]] ; then
       echo
       echo -n "pwd:"
       cd -
    fi
}

####
# Aliases that need params
####

function ackl
{
    ack --color $@ | less -R
}
function col()
{
  # echo a,b,c,d e f g,h | column "1"
  # echo a,b,c,d e f g,h | column "2" ,
  # echo a,b,c,d e f g,h | column "NF-1"
  delimiter=
  test $2 && delimiter="-F $2"
  awk $delimiter "{print \$($1)}"
}


####
# Utility Functions
#####

function ifexists
{
    if [ -e $1 ]
    then
        . $1
    fi
}

function try
{
    $1>/dev/null
    rc="$?"
    if [ "$rc" -ne "0" ] ; then
        return rc
    fi
}

function except
{
    if [ "$?" -ne "0" ] ; then
        $1
    fi
}

function safewrap
{
  (
  set -e
  $1
  set +e
  )
}

