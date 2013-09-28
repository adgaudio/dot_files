# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/alex/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

if [ -f ~/.local/bin/virtualenvwrapper.sh ] ; then
  source ~/.local/bin/virtualenvwrapper.sh
else
  echo "zshrc warning: virtualenvwrapper.sh not found"
fi


autoload -U colors && colors
autoload -U promptinit && promptinit
setopt correct promptsubst

# zsh tab completion menu
zstyle ':completion:*' menu select

# move cursor on cmd line in any mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line

# more cursor stupidity
bindkey "^?" backward-delete-char
bindkey -M vicmd "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey -M vicmd "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey -M vicmd "^H" backward-delete-char
bindkey "^U" kill-line
bindkey -M vicmd "^U" kill-line
bindkey "^[[3~" delete-char
bindkey -M vicmd  "^[[3~" delete-char

# history searching
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey '^F' history-incremental-pattern-search-forward
bindkey -M vicmd '^F' history-incremental-pattern-search-forward
# in vi search, hitting / or ? followed by esc, there's an annoying delay. remove that delay
vi-search-fix() {
zle vi-cmd-mode
zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

. ~/.profile
