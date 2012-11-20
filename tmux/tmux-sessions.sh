# Automatically create a new session with these windows

#Register sessions that will be created by this script
SESSIONS="hi daemons"
#
#Define logic
#
function has-session {
    tmux has-session -t $1
    rc="$?"
    if [ "$rc" -eq "0" ] ; then
        return 0
    fi
    return 1
}

function list-sessions {
    echo $( tmux list-sessions | cut -d: -f1 | sort -r )
}

function try-attach 
{
    has-session $1
    rc="$?"
    attached="$( tmux list-clients -t $1 )"
    
    if [ "$rc" -eq "0" ] && [ ! "$attached" ]; then
        (tmux attach -t $1)
    else
        return 1
    fi
}

function except 
{
    if [ "$?" -eq 1 ] ; then
        $@
    fi
}

#
# Session Configuration
#
function session-fwk 
{
    tmux new-session -d -s fwk
    tmux neww -k -n sreports -t fwk:1
    tmux neww -k -n prod -t fwk:2 
    
    tmux send-keys -t fwk:1 ''
    tmux send-keys -t fwk:2 ''
}

function session-daemons
{
    tmux new-session -d -s daemons
    tmux neww -k -n managepy -t daemons:0 
    tmux neww -k -t daemons:1
    tmux split-window -t daemons:1.0
    tmux split-window -t daemons:1.0
    tmux split-window -t daemons:1.0
    tmux split-window -t daemons:1.1
    tmux split-window -t daemons:1.1
    for x in $(seq 0 5) ; do
      tmux send-keys -t daemons:1.$x "ds"$((${x} + 1))
    done
    tmux select-layout -t daemons:1 tiled
    tmux setw -t daemons:1 synchronize-panes on
}

function session-hi
{
    tmux new-session -d -s hi
    tmux neww -k -t hi:1
}

#
# Implementation
#
# Create sessions if they don't exist
for x in $SESSIONS
do
    has-session $x
    except session-$x
done

tmux link-window -dk -s daemons:manage -t hi:0

# Attach to any existing session with no attached clients
for x in $(list-sessions) ; do
    try-attach $x && exit 0
    echo "Couldn't attach to session $x"
done

# if all sessions already attached to,
# create a new one and attach
tmux new













function has-sessions {
    for x in $@ ; do
        tmux has-session -t $x
	rc=$rc+$?
    return rc
    done
}
