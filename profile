# ~/.profile: executed by the command interpreter for login shells.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

source_files() {
  local sources
  [ -n "$BASH" -o -n "$ZSH_NAME" ]  && sources="1" || sources="0"
  if [ "$sources" = "1" ] ; then
      . ~/.bash_aliases
      . ~/.bash_extras
      . ~/.bash_functions
      . ~/.bash_sailthru
  fi
  if [ -f "$HOME/.bash_profile" ] ; then
    . ~/.bash_profile
  fi
}
source_files
