
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
