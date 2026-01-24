# history search by prefix
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

#vi mode
bindkey -v
bindkey -M vicmd '^[[A' history-beginning-search-backward
bindkey -M vicmd '^[[B' history-beginning-search-forward
bindkey -M viins '^[[A' history-beginning-search-backward
bindkey -M viins '^[[B' history-beginning-search-forward

# completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# enable menu select
zmodload zsh/complist
zstyle ':completion:*' menu select

# nicer grouping
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# vi-mode compatibility
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history

function zle-line-init {
    bindkey -M viins '^?' backward-delete-char
    bindkey -M viins '^H' backward-delete-char
}

zle -N zle-line-init

# Configuration of history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt nomatch
unsetopt autocd extendedglob
bindkey -v
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
