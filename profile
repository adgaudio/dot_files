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

source_files() {
  if [ -f "$HOME/.bash_profile" ] ; then
    . ~/.bash_profile
  fi
  local sources
  [ -n "$BASH" -o -n "$ZSH_NAME" ]  && sources="1" || sources="0"
  if [ "$sources" = "1" ] ; then
      . ~/.bash_aliases
      . ~/.bash_extras
      . ~/.bash_functions
      if [ -f "$HOME/.bash_alluvium" ] ; then
        . ~/.bash_alluvium
      fi
  fi
}
source_files
