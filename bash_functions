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
