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
  # leverage awk to slice and dice columnar data
  # echo a,b,c,d e f g,h | col 1                --->>>    a,b,c,d
  # echo a,b,c,d e f g,h | col 1 ,              --->>>    a
  # echo a,b,c,d e f g,h | col 1,3 ,            --->>>    a,c
  # echo a,b,c,d e f g,h | col 1,3 , --DELIM--  --->>>    a--DELIM--c
  # echo a,b,c,d e f g,h | col '$(NF-1)' ,      --->>>    d e f g
  # Doesn't currently select a range of columns
  delimiter=
  test $2 && delimiter="-F $2"
  test $3 && output_field_separator="-v OFS=$3" || output_field_separator=""

  cols=",$1"
  cols=${cols//,/, \$}
  cols=${cols/, /}
  awk $delimiter $output_field_separator "{print $cols}"
  echo "--> awk $delimiter $output_field_separator \"{print $cols\"}" &>2
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

