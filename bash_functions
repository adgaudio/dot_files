####
# Docker dev box
####
# http://nathanleclaire.com/blog/2014/07/12/10-docker-tips-and-tricks-that-will-make-you-sing-a-whale-song-of-joy/


_d_base() {
  echo ""\
    "docker run -it --rm "\
    "-v /var/run/docker.sock:/var/run/docker.sock "\
    "-h ""$1"\
    "-e BOX_NAME=""$1"
}

_d_ssh() {
    echo ""\
    "-v ""$SSH_AUTH_SOCK"":/tmp/ssh_auth_sock"\
    " -e SSH_AUTH_SOCK=/tmp/ssh_auth_sock"\
    "-v ""$HOME""/.ssh:/home/dev/.ssh:ro "
}

function _d_mount_s(){
  echo "-v ""$HOME""/s:/home/dev/s -w /home/dev"
}

function dev() {
  local name="dev.$$"
  local cmd="${@:-bash --login}"
  `_d_base "$name"` \
  `_d_ssh` \
    --name "$name" \
    `_d_mount_s` \
    adgaudio/devbox $cmd
}

function _d_x11() {
  local XSOCK=/tmp/.X11-unix
  local XAUTH=/tmp/.docker.xauth
  touch $XAUTH
  xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
  echo ""\
    "-v $XSOCK:$XSOCK:rw "\
    "-v $XAUTH:$XAUTH:rw "\
    "--env=\"DISPLAY\" "\
    "--env=\"XAUTHORITY=${XAUTH}\" "\
    "--privileged "
}

function printer() {
  # init printer container

  local name="printer.$$"
  local cmd="${@:-bash --login}"

  `_d_base "$name"` \
  `_d_ssh` \
  `_d_x11` \
    --name "$name" \
    -v $HOME/s/dot_files:/home/dev/s/dot_files \
    -v $HOME/s/printer:/home/dev/s/printer \
    -w /home/dev/s/printer \
    adgaudio/printer $cmd
}

function drun(){
  `_d_base ${1:-tmp.$$}` \
    `_d_mount_s` \
    -v `pwd`:/home/dev/cwd \
    -w /home/dev/cwd \
    $@
}

function da () { docker start $1 && docker attach $1; }

function de(){
  local name="$1"
  shift
  args="${@:-bash --login}"
  docker start $name
  docker exec -it $name $args;
}

function dr(){ docker rm $@; }

function ds(){ docker commit $@; }

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

